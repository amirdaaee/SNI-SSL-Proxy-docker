FROM alpine:latest as build
WORKDIR /server
RUN set -x \
    && apk add --update --no-cache curl tar  autoconf automake build-base libtool
COPY ./SNI-SSL-Proxy sni-ssl-proxy.build ./
RUN sh ./sni-ssl-proxy.build

FROM alpine:latest as sni-ssl-proxy
WORKDIR server
RUN set -x \
    && apk add --update --no-cache tor \
    && rm -rf /var/cache/apk/*
COPY --from=build /server/bin ./
COPY start.sh ./
ENV BIND_ADDRESS="0.0.0.0" WORKERS_NO="1"
CMD ["sh","./start.sh"]