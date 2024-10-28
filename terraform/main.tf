# Terraform configuration for Google provider
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

provider "google" {
  project     = var.project
  region      = var.region
  credentials = file(var.credentials_file)
}

# Create bucket on EU region for hosting website
resource "google_storage_bucket" "nomisit_website_bucket" {
  name     = var.bucket_name
  location = var.region

  website {
    main_page_suffix = var.index_page
    not_found_page   = var.not_found_page
  }
}

# Upload index.html and 404.html to the bucket
resource "google_storage_bucket_object" "indexpage" {
  name         = var.index_page
  source       = "./../src/public/${var.index_page}"
  content_type = "text/html"
  bucket       = google_storage_bucket.nomisit_website_bucket.id
}

resource "google_storage_bucket_object" "errorpage" {
  name         = var.not_found_page
  source       = "./../src/public/${var.not_found_page}"
  content_type = "text/html"
  bucket       = google_storage_bucket.nomisit_website_bucket.id
}

# Upload the CV PDF file to the bucket
resource "google_storage_bucket_object" "cv_pdf" {
  name         = "Simon_Brienne_-_DevOps_Engineer-3.pdf"
  source       = "./../src/docs/Simon_Brienne_-_DevOps_Engineer-3.pdf"
  content_type = "application/pdf"
  bucket       = google_storage_bucket.nomisit_website_bucket.id
}

# Make bucket public
resource "google_storage_bucket_iam_member" "public_rule" {
  bucket = google_storage_bucket.nomisit_website_bucket.name
  role   = "roles/storage.objectViewer"
  member = "allUsers"
}

# Reserve a regional IP address for the Load Balancer
resource "google_compute_address" "website_ip" {
  name         = var.ip_name
  region       = var.region
  network_tier = "STANDARD"
}

# Create a backend bucket for the Load Balancer
resource "google_compute_backend_bucket" "website_backend_bucket" {
  name        = var.backend_bucket_name
  bucket_name = google_storage_bucket.nomisit_website_bucket.name
}

# Create a URL map to direct requests to the backend bucket
resource "google_compute_url_map" "website_url_map" {
  name            = var.url_map_name
  default_service = google_compute_backend_bucket.website_backend_bucket.self_link
}

# Create a target HTTP proxy
resource "google_compute_target_http_proxy" "website_http_proxy" {
  name    = var.http_proxy_name
  url_map = google_compute_url_map.website_url_map.id
}

# Create SSL certificate
resource "google_compute_managed_ssl_certificate" "website_ssl_certificate" {
  name        = var.ssl_certificate_name
  description = "SSL certificate for the website"
  managed {
    domains = var.ssl_domains
  }
}

# Create a target HTTPS proxy
resource "google_compute_target_https_proxy" "website_https_proxy" {
  name             = var.https_proxy_name
  url_map          = google_compute_url_map.website_url_map.id
  ssl_certificates = [google_compute_managed_ssl_certificate.website_ssl_certificate.self_link]
}

# Create HTTPS forwarding rule
resource "google_compute_forwarding_rule" "https_forwarding_rule" {
  name         = var.forwarding_rule_name
  target       = google_compute_target_https_proxy.website_https_proxy.self_link
  port_range   = "443"
  region       = var.region
  ip_address   = google_compute_address.website_ip.address
  network_tier = "STANDARD"
}