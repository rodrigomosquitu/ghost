terraform {
  backend "s3" {
    encrypt = true
    bucket  = "nord-cloud-penguin"
    region  = "us-east-1"
    key     = "tfstate/terraform.tfstate"
    access_key = "AKIATP75CTMU6C4MSZ2F"
    secret_key = "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"
  }
}
