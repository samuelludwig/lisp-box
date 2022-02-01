FROM docker.io/library/alpine AS base

#
# Get the core utils
#
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
    libgcc \
    pkgconf \
    unzip

#
# Install janet + jpm
#
RUN git clone https://github.com/janet-lang/janet.git

WORKDIR janet

RUN make && make test && make install

WORKDIR /

RUN git clone https://github.com/janet-lang/jpm.git

WORKDIR jpm

RUN janet bootstrap.janet

WORKDIR /

RUN rm -r /janet /jpm

RUN jpm install spork

#
# Install neovim
#

# Build neovim (and use it as an example codebase
RUN git clone https://github.com/neovim/neovim.git

ARG VERSION=master
RUN cd neovim && git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo install && rm -rf /neovim

# # Copy over neovim files
# COPY /usr/local/lib/nvim /usr/local/lib/nvim
# COPY /usr/local/share/nvim /usr/local/share/nvim
# COPY /usr/local/bin/nvim /usr/local/bin/nvim

# Copy over magic-kit
WORKDIR /.config

RUN git clone https://github.com/Olical/magic-kit.git ~/.config/nvim

COPY ./scripts /usr/local/bin

ENTRYPOINT bash
