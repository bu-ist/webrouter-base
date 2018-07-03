#!/usr/bin/env bats
#
# These checks make certain that the web router forwards requests appropriately to S3 buckets.
# There are two main issues with S3 buckets:
# 1) The Host: header needs to be the bucket name instead of the original host header.
# 2) http needs to be used internally for http and https requests.
# 

load webtests

teardown () {
  cleanup_web
}

setup () {
  setup_web

}

@test "router_s3buckets: content passes host header (http)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web http "$BUWEBHOST" "/server/backend/content/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=$BUWEBHOST"
  assert_status 200
  assert_contains "PASSED"
}

@test "router_s3buckets: content passes host header (https)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web https "$BUWEBHOST" "/server/backend/content/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=$BUWEBHOST"
  assert_status 200
  assert_contains "PASSED"
}

@test "router_s3buckets: blanked host header works (http)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web http "$BUWEBHOST" "/server/backend/checkhostheader/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=hostheader.bu.edu"
  assert_status 200
  assert_contains "PASSED"
}

@test "router_s3buckets: blanked host header works (https)" {
  [ "x$TEST_BASE" = x ] && skip "only done when testing base images until content server updated"
  test_web https "$BUWEBHOST" "/server/backend/checkhostheader/cgi-bin/envcheck.pl?env=HTTP_HOST&expected=hostheader.bu.edu"
  assert_status 200
  assert_contains "PASSED"
}

