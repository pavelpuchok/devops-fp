terraform {
  backend "gcs" {
    bucket = "pp-devops-fp-storage"
    prefix = "gitlab-runner-tf-state"
  }
}
