provider "google" {
  credentials = file("my-gcp-cred.json")
  project = "project-id"
  region = "europe-west3"
  zone = "europe-west3-c"
}

// export GOOGLE_CLOUD_KEYFILE_JSON="gcp-creds.json"

resource "google_compute_instance" "my_server" {
  name = "my-gcp-server"
  machine_type = "e2-micro"
  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-9"
    }
  }
  network_interface {
    network = "default"
  }
}
