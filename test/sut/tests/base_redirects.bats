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

@test "asis redirect - top-level" {
  test_web http "$BUWEBHOST" /studentlink/
  assert_status 302
  assert_header location "http://$BUWEBHOST/link/bin/uiscgi_studentlink.pl/uismpl/?ModuleName=menu.pl&NewMenu=Home"
}

@test "asis redirect - top-level with extra stuff" {
  test_web http "$BUWEBHOST" /studentlink/this/should/be/dropped
  assert_status 302
  assert_header location "http://$BUWEBHOST/link/bin/uiscgi_studentlink.pl/uismpl/?ModuleName=menu.pl&NewMenu=Home"
}

@test "host level redirect with no subpaths" {
  test_web http "redirecthost" /
  assert_status 302
  assert_header location "http://destinationhost/"
}

@test "host level redirect with subpaths (http)" {
  test_web http "redirecthost" /foo/bar/stuff
  assert_status 302
  assert_header location "http://destinationhost/foo/bar/stuff" 
}

@test "host level redirect with subpaths (https)" {
  test_web http "redirecthost" /foo/bar/stuff
  assert_status 302
  assert_header location "http://destinationhost/foo/bar/stuff" 
}

@test "host level asis redirect with subpaths" {
  test_web http "redirectasishost" /foo/bar/stuff
  assert_status 302
  assert_header location "https://www.google.com/"
}

@test "toplevel redirect with subpaths" {
  test_web http "redirectasishost" '/tech/plan/?foobar=1'
  assert_status 302
  assert_header location "http://www.bu.edu/tech/plan/?foobar=1"
}

