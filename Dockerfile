FROM alpine:latest as build
WORKDIR /server
RUN set -x \
    && apk add --update --no-cache curl tar  autoconf automake build-base libtool
COPY ./SNI-SSL-Proxy sni-ssl-proxy.build ./
RUN sh ./sni-ssl-proxy.build

FROM alpine:latest as sni-ssl-proxy
WORKDIR server
COPY --from=build /server/bin ./
COPY ./start.sh ./
ENV SNIPROXY_ARG_A="0.0.0.0" SNIPROXY_ARG_W="8"
CMD ["sh","start.sh"]