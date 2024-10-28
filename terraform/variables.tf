variable "project" {
  description = "The Google Cloud project ID"
  type        = string
  default     = "nomisit-website"
}

variable "region" {
  description = "The Google Cloud region"
  type        = string
  default     = "europe-west1"
}

variable "bucket_name" {
  description = "The name of the Google Cloud Storage bucket"
  type        = string
  default     = "nomisit_website_bucket"
}

variable "index_page" {
  description = "The main page for the website"
  type        = string
  default     = "index.html"
}

variable "not_found_page" {
  description = "The error page for the website"
  type        = string
  default     = "404.html"
}

variable "credentials_file" {
  description = "The path to the Google Cloud credentials JSON file"
  type        = string
  default     = "nomisit-website-43823182c6de.json"
}

variable "ssl_domains" {
  description = "The list of domains for the managed SSL certificate"
  type        = list(string)
}

variable "ip_name" {
  description = "The name of the reserved IP for the load balancer"
  type        = string
}

variable "backend_bucket_name" {
  description = "The name of the backend bucket for the load balancer"
  type        = string
}

variable "url_map_name" {
  description = "The name of the URL map"
  type        = string
}

variable "http_proxy_name" {
  description = "The name of the HTTP proxy"
  type        = string
}

variable "https_proxy_name" {
  description = "The name of the HTTPS proxy"
  type        = string
}

variable "forwarding_rule_name" {
  description = "The name of the HTTPS forwarding rule"
  type        = string
}

variable "ssl_certificate_name" {
  description = "The name of the managed SSL certificate"
  type        = string
}
