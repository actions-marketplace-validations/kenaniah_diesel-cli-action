#!/usr/bin/env bash
set -eou pipefail

 while IFS=',' read -ra DIRECTORY_LIST; do
      for directory in "${DIRECTORY_LIST[@]}"; do
          pushd $directory
          diesel database setup
          popd
      done
 done <<< "${WORKING_DIRECTORIES:-.}"
