# --- Build Stage ---
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci

COPY . .
RUN npm run build

# --- Runtime Stage ---
FROM nginx:alpine-slim

# Copy build artifacts
WORKDIR /usr/share/nginx/html
COPY --from=build /app/dist .

# Copy the config (Ensure you updated nginx.conf to "listen 8080;")
COPY nginx.conf /etc/nginx/conf.d/default.conf

# OpenShift specific permission fixes:
# 1. We use GID 0 (root group) because OpenShift assigns a random UID in this group.
# 2. We make sure Nginx can write its PID and cache files.
RUN chmod -R 775 /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html && \
    chgrp -R 0 /var/cache/nginx /var/run /var/log/nginx /usr/share/nginx/html && \
    chmod -R g=u /etc/passwd

# Optional: Tell Nginx to put its PID file in a writable directory
# Some Nginx versions try to write to /var/run/nginx.pid which may fail
RUN sed -i '1s/^/pid \/tmp\/nginx.pid;\n/' /etc/nginx/nginx.conf

# OpenShift runs as a random UID, but 1001 is a good local testing placeholder
USER 1001

# Switch to a non-privileged port
EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
