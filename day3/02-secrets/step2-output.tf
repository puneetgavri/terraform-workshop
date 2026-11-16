# Try removing "sensitive = true" and running plan to see Terraform refuse.
output "db_password" {
  value     = aws_ssm_parameter.db_password.value
  sensitive = true
}
