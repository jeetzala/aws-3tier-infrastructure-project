import os
import json
from http.server import BaseHTTPRequestHandler, HTTPServer

import boto3
import pymysql


# AWS Secrets Manager secret containing the RDS connection details
SECRET_ARN = os.environ["DB_SECRET_ARN"]

secrets_client = boto3.client(
    "secretsmanager",
    region_name="eu-central-1"
)

secret_response = secrets_client.get_secret_value(
    SecretId=SECRET_ARN
)

db_config = json.loads(secret_response["SecretString"])

DB_HOST = db_config["DB_HOST"]
DB_PORT = int(db_config.get("DB_PORT", "3306"))
DB_NAME = db_config["DB_NAME"]
DB_USER = db_config["DB_USER"]
DB_PASSWORD = db_config["DB_PASSWORD"]


def get_users():
    connection = pymysql.connect(
        host=DB_HOST,
        port=DB_PORT,
        user=DB_USER,
        password=DB_PASSWORD,
        database=DB_NAME,
        connect_timeout=5,
        cursorclass=pymysql.cursors.DictCursor
    )

    try:
        with connection.cursor() as cursor:
            cursor.execute(
                "SELECT id, name, email, created_at "
                "FROM users ORDER BY id"
            )
            return cursor.fetchall()
    finally:
        connection.close()


class Handler(BaseHTTPRequestHandler):

    def do_GET(self):
        try:
            users = get_users()

            rows = ""

            for user in users:
                rows += f"""
                <tr>
                    <td>{user['id']}</td>
                    <td>{user['name']}</td>
                    <td>{user['email']}</td>
                    <td>{user['created_at']}</td>
                </tr>
                """

            response = f"""<!DOCTYPE html>
<html>
<head>
    <title>Three-Tier Backend</title>
</head>
<body>
    <h1>Backend Tier</h1>
    <p>three-tier-lab</p>
    <p>Private application server</p>

    <h2>Users from RDS</h2>

    <table border="1" cellpadding="8">
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Created At</th>
        </tr>

        {rows}

    </table>
</body>
</html>
"""

            self.send_response(200)

        except Exception as e:

            response = f"""<!DOCTYPE html>
<html>
<head>
    <title>Backend Error</title>
</head>
<body>
    <h1>Backend Tier</h1>
    <p>Database connection error: {e}</p>
</body>
</html>
"""

            self.send_response(500)

        body = response.encode("utf-8")

        self.send_header(
            "Content-Type",
            "text/html; charset=utf-8"
        )

        self.send_header(
            "Content-Length",
            str(len(body))
        )

        self.end_headers()

        self.wfile.write(body)


server = HTTPServer(
    ("0.0.0.0", 8080),
    Handler
)

server.serve_forever()
