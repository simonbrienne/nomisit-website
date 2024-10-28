# Project ID
project = "nomisit-website"

# Region for resources
region = "europe-west1"

# Bucket name for hosting website
bucket_name = "nomisit_website_bucket"

# Main and error pages
index_page    = "index.html"
not_found_page = "404.html"

# Path to Google Cloud credentials file
credentials_file = "nomisit-website-43823182c6de.json"

# Domains for the SSL certificate
ssl_domains = ["nomis-it.com", "www.nomis-it.com"]

# Name for the reserved IP address
ip_name = "nomisit-website-ip"

# Backend bucket name for load balancer
backend_bucket_name = "nomisit-website-backend-bucket"

# URL map name
url_map_name = "nomisit-website-url-map"

# HTTP and HTTPS proxy names
http_proxy_name  = "nomisit-website-http-proxy"
https_proxy_name = "nomisit-website-https-proxy"

# Forwarding rule name
forwarding_rule_name = "https-forwarding-rule"

# SSL certificate name
ssl_certificate_name = "nomisit-website-ssl-cert"