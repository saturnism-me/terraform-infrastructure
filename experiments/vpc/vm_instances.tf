resource "google_compute_instance" "vpc-project-1-instance" {
  project = "${google_project.experiments-project-1.project_id}"
  name = "vpc-project-1-instance"
  zone = "us-central1-c"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "projects/${google_project.experiments-vpc-host.project_id}/regions/us-central1/subnetworks/default"
  }

  
}

resource "google_compute_instance" "vpc-project-2-instance" {
  project = "${google_project.experiments-project-2.project_id}"
  name = "vpc-project-2-instance"
  zone = "us-central1-c"
  machine_type = "n1-standard-1"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }

  network_interface {
    subnetwork = "projects/${google_project.experiments-vpc-host.project_id}/regions/us-central1/subnetworks/default"
  }

  
}

