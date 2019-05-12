resource "google_compute_router" "router" {
  name    = "nat-router"
  network = "default"
  region  = "us-central1"
  project = "${google_project.experiments-vpc-host.project_id}"
}

resource "google_compute_router_nat" "nat" {
  name                               = "nat"
  router                             = "${google_compute_router.router.name}"
  project                            = "${google_project.experiments-vpc-host.project_id}"
  region                             = "us-central1"
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"
}

