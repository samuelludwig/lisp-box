FROM docker.io/library/fedora

RUN mkdir -p ~/.config
RUN mkdir -p ~/workbench

#
# Install basic development tools and utils
#
RUN dnf update -y && dnf groupinstall -y "Development Tools"
RUN dnf install -y \
      cmake \
      automake \
      libgcc \
      gcc \
      gcc-c++ \
      make \
      coreutils \
      git \
      ninja-build \
      gettext \
      unzip \
      pkgconf \
      autoconf \
      libtool \
      curl \
      wget

COPY ./scripts /scripts


#
# Install Neovim AppImage
#
RUN bash /scripts/install-neovim.sh

# Install Packer packages, INSTALL env var is a hack
RUN INSTALL=1 nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'

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

RUN nvm use 16

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
