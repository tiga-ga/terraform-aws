#!/usr/bin/env bash

# 参考：https://zenn.dev/sre_holdings/articles/35694018e71b99
set -eu -o pipefail

# echo to stderr
eecho() { echo "$@" 1>&2; }

usage() {
  cat <<EOF
Usage:
  bash $(basename "$0") <python-version> <requirements-file>
Description:
  Create lambda layer zip file according to the requirements file.
Requirements:
  docker, jq
Arguments:
  python-version    : Python version
  requirements-file : Path of pip requirements file
EOF
}

# Check number of arguments
if [[ $# != 2 ]]; then
  usage && exit 1
fi

PYTHON_VERSION="$1"
PYTHON_IMAGE="python:${PYTHON_VERSION#python}"
REQUIREMENTS_FILE=$2

if [[ ! -f ${REQUIREMENTS_FILE} ]]; then
  eecho "[ERROR] requirements file '${REQUIREMENTS_FILE}' not found."
  exit 1
fi

DEST_DIR=$(mktemp -d)

cp "${REQUIREMENTS_FILE}" "${DEST_DIR}"

(
  cd "${DEST_DIR}"
  mkdir python

  # Run pip install command inside the official python docker image
  docker run --rm -u "${UID}:${UID}" -v "${DEST_DIR}:/work" -w /work "${PYTHON_IMAGE}" pip install -r "${REQUIREMENTS_FILE##*/}" -t ./python >&2

  # Remove unneeded files
  find python \( -name '__pycache__' -o -name '*.dist-info' \) -type d -print0 | xargs -0 rm -rf
  rm -rf python/bin

  # Return JSON for Terraform
  jq -n --arg path "${DEST_DIR}" '{"path":$path}'
)