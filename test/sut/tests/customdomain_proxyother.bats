#!/usr/bin/env bats

#declare -A web

load webtests

teardown () {
  cleanup_web
}

setup () {
  setup_web
  #host=www-devl.bu.edu
}

#setup () {
#  init_web
#}

@test "customdomain(proxyother) root - bi.bu.edu type config (redirect)" {
  #[ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "bi.bu.edu" "/"
  assert_status 302
  assert_header location "http://bi.bu.edu/MicroStrategy/servlet/mstrWeb"
  #assert_backend "wordpress"
}

@test "customdomain(proxyother) /MicroStrategy/ - bi.bu.edu type config (proxyother)" {
  #[ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web https "bi.bu.edu" "/MicroStrategy/"
  assert_status 200
  #assert_backend "bibackend"
}
