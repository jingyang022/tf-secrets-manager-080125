# Key-value pair for RDS password
output "secret_arn" {
  value = aws_secretsmanager_secret.yap_DB_secret.arn
}