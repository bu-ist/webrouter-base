#!/usr/bin/perl
#
# Simple script to return a clean URI from a request.
#
use strict;
use CGI;
use CGI::Carp qw( fatalsToBrowser );

# we go through the environment variables and send them all to stderr
#
my $prefix = sprintf("%s %s", scalar(localtime()), $ENV{'REMOTE_ADDR'});
my $key;
foreach $key (sort(%ENV)) {
  printf(STDERR "%s: (%s)=(%s)\n", $prefix, $key, $ENV{$key});
}

print "Content-type: text/plain\n\n";

print "$ENV{'REQUEST_URI'}\n";

exit;
