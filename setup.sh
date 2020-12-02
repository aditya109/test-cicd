echo "installing go version 1.25.5 .... "
apk add --no-cache --virtual .build-deps bash gcc musl-dev openssl go
wget -O go.tgz https://golang.org/dl/go1.15.5.src.tar.gz
tar -C /usr/local -xzf go.tgz
# shellcheck disable=SC2164
cd /usr/local/go/src/
./make.bash

