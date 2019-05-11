provider "google" {
  project     = "${var.admin_project}"
  version     = "~> 2.0.0"
}

resource "google_folder" "admin" {
  display_name = "IT Administration Projects"
  parent     = "organizations/${var.org_id}"
}

resource "google_project" "infrastructure" {
  name = "Infrastructure as Code Project"
  project_id = "${var.terraform_backend_project}"
  folder_id  = "${google_folder.admin.name}"
  billing_account = "${var.billing_account}"
}

resource "google_storage_bucket" "tf-gcs-store" {
  name = "${var.terraform_backend_bucket}"
  location = "US"
  project = "${google_project.infrastructure.project_id}"
  storage_class = "MULTI_REGIONAL"
  versioning = {
    enabled = true
  }
}
