terraform {
  backend "gcs" {
    bucket  = "saturnism-tf-gcs-store"
    prefix  = "terraform/state/experiments"
  }
}
