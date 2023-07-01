module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "3.14.0"
}
output "s3_bucket_name" {
  value = module.s3-bucket.s3_bucket_bucket_domain_name
}