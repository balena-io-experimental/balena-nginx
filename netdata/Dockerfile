FROM netdata/netdata

RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py

RUN python /tmp/get-pip.py
RUN pip install docker

RUN ln -s /var/run/balena.sock /var/run/docker.sock
# COPY docker /usr/libexec/netdata/python.d/python_modules/docker

ENTRYPOINT ["/usr/sbin/run.sh"]
