FROM python:alpine3.9

MAINTAINER  Jerven Clark Chua <jervenclark@gmail.com>

RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev && \
  apk add --no-cache --update python3 && \
  python3 -m ensurepip && rm -r /usr/lib/python*/ensurepip && \
  if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
  if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
  pip3 install --upgrade pip setuptools mkdocs mkdocs-bootswatch && \
  rm -r /root/.cache && \
  apk del .build-deps

RUN mkdir /project

EXPOSE 8000

WORKDIR /project

CMD ["mkdocs", "serve", "-a", "0.0.0.0:8000"]
