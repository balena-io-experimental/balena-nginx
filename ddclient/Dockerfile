FROM balenalib/raspberrypi4-64-debian:latest-run


RUN apt-get update && apt-get install libio-socket-ssl-perl && apt-get install ddclient


RUN cp /run/secrets/ddclient.conf /etc/ddclient.conf
COPY ddclient_start.sh /tmp/ddclient_start.sh
RUN chmod +x /tmp/ddclient_start.sh

CMD ["/tmp/ddclient_start.sh"]
