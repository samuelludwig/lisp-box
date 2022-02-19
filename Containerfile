FROM docker.io/library/fedora

RUN mkdir -p ~/.config
RUN mkdir -p ~/workbench

#
# Install basic development tools and utils
#
RUN dnf update -y && dnf groupinstall -y "Development Tools" && dnf install -y coreutils
RUN dnf install -y cmake automake make gcc gcc-c++ libgcc
RUN dnf install -y \
      git \
      unzip \
      pkgconf \
      autoconf \
      libtool \
      curl \
      wget \
      fuse \
      fuse-libs

RUN dnf install -y sqlite

COPY ./scripts /scripts

#
# Install Neovim AppImage
#
#RUN bash /scripts/install-neovim.sh
# Build neovim (and use it as an example codebase
RUN git clone https://github.com/neovim/neovim.git

ARG VERSION=master
RUN cd neovim && git checkout ${VERSION} && make CMAKE_BUILD_TYPE=RelWithDebInfo install && rm -rf /neovim

# Install Packer packages, INSTALL env var is a hack
#RUN INSTALL=1 nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

# Bring in our lisp-y config and symlink it to ~/.config/nvim
RUN git clone https://github.com/samuelludwig/cosmic-nvimrc.git ~/workbench/cosmic-nvimrc
RUN ln -s ~/workbench/cosmic-nvimrc ~/.config/nvim


#
# Install Langs of Choice
#

### Node.js+NPM

# Install fnm
RUN curl -fsSL https://fnm.vercel.app/install | bash
# Install nvm
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash

#RUN nvm use 16

#
# Python + Hy setup
#

#
# Clojure + Clojurescript setup
#

#
# Neovim setup
#

WORKDIR ~/workbench

ENTRYPOINT bash
