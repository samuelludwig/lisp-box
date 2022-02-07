FROM docker.io/library/alpine AS janet

RUN apk --no-cache add \
    autoconf \
    automake \
    build-base \
    cmake \
    coreutils \
    git

#
# Install janet + jpm
#
RUN git clone https://github.com/janet-lang/janet.git /janet

RUN git clone https://github.com/janet-lang/jpm.git /jpm



FROM docker.io/library/alpine AS neovim

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
# Python + Hy setup
#

#
# Clojure + Clojurescript setup
#

#
# Neovim setup
#

# Build neovim (and use it as an example codebase
RUN git clone https://github.com/neovim/neovim.git /neovim



FROM docker.io/library/fedora

RUN dnf update -y && dnf groupinstall -y "Development Tools" && dnf install -y cmake automake libgcc gcc gcc-c++ make coreutils git ninja-build curl gettext unzip pkgconf autoconf libtool

# Build neovim
COPY --from=neovim /neovim /neovim
ARG VERSION=master
RUN cd /neovim && git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo && make install && rm -rf /neovim

# # Copy over neovim files
# COPY --from=neovim /usr/local/lib/nvim /usr/local/lib/nvim
# COPY --from=neovim /usr/local/share/nvim /usr/local/share/nvim
# COPY --from=neovim /usr/local/bin/nvim /usr/local/bin/nvim

# Copy over magic-kit
RUN mkdir -p ~/.config

# Copy in magic-kit files
RUN git clone https://github.com/Olical/magic-kit.git ~/.config/nvim


# Bring over janet
RUN mkdir -p /usr/local/bin
COPY --from=janet /janet /janet
COPY --from=janet /jpm /jpm
RUN cd /janet && make && make test && make install

RUN cd /jpm && janet bootstrap.janet && cd / && rm -r /jpm && jpm install spork

COPY ./scripts /usr/local/bin

WORKDIR /workbench

ENTRYPOINT bash
