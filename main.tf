terraform {
  backend "s3" {
    bucket = "panbucket1411677"
    key    = "tf-state"
    region = "us-east-1"
  }
}
