terraform {
  backend "s3" {
    encrypt = true
    bucket  = "nord-cloud-penguin"
    region  = "us-east-1"
    key     = "tfstate/terraform.tfstate"
    access_key = "AKIATP75CTMU3ZDQQXVN"
    secret_key = "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"
  }
}
