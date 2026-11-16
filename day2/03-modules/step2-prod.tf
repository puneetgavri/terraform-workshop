# Same module, second environment.
module "storage_prod" {
  source = "./modules/storage"

  name        = "shopfast-prod-media"
  environment = "prod"
  tags        = { Project = "ShopFast" }
}

output "prod_bucket" {
  value = module.storage_prod.bucket_name
}
