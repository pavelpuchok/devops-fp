terraform {
  required_version = "~> 0.12.3"

  backend "gcs" {
    bucket = "pp-devops-fp-storage"
    prefix = "tf-state"
  }
}
