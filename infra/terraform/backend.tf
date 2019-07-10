terraform {
  backend "gcs" {
    bucket = "pp-devops-fp-storage"
    prefix = "tf-state"
  }
}
