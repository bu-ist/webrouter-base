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

@test "router_hostheaders: content passes host header (http)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web http "$BUWEBHOST" "/server/backend/content/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=$BUWEBHOST"
  assert_status 200
  assert_contains "PASSED"
}

@test "router_hostheaders: content passes host header (https)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web https "$BUWEBHOST" "/server/backend/content/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=$BUWEBHOST"
  assert_status 200
  assert_contains "PASSED"
}

@test "router_hostheaders: blanked host header works (http)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web http "$BUWEBHOST" "/server/backend/checkhostheader/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=hostheader.bu.edu"
  assert_status 200
  assert_contains "PASSED"
}

@test "router_hostheaders: blanked host header works (https)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web https "$BUWEBHOST" "/server/backend/checkhostheader/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=hostheader.bu.edu"
  assert_status 200
  assert_contains "PASSED"
}

