#!/usr/bin/env bats
#
# These checks make certain that the web router handles the correct inputs
# 

load webtests

teardown () {
  cleanup_web
}

setup () {
  setup_web

  upload_test_size=95000000
  
  webrouter_header_size="8000"
}

@test "homepage: http homepage request with query goes to WordPress" {
  test_web http "$BUWEBHOST" '/?page_id=2002'
  assert_status 200

  assert_backend wordpress

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: https homepage request with query goes to WordPress" {
  test_web https "$BUWEBHOST" '/?page_id=2002'
  assert_status 200
  
  assert_backend wordpress

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: http homepage request" {
  test_web http "$BUWEBHOST" /
  assert_status 200

  assert_backend content aws_home

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: https homepage request" {
  test_web https "$BUWEBHOST" /
  assert_status 200

  assert_backend content aws_home

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: /alert messages process correctly" {
  skip "TEST MANUALLY: bu.edu/alert/includes/all.htm and make certain that the CORS headers are present"
}

