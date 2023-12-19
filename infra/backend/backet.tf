resource "random_id" "bucket_prefix" {
  byte_length = 8
}

locals {
  bucket_name = "${random_id.bucket_prefix.hex}-bucket-tfstate-araki"
}

resource "google_storage_bucket" "default" {
  name          = local.bucket_name
  force_destroy = false
  location      = "ASIA-NORTHEAST1"
  storage_class = "STANDARD"
  project       = data.google_client_config.default.project
  uniform_bucket_level_access = true
  versioning {
    enabled = true
  }
  encryption {
    default_kms_key_name = google_kms_crypto_key.key-asia.id
  }
  lifecycle {
    prevent_destroy = true
  }
  # depends_on = [
  #   google_project_iam_member.key_role
  # ]
}

# # related iam permission
# resource "google_project_iam_member" "key_role" {
#   project = data.google_client_config.default.project
#   role    = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
#   member = "serviceAccount:service-${data.google_project.project.number}@gs-project-accounts.iam.gserviceaccount.com"
# }

# resource "google_project_iam_member" "storage_role" {
#   project = data.google_client_config.default.project
#   role    = "roles/storage.objectUser"
#   member  = "serviceAccount:service-${data.google_project.project.number}@gs-project-accounts.iam.gserviceaccount.com"
# }
