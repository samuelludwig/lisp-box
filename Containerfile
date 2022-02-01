FROM docker.io/library/alpine 

RUN apk --no-cache add \
    autoconf \
    automake \
    build-base \
    cmake \
    ninja \
    coreutils \
    curl \
    gettext-tiny-dev \
    git \
    libtool \
    pkgconf \
    unzip

RUN git clone https://github.com/janet-lang/janet.git

WORKDIR janet

RUN make && make test && make install

WORKDIR /

RUN git clone https://github.com/janet-lang/jpm.git

WORKDIR jpm

RUN janet bootstrap.janet

WORKDIR /

RUN rm -r /janet /jpm

