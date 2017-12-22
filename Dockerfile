FROM ubuntu:17.04

RUN \
  apt-get update && apt-get upgrade -q -y && \
  apt-get install -y --no-install-recommends golang git make curl gcc libc-dev ca-certificates && \
  git clone --depth 1 --branch release/1.7 https://github.com/ethereum/go-ethereum && \
  (cd go-ethereum && make geth) && \
  cp go-ethereum/build/bin/geth /usr/bin/geth && \
  apt-get remove -y golang git make gcc libc-dev && apt autoremove -y && apt-get clean && \
  rm -rf /go-ethereum

# Listen for connections on <port> (default: 30303)
EXPOSE 30303

# Listen for JSON-RPC connections on <port> (default: 8545)
# custom port for rpc
EXPOSE 8545

ENV ETH_DATA /data
VOLUME /data
RUN ln -sfn $ETH_DATA /root/.ethereum

COPY docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod a+x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
