terraform {
  backend "s3" {
    bucket = "tweek-bucket345426"
    region = "us-east-2"
    key    = "terraform-01/terraform.tfstate"
  }
}