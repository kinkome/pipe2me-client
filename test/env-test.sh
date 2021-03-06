#!/usr/bin/env roundup
describe "pipe2me environment tests"

#
# This tests check that the environment is setup properly.
# Note: the environment is generated via "pipe2me env"

. $(dirname $1)/testhelper.inc

it_start_a_tunnel() {
  fqdn=$($pipe2me setup --server $pipe2me_server --token $pipe2me_token)
  $pipe2me env > env
  echo "== env is ============="
  cat env
  echo "== env done ============="

  cat env | grep PIPE2ME_SERVER
  cat env | grep PIPE2ME_ID
  cat env | grep PIPE2ME_FQDN
  cat env | grep PIPE2ME_URLS_0
  cat env | grep PIPE2ME_TUNNEL
  ! (cat env | grep PIPE2ME_URLS_1)

  # can we source the env?
  eval $($pipe2me env)
  echo $PIPE2ME_URLS_0 | grep http
}
