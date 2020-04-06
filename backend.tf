terraform {
    backend "s3" {
        bucket = "tflab"
        key    = "${var.state}"
        region = "${var.region}"
    }
}