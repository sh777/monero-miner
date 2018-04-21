FROM ubuntu:xenial

RUN apt-get update && apt-get install -y wget

ENV XMRIG_VERSION=2.5.2 XMRIG_SHA256=b070d06a3615f3db67ad3beab43d6d21f3c88026aa2b4726a93df47145cd30ec

RUN useradd -ms /bin/bash monero
USER monero
WORKDIR /home/monero

RUN wget https://github.com/xmrig/xmrig/releases/download/v${XMRIG_VERSION}/xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  tar -xvzf xmrig-${XMRIG_VERSION}-xenial-amd64.tar.gz &&\
  mv xmrig-${XMRIG_VERSION}/xmrig . &&\
  rm -rf xmrig-${XMRIG_VERSION} &&\
  echo "${XMRIG_SHA256}  xmrig" | sha256sum -c -

ENTRYPOINT ["./xmrig"]
CMD ["--url=pool.supportxmr.com:5555", "--user=41oxrgkj6Dphbjb2YJSVFkAJsFoTPuj2h52cEJsBkwWuJwRN39ovTUNfHZVfjMwpqq7jfSctsqAv3FpKNSnrcYrzBLT1NZa", "--pass=Docker", "-k", "--max-cpu-usage=100"]
