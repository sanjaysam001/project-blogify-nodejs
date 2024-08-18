
terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "5.38.0"
    }
  }
}

provider "google" {
    project = "my-terraform-project-428807"  #give your project name
    region = "asia-south1"         
    credentials = "./my-terraform-project-key.json"  #change as per location of your key
}
