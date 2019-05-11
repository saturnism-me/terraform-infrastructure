provider "google" {
  version = "~> 2.0.0"
}

resource "google_folder" "experiments" {
  display_name = "Experimental Projects"
  parent     = "organizations/${var.org_id}"
}

module "experiments-vpc" {
  source = "vpc"

  org_id = "${var.org_id}"
  billing_account = "${var.billing_account}"
  parent_folder_id = "${google_folder.experiments.id}"
  xpn-admin-members = "${var.xpn-admin-members}"
}

