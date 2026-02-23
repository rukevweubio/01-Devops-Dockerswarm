# Build stage
FROM node:18-alpine as build

WORKDIR /app


COPY package*.json ./


RUN npm ci


COPY . .


RUN npm run build


FROM nginx:alpine-slim 
)
RUN addgroup -S appgroup && adduser -S appuser -G appgroup


WORKDIR /usr/share/nginx/html


COPY --from=build /app/dist .


COPY nginx.conf /etc/nginx/conf.d/default.conf


RUN chown -R appuser:appgroup /usr/share/nginx/html /etc/nginx/conf.d

# Switch to non-root user
USER appuser

# Expose port 80
EXPOSE 80

# Start nginx
CMD ["nginx", "-g", "daemon off;"]
