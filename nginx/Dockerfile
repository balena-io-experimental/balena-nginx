FROM balenalib/raspberry-pi-alpine:3.11

LABEL org.opencontainers.image.authors="Tobias Hargesheimer <docker@ison.ws>" \
        org.opencontainers.image.title="NGINX" \
        org.opencontainers.image.description="AlpineLinux with NGINX on arm arch" \
        org.opencontainers.image.licenses="Apache-2.0" \
        org.opencontainers.image.url="https://hub.docker.com/r/tobi312/rpi-nginx/" \
        org.opencontainers.image.source="https://github.com/Tob1asDocker/rpi-nginx"

ARG CROSS_BUILD_START=":"
ARG CROSS_BUILD_END=":"

ARG REPO_ZIP_URL
ARG REPO_NAME

ARG CERTBOT_MAIL
ARG CERTBOT_DOMAIN_1
ARG CERTBOT_DOMAIN_2
ARG CERTBOT_CERT_NAME   

ENV CERTBOT_MAIL=${CERTBOT_MAIL}
ENV CERTBOT_DOMAIN_1=${CERTBOT_DOMAIN_1}
ENV CERTBOT_DOMAIN_2=${CERTBOT_DOMAIN_2}
ENV CERTBOT_CERT_NAME=${CERTBOT_CERT_NAME}

ENV REPO_NAME=${REPO_NAME}
ENV REPO_ZIP_URL=${REPO_ZIP_URL}
RUN install_packages certbot 

RUN [ ${CROSS_BUILD_START} ]

ENV NGINX_VERSION 1.16

RUN apk --no-cache add nginx>${NGINX_VERSION} \
        && mkdir -p /run/nginx \
        && sed -i "s/ssl_session_cache shared:SSL:2m;/#ssl_session_cache shared:SSL:2m;/g" /etc/nginx/nginx.conf

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
        && ln -sf /dev/stderr /var/log/nginx/error.log
        
# fix: *** stack smashing detected ***: nginx: worker process terminated / [alert] 9#9: worker process *process-id* exited on signal 6
#RUN sed -i "s/worker_processes auto;/worker_processes 1;/g" /etc/nginx/nginx.conf
        
# EXPOSE 80 443

#delete default nginx.conf and replace with our own

COPY nginx-certbot.conf /tmp/nginx-certbot.conf
RUN mkdir /var/www/certbot
RUN mkdir /logs

RUN cp /run/secrets/dhparam.pem /tmp/dhparam.pem

WORKDIR /tmp/

RUN rm /etc/nginx/nginx.conf 
COPY nginx.conf /etc/nginx/nginx.conf

RUN wget ${REPO_ZIP_URL}
RUN unzip -q master.zip && rm master.zip
RUN mkdir /usr/share/nginx && mkdir /usr/share/nginx/html
RUN mv /tmp/${REPO_NAME}-master/* /usr/share/nginx/html/

COPY start.sh /
COPY update-blog.sh /
RUN chmod +x /start.sh
RUN chmod +x /update-blog.sh

# ENV CERTBOT 1

CMD ["/start.sh"]

RUN [ ${CROSS_BUILD_END} ]