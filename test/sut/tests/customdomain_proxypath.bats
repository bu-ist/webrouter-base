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

@test "customdomain(backend-with-path) case 1: root" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "backend-with-path" "/"
  assert_status 200
  assert_content "/cgi-bin/uricheck.pl/"
  assert_backend "pathcheck"
  echo "testme"
}

@test "customdomain(backend-with-path) case 1: root with query string" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "backend-with-path" "/?test=1"
  assert_status 200
  assert_content "/cgi-bin/uricheck.pl/?test=1"
  assert_backend "pathcheck"
}

@test "customdomain(backend-with-path) case 2: single level" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "backend-with-path" "/toplevel"
  assert_status 200
  assert_content "/cgi-bin/uricheck.pl/toplevel"
  assert_backend "pathcheck"
}

@test "customdomain(backend-with-path) case 2: single level with query string" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "backend-with-path" "/toplevel?test=1"
  # dump_web
  assert_status 200
  assert_content "/cgi-bin/uricheck.pl/toplevel?test=1"
  assert_backend "pathcheck"
}

@test "customdomain(backend-with-path) case 3: 2 levels deep" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "backend-with-path" "/toplevel/secondlevel"
  assert_status 200
  assert_content "/cgi-bin/uricheck.pl/toplevel/secondlevel"
  assert_backend "pathcheck"
}

@test "customdomain(backend-with-path) case 3: 2 levels deep with query string" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "backend-with-path" "/toplevel/secondlevel?test=1"
  # dump_web
  assert_status 200
  assert_content "/cgi-bin/uricheck.pl/toplevel/secondlevel?test=1"
  assert_backend "pathcheck"
}
