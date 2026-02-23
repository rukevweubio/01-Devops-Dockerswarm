
FROM node:18-alpine AS build

WORKDIR /app

COPY package*.json ./
RUN npm ci


COPY . .
RUN npm run build


FROM nginx:alpine-slim


RUN addgroup -S appgroup && adduser -S appuser -G appgroup


WORKDIR /usr/share/nginx/html


COPY --from=build /app/dist .


COPY nginx.conf /etc/nginx/conf.d/default.conf


RUN mkdir -p /var/cache/nginx/client_temp /var/run/nginx \
    && chmod -R 777 /var/cache/nginx /var/run/nginx \
    && chmod -R 755 /usr/share/nginx/html /etc/nginx/conf.d

)
USER 1001

EXPOSE 80


CMD ["nginx", "-g", "daemon off;"]
