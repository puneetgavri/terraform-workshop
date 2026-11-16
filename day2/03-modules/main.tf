# Use the storage module for dev.
module "storage_dev" {
  source = "./modules/storage"

  name        = "shopfast-dev-media"
  environment = "dev"
  tags        = { Project = "ShopFast" }
}

output "dev_bucket" {
  value = module.storage_dev.bucket_name
}
