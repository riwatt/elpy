FROM ubuntu:20.04

# use the base of from github actions: https://github.com/actions/virtual-environments/blob/34ea1d0440d0c8801081276b279d1b232f009a1b/images/linux/Ubuntu2004-README.md
# if we any software then install version from this page

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl=7.68.0-1ubuntu2.5 \
    sudo=1.8.31-1ubuntu1.2 \
    xz-utils=5.2.4-1ubuntu1 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /install

# emacs

## install nix
## based on nix docs

RUN groupadd -r nixbld
RUN for n in $(seq 1 10); do useradd -c "Nix build user $n" -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(command -v nologin)" "nixbld$n"; done
RUN curl -L https://nixos.org/nix/install | sh

ENV PATH=/nix/var/nix/profiles/default/bin/:$PATH

## install emacs (on cachix)
## based on https://github.com/purcell/setup-emacs/blob/9ed6e7ceda15b77751e7806dfc1180196406bbe9/dist/install-nix.sh

RUN nix-env -j8 -iA cachix -f https://cachix.org/api/v1/install

RUN USER=root cachix use emacs-ci

RUN nix-env -iA emacs-27-1 -f "https://github.com/purcell/nix-emacs-ci/archive/master.tar.gz"
