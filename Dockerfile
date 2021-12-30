FROM python:3.7-alpine

LABEL MAINTAINER="Soroush Kaviani <daniel@pryorda.net>"
LABEL NAME=vmware_exporter_soroush

WORKDIR /opt/vmware_exporter/
COPY . /opt/vmware_exporter/

RUN set -x; buildDeps="gcc python3-dev musl-dev libffi-dev openssl openssl-dev rust cargo bash" \
 && apk add --no-cache --update $buildDeps \
 && pip install -r requirements.txt . \
 && apk del $buildDeps

EXPOSE 9272

ENV PYTHONUNBUFFERED=1

ENTRYPOINT ["/usr/local/bin/vmware_exporter", "-c" , "/opt/vmware_exporter/config.yml"]
