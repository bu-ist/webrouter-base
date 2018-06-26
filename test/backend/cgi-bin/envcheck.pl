#!/usr/bin/perl
#
# Simple script to test that an environment variable is set a certain way.  As a side-effect 
# it outputs all the headers to the backend
#
use strict;
use CGI;
use CGI::Carp qw( fatalsToBrowser );
use File::Basename;
use Time::HiRes qw(gettimeofday);

my $prefix = sprintf("%s %s", scalar(localtime()), $ENV{'REMOTE_ADDR'});

my $cgi = new CGI;

my $env = $cgi->param("env");
printf(STDERR "%s: env=%s\n", $prefix, $env);

my $expected = $cgi->param("expected");
printf(STDERR "%s: expected=%s\n", $prefix, $expected);

print "Content-type: text/plain\n\n";


# we go through the environment variables and send them all to stderr
#
my $key;
foreach $key (sort(%ENV)) {
  printf(STDERR "%s: (%s)=(%s)\n", $prefix, $key, $ENV{$key});
}

if ($env) {
  my($got) = $ENV{$env};
  if ($got ne $expected) {
    printf("ERROR got %s\n", $got);
    printf(STDERR "%s: ERROR got %s but expected %s\n", $prefix, $got, $expected);
  } else {
    printf("PASSED got %s\n", $got);
    printf(STDERR "%s: PASSED got %s\n", $prefix, $got);
  }
} else {
  printf(STDERR "%s: ERROR blank env\n", $prefix);
}
exit;
