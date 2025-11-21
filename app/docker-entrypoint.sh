#!/bin/sh
set -e

# Домен и email по умолчанию можно переопределить через переменные окружения
DOMAIN="${LETSENCRYPT_DOMAIN:-roamory.ru}"
EMAIL="${LETSENCRYPT_EMAIL:-roamory@mail.ru}"

CERT_DIR="/etc/letsencrypt/live/${DOMAIN}"

echo "Using domain: ${DOMAIN}"

if [ ! -f "${CERT_DIR}/fullchain.pem" ] || [ ! -f "${CERT_DIR}/privkey.pem" ]; then
  echo "No existing certificate found. Requesting Let's Encrypt certificate for ${DOMAIN}..."
  certbot certonly \
    --standalone \
    --preferred-challenges http \
    -d "${DOMAIN}" -d "www.${DOMAIN}" \
    --email "${EMAIL}" \
    --agree-tos \
    --non-interactive \
    --rsa-key-size 4096
else
  echo "Existing certificate found for ${DOMAIN}, skipping certificate request."
fi

echo "Starting nginx..."
exec nginx -g "daemon off;"

