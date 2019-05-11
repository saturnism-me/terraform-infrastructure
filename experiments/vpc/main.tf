provider "google" {
  version = "~> 2.0.0"
}

resource "google_folder" "experiments-vpc" {
  display_name = "Experimental VPC Projects"
  parent       = "${var.parent_folder_id}"
}

resource "google_organization_iam_binding" "experiments-vpc-admin" {
  org_id = "${var.org_id}"
  role    = "roles/compute.xpnAdmin"
  members = "${var.xpn-admin-members}"
}

resource "google_folder_iam_binding" "experiments-vpc-admin" {
  folder  = "${google_folder.experiments-vpc.id}"
  role    = "roles/compute.xpnAdmin"
  members = "${var.xpn-admin-members}"
}

resource "google_project" "experiments-vpc-host" {
  name = "VPC Host Project"
  project_id = "experiments-vpc-host"
  folder_id  = "${google_folder.experiments-vpc.name}"
  billing_account = "${var.billing_account}"
}

resource "google_project_services" "experiments-vpc-host-services" {
  project = "${google_project.experiments-vpc-host.project_id}"
  services   = ["compute.googleapis.com", "oslogin.googleapis.com"]
}

resource "google_project" "experiments-project-1" {
  name = "VPC Project 1"
  project_id = "experiments-vpc-project-1"
  folder_id  = "${google_folder.experiments-vpc.name}"
  billing_account = "${var.billing_account}"
}

resource "google_project_services" "experiments-project-1-services" {
  project = "${google_project.experiments-project-1.project_id}"
  services   = ["compute.googleapis.com", "oslogin.googleapis.com"]
}

resource "google_project" "experiments-project-2" {
  name = "VPC Project 2"
  project_id = "experiments-vpc-project-2"
  folder_id  = "${google_folder.experiments-vpc.name}"
  billing_account = "${var.billing_account}"
}

resource "google_project_services" "experiments-project-2-services" {
  project = "${google_project.experiments-project-2.project_id}"
  services   = ["compute.googleapis.com", "oslogin.googleapis.com"]
}

resource "google_compute_shared_vpc_host_project" "experiments-vpc-shared-host" {
  project = "${google_project.experiments-vpc-host.project_id}"

  depends_on = ["google_folder_iam_binding.experiments-vpc-admin", "google_organization_iam_binding.experiments-vpc-admin"]
}

resource "google_compute_shared_vpc_service_project" "project-1" {
  host_project    = "${google_project.experiments-vpc-host.project_id}"
  service_project = "${google_project.experiments-project-1.project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.experiments-vpc-shared-host"]
}

resource "google_compute_shared_vpc_service_project" "project-2" {
  host_project    = "${google_project.experiments-vpc-host.project_id}"
  service_project = "${google_project.experiments-project-2.project_id}"

  depends_on = ["google_compute_shared_vpc_host_project.experiments-vpc-shared-host"]
}

