# STEP 1: a database password that must never appear in logs.
variable "db_password" {
  description = "Password for the orders database"
  type        = string
  sensitive   = true
}

resource "aws_ssm_parameter" "db_password" {
  name  = "/shopfast/prod/db_password"
  type  = "SecureString"
  value = var.db_password

  tags = {
    Project = "ShopFast"
  }
}

# STEP 2: uncomment this block (try it without "sensitive = true" first and read the error)
output "db_password" {
  value     = aws_ssm_parameter.db_password.value
  sensitive = true
}
