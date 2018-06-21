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

@test "testhost1 root - default WordPress" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost1" "/"
  assert_status 200
  assert_backend "wordpress"
}

@test "testhost1 toplevel override of default WordPress" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost1" "/content"
  assert_status 404
  assert_backend "content"
}

@test "testhost1 toplevel plus override of default WordPress" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost1" "/content/foobar"
  assert_status 404
  assert_backend "content"
}

@test "testhost1 microsite override of default WordPress" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost1" "/content/dbin/foo.txt"
  assert_status 404
  assert_backend "dbin"
}

@test "testhost2 root - host mapped" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost2" "/"
  assert_status 200
  assert_backend "phpbin"
}

@test "testhost2 toplevel override of host mapped" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost2" "/content"
  assert_status 404
  assert_backend "content"
}

@test "testhost2 toplevel plus override of host mapped" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost2" "/content/foobar"
  assert_status 404
  assert_backend "content"
}

@test "testhost2 microsite override of host mapped" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images"
  test_web http "testhost2" "/content/dbin/foo.txt"
  assert_status 404
  assert_backend "dbin"
}

