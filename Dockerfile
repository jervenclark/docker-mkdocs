FROM python:alpine3.9

MAINTAINER  Jerven Clark Chua <jervenclark@gmail.com>

RUN apk add --no-cache --virtual .build-deps g++ python3-dev libffi-dev openssl-dev
RUN apk add --no-cache --update python3
RUN python3 -m ensurepip && rm -r /usr/lib/python*/ensurepip
RUN  if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
  if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi && \
  pip3 install --upgrade pip setuptools mkdocs
RUN rm -r /root/.cache

RUN mkdir /project

COPY ./entrypoint.sh /

EXPOSE 8000

ENTRYPOINT ["/entrypoint.sh"]
