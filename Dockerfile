FROM alpine:3.6

RUN apk add --update --repository http://dl-4.alpinelinux.org/alpine/edge/testing/ tini \
    && apk add python py-pip \
    && rm -rf /var/cache/apk/* \
    && rm -rf /tmp/*

COPY tasks/ /etc/periodic/
RUN chmod -R +x /etc/periodic/

ENTRYPOINT ["tini", "--"]
CMD ["crond", "-f", "-d", "8"]
