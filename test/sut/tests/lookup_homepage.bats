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

