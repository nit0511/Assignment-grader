FROM python:3.9-slim

WORKDIR /app

# Install dependencies for both applications
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy application files
COPY server.py .
COPY client.py .

# Create uploads directory
RUN mkdir -p /app/uploads

# Install nginx to handle port forwarding
RUN apt-get update && apt-get install -y nginx

# Create nginx configuration
RUN echo 'server { \
    listen 80; \
    location / { \
        proxy_pass http://localhost:8501; \
        proxy_http_version 1.1; \
        proxy_set_header Upgrade $http_upgrade; \
        proxy_set_header Connection "upgrade"; \
        proxy_set_header Host $host; \
    } \
    location /api/ { \
        proxy_pass http://localhost:8088/; \
        proxy_set_header Host $host; \
    } \
}' > /etc/nginx/sites-available/default

# Create startup script
RUN echo '#!/bin/bash \n\
python server.py & \
streamlit run client.py --server.port=8501 --server.address=127.0.0.1 & \
nginx -g "daemon off;"' > /app/start.sh && chmod +x /app/start.sh

# Expose port 80 for Nginx
EXPOSE 80

# Set environment variables
ENV OPENAI_API_KEY=""
ENV GOOGLE_API_KEY=""
ENV SEARCH_ENGINE_ID=""

# Run the start script
CMD ["/app/start.sh"]