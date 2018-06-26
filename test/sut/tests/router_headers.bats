#!/usr/bin/env bats
#
# These checks make certain that the web router forwards the appropriate headers to backends
# 

load webtests

teardown () {
  cleanup_web
}

setup () {
  setup_web

}

# envcheck name expected [http|https]
#
envcheck () {
  scheme="$3"
  if [ "x$scheme" = x ]; then
    scheme=http
  fi

  test_web "$scheme" "$BUWEBHOST" "/htbin/envcheck.pl?env=$1&expected=$2"
  assert_status 200
  assert_contains "PASSED"
}

@test "router_headers: X-Forwarded-Proto http" {
  envcheck HTTP_X_FORWARDED_PROTO http http
}

@test "router_headers: X-Forwarded-Proto https" {
  envcheck HTTP_X_FORWARDED_PROTO https https
}

@test "router_headers: X-Method http" {
  envcheck HTTP_X_METHOD http http
}

@test "router_headers: X-Method https" {
  envcheck HTTP_X_METHOD https https
}

@test "router_headers: X-BU-Frontend AWS-Cluster" {
  envcheck HTTP_X_BU_FRONTEND AWS-Cluster
}

@test "router_headers: X-SSL on (https)" {
  envcheck HTTP_X_SSL on https
}

