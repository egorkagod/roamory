
# Простая сборка статического лендинга на nginx + HTTPS (Let's Encrypt)
# Предполагается, что сертификаты будут лежать в /etc/letsencrypt (смонтированный volume)

FROM nginx:1.27-alpine

LABEL maintainer="roamory@mail.ru"

RUN apk add --no-cache certbot

# Копируем наш конфиг nginx
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Копируем статический сайт
COPY index.html /usr/share/nginx/html/index.html
COPY logo.jpg /usr/share/nginx/html/logo.jpg

# Webroot (на случай использования webroot-плагина)
RUN mkdir -p /var/www/certbot

# Скрипт, который сначала запрашивает сертификат, затем запускает nginx
COPY docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

EXPOSE 80 443

ENTRYPOINT ["/docker-entrypoint.sh"]
