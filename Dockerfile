FROM python:3.8.9-buster

RUN apt-get update && apt-get install -y --no-install-recommends \
    ca-certificates \
    curl \
    sudo \
    xz-utils \
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
