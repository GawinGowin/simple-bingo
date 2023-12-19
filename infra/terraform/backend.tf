terraform {
 backend "gcs" {
   bucket  = "edd47589ac908a01-bucket-tfstate-araki"
   prefix  = "terraform/state/server"
 }
}