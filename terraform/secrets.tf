resource "aws_secretsmanager_secret" "rds_credentials" {
  name = "${var.project_name}/rds-credentials"

  lifecycle {
    ignore_changes = [
      force_overwrite_replica_secret,
      recovery_window_in_days
    ]
  }
}
