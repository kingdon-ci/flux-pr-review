#!/bin/bash

## Not Used - this strategy was obviated by gemsets and upstream support
## The script 'jenkins/rvm-bundle-cache-build.sh' is not used anymore.

if [[ -z "$1" ]]; then
  echo "Must provide RUBY_VERSION as first argument" 1>&2
  echo "(Example: 'RUN $0 \${RUBY}' in Dockerfile)" 1>&2
  exit 1
fi

set -euo pipefail
RUBY_VERSION=$1

# Dockerfile has passed RUBY_VERSION in as the first argument
rvm ${RUBY_VERSION} do bundle install
mkdir -p /tmp/vendor

# Dockerfile has mounted a buildkit cache at /tmp/.cache/bundle/ – It is not
# part of the image and will not remain present in the image filesystem after
# this script is run, so we take a copy here for later stages to copy from.
cp -ar /tmp/.cache/bundle/ /tmp/vendor/bundle

# Tell bundler from here too, where the next layer can to find the gem cache
bundle config set path /tmp/vendor/bundle
