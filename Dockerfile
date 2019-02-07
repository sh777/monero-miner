FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget

ENV XMRIG_VERSION=2.10.0 XMRIG_SHA256=6f186c8930bb2e1256533c1ea920019bc20e50fa0ca49add92a8ca05803bb5d1

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION} &&\
  echo "${XMRIG_SHA256}  xmrig" | sha256sum -c -

ENTRYPOINT ["./xmrig"]
CMD ["--url=pool.supportxmr.com:5555", "--user=41oxrgkj6Dphbjb2YJSVFkAJsFoTPuj2h52cEJsBkwWuJwRN39ovTUNfHZVfjMwpqq7jfSctsqAv3FpKNSnrcYrzBLT1NZa", "--pass=Mike:withoutbug@gmail.com", "-k", "--max-cpu-usage=100"]
