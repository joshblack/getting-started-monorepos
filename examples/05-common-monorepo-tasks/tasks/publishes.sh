#!/bin/bash

source ./tasks/setup.sh

# Start in e2e/ even if run from root directory
cd "$(dirname "$0")"

# Go to root
cd ..
root_path=$PWD

# Verify local registry has started
/bin/bash ./tasks/wait-for-it.sh "$custom_registry"

# Set registry to local registry
npm set registry "$custom_registry_url"
yarn config set registry "$custom_registry_url"

# Login so we can publish packages
npx npm-cli-login@0.0.10 -u user -p password -e user@example.com \
  -r "$custom_registry_url" --quotes

# Publish the monorepo
./node_modules/.bin/lerna publish --yes --force-publish=* --skip-git \
  --cd-version=prerelease --exact --npm-tag=latest

# Cleanup
cleanup
