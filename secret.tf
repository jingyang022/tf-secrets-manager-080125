resource "aws_secretsmanager_secret" "yap_DB_secret" {
  name = "yapDBcreds"
  recovery_window_in_days = 7
}

resource "aws_secretsmanager_secret_version" "sversion" {
  secret_id = aws_secretsmanager_secret.yap_DB_secret.id
  secret_string = <<EOF
   {
    "YapRDSDBPassword": ""
   }
EOF
}