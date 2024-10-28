# Use the official Nginx image
FROM nginx:alpine

# Copy index.html to the default Nginx public folder
COPY src/public/index.html /usr/share/nginx/html/index.html

# Exposed port
EXPOSE 80

# Run Nginx
CMD ["nginx", "-g", "daemon off;"]