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
  #
  webrouter_header_size="8000"
  #webrouter_header_size="7000"
  #webrouter_header_size="4096"
  #webrouter_header_size="2048"
  #webrouter_header_size="1024"
}

@test "homepage: http homepage request with query goes to WordPress" {
  test_web http "$BUWEBHOST" '/?page_id=2002'
  assert_status 200
  # eventually it should be 
  #assert_backend "content"
  # right now it can be one of two values - legacy for Solaris servers and content for all others
  # 6/26/2018: now that we have transitioned it can only be 
  # content or aws_home_index depending on whether we have 
  # moved the homepage to aws
  #
  assert_backend content wordpress

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: https homepage request with query goes to WordPress" {
  test_web https "$BUWEBHOST" '/?page_id=2002'
  assert_status 200
  # eventually it should be 
  #assert_backend "content"
  # right now it can be one of two values - legacy for Solaris servers and content for all others
  # 6/26/2018: now that we have transitioned it can only be 
  # content or aws_home_index depending on whether we have 
  # moved the homepage to aws
  #
  assert_backend content wordpress

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: http homepage request" {
  test_web http "$BUWEBHOST" /
  assert_status 200
  # eventually it should be 
  #assert_backend "content"
  # right now it can be one of two values - legacy for Solaris servers and content for all others
  # 6/26/2018: now that we have transitioned it can only be 
  # content or aws_home_index depending on whether we have 
  # moved the homepage to aws
  #
  assert_backend content aws_home_index

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: https homepage request" {
  test_web https "$BUWEBHOST" /
  assert_status 200
  # eventually it should be 
  #assert_backend "content"
  # right now it can be one of two values - legacy for Solaris servers and content for all others
  # 6/26/2018: now that we have transitioned it can only be 
  # content or aws_home_index depending on whether we have 
  # moved the homepage to aws
  #
  assert_backend content aws_home_index

  assert_contains '<!-- HPPUBDDATE'
}

@test "homepage: /alert messages process correctly" {
  skip "TEST MANUALLY: bu.edu/alert/includes/all.htm and make certain that the CORS headers are present"
}

#@test "router_limits: max output header = 4k from upstream (http)" {
  #skip "TEST MANUALLY: enable Query Monitor on the hub site"
  # http://www.bu.edu/nisdev/php5/antonk/aws-header-size-test/p9ijp3oifnp.php/?size=1000
  #set -x
#  test_web http "$BUWEBHOST" "/nisdev/php5/antonk/aws-header-size-test/p9ijp3oifnp.php/?size=4096"
#  assert_status 200
#  assert_backend "phpbin"
#  assert_header_contains set_cookie "00_XYZ"
#  assert_contains "OK"

#}
