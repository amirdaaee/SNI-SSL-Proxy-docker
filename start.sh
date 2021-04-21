#/bin/sh
# todo: better stdout
echo "listen address    " $BIND_ADDRESS
echo "number of workers   " $WORKERS_NO
if ! [[ -z "${USE_TOR}" ]]; then
  if [[ -z "${UPSTREAM_SOCKS}" ]]; then
    export UPSTREAM_SOCKS="127.0.0.1:9050"
  fi
  tor &
fi
if ! [[ -z "${UPSTREAM_SOCKS}" ]]; then
  echo "upstram socks5   " $UPSTREAM_SOCKS
  ./sniproxy -a $BIND_ADDRESS -w $WORKERS_NO --socks5 $UPSTREAM_SOCKS &
else
  ./sniproxy -a $BIND_ADDRESS -w $WORKERS_NO &
fi
wait