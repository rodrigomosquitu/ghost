terraform {
  backend "s3" {
    encrypt = true
    bucket  = "nord-cloud-penguin"
    region  = "us-east-1"
    key     = "tfstate/terraform.tfstate"
    access_key = "xxxxxxxxxxxx"
    secret_key = "xxxxxxxxxxxxxxxx"
  }
}
