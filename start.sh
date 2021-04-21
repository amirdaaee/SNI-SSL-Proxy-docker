#/bin/sh
echo "listen address    " $SNIPROXY_ARG_A
echo "number of workers   " $SNIPROXY_ARG_W
if ! [[ -z "${SNIPROXY_ARG_SOCKS}" ]]; then
  echo "upstram socks5   " $SNIPROXY_ARG_SOCKS
  ./sniproxy -a $SNIPROXY_ARG_A -w SNIPROXY_ARG_W --socks5 $SNIPROXY_ARG_SOCKS
else
  ./sniproxy -a $SNIPROXY_ARG_A -w SNIPROXY_ARG_W
fi

