if [[ ! -d "/etc/letsencrypt/live/$CERTBOT_CERT_NAME" || "$CERTBOT_FORCED" = "1" ]]; then
    echo "Generating TLS certificate.."
    nginx -c /tmp/nginx-certbot.conf
    certbot certonly --non-interactive --agree-tos --cert-name $CERTBOT_CERT_NAME -m $CERTBOT_MAIL -d $CERTBOT_DOMAIN_1 -d $CERTBOT_DOMAIN_2 --webroot -w /var/www/certbot
    nginx -s stop
    sleep 5s
else 
  echo "TLS certificates were found"
fi
if [ ! -f /etc/letsencrypt/dhparam.pem ]; then
  mv /tmp/dhparam.pem /etc/letsencrypt/dhparam.pem
  echo "Moved DH private key to /etc/letsencrypt/dhparam.pem"
fi
if [[ ! -f /etc/nginx/conf.d/default.conf ]]; then
  :
else
  rm /etc/nginx/conf.d/default.conf
  echo "removed default.conf"
fi
if [[ "$SYNC_WEBSITE" = "1" ]]; then
  echo "SYNC_WEBSITE is enabled, updating website from repository <$REPO_NAME>"
  /update-blog.sh
fi
echo "Webserver has been setup successfully, starting server..."
nginx -g 'daemon off;'