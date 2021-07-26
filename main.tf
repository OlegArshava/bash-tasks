provider "google" {
  credentials = file("terraform-321007-4a7c5c1f74bb.json")
  project     = "terraform-321007"
  region      = "europe-north1"
  zone        = "europe-north1-a"
}

resource "google_compute_firewall" "allow_http" {
  name    = "allow-http-rule"
  network = "default"
  allow {
    ports    = ["80"]
    protocol = "tcp"
  }

  target_tags = ["allow-http"]
}

resource "google_compute_instance" "default" {
 name         = "terraform-instance"
 machine_type = "e2-medium"
 zone         = "europe-north1-a"
 tags = ["allow-http"]
 metadata = {
   ssh-keys = "oleg:${file("~/.ssh/id_rsa.pub")}"
 }

metadata_startup_script = "sudo apt update && sudo apt install apache2 -y"

 boot_disk {
   initialize_params {
     image = "ubuntu-2004-focal-v20210720"
   }

 }

network_interface {
   network = "default"
   
   access_config {

   }
 }
}
