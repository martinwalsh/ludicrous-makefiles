#!/bin/bash
export OLD_PATH=$PATH

unset_term() {
  unset TERM
}

fixtures() {
  export FIXTURES_ROOT="$BATS_TEST_DIRNAME/fixtures/$1"
  export PATH=$FIXTURES_ROOT/bin:$PATH
}

cleanup() {
  export PATH=$OLD_PATH
}

debug() {
  printf '===> status <===\n%s\n' "$1"
  shift
  printf '===> output <===\n%s\n' "$1"
  shift
  echo "===> lines <==="
  locallines=("${@}")
  printf '%s\n' "${locallines[@]}"
}
