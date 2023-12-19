resource "google_kms_key_ring" "keyring-asia" {
  name     = "storage-bucket-keyring-asia"
  location = "asia-northeast1"
  project = data.google_client_config.default.project
}

resource "google_kms_crypto_key" "key-asia" {
  name            = "storage-bucket-crypto-key-asia"
  key_ring        = google_kms_key_ring.keyring-asia.id
  rotation_period = "100000s"
  lifecycle {
    prevent_destroy = true
  }
}
