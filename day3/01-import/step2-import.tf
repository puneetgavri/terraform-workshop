# Bring the hand-made bucket under Terraform's control.
import {
  to = aws_s3_bucket.marketing
  id = "shopfast-marketing"
}
