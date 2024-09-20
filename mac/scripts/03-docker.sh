#!/bin/bash

set -euo pipefail

brew install colima docker docker-buildx docker-compose kompose kubectl minikube
minikube config set driver docker

# docker plugins
mkdir -p ~/.docker/cli-plugins
ln -sfn "$HOMEBREW_PREFIX/opt/docker-buildx/bin/docker-buildx" ~/.docker/cli-plugins/docker-buildx
ln -sfn "$HOMEBREW_PREFIX/opt/docker-compose/bin/docker-compose" ~/.docker/cli-plugins/docker-compose