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

#  upload_test_size=95000000
  #
#  webrouter_header_size="8000"
  #webrouter_header_size="7000"
  #webrouter_header_size="4096"
  #webrouter_header_size="2048"
  #webrouter_header_size="1024"
}

@test "lookup_homepage: confirm that /server/lookup/?page_id=2002 works properly" {
  test_web http "$BUWEBHOST" '/server/lookup/?page_id=2002'
  assert_status 200
  
  assert_backend source_ip

  assert_contains 'backend: wordpress'
}

@test "lookup_homepage: confirm that /server/lookup works properly" {
  test_web http "$BUWEBHOST" '/server/lookup/'
  assert_status 200

  assert_backend source_ip

  assert_contains 'backend: content'
}

