#!/usr/bin/perl
#
# Simple file upload test - we accept the file and then return OK if it processed properly.
#
use strict;
use CGI;
use CGI::Carp qw( fatalsToBrowser );
use File::Basename;
use Time::HiRes qw(gettimeofday);

# the standard suffix we want on the cookie
my $suffix = 'XYZ';

my $cgi = new CGI;

# size of the cookie we want to create (header size)
my $size = $cgi->param("size");

my $header = sprintf("%s=%s_%s", "test", ('0' x $size), $suffix);

#printf STDERR "headercheck: size=%d cookie=%s\n", $size, $header;

printf "Content-type: text/plain\nSet-Cookie: %s\n\nOK\n", $header;
exit;
