terraform {
    backend "s3" {
        bucket = "tflab"
        key    = "terraform.tfstate"
        region = "us-west-2"
    }
}