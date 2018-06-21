#!/usr/bin/perl
#
# Simple file upload test - we accept the file and then return OK if it processed properly.
#
use strict;
use CGI;
use CGI::Carp qw( fatalsToBrowser );
use File::Basename;
use Time::HiRes qw(gettimeofday);

# This is the maximum that the script will accept (right now 105Meg)
#
$CGI::POST_MAX = 1024 * 105000;

my $safe_filename_characters = "a-zA-Z0-9_.-";

my $upload_dir = "/var/tmp";

my $cgi = new CGI;

my $fname = $cgi->param("data");

sub exact_time {
  my($s_sec, $s_usec) = gettimeofday;
  return ($s_sec + $s_usec*0.000001);
}

sub logit {
  my($msg) = @_;
  my($now) = scalar(localtime());
  my($ip) = $ENV{'REMOTE_ADDR'};

  printf STDERR "%s %s %s\n", $now, $ip, $msg;
}

print "Content-type: text/plain\n\n";


if ( $fname) {
  my $upload_filehandle = $cgi->upload("data");

  my $buffer;
  my $count ;

  my $start = time;
  if (defined($upload_filehandle)) {
    my $io_handle = $upload_filehandle->handle;
    my $bytesread;

    my($start) = exact_time;
    logit("starting read");
    while ($bytesread = $io_handle->read($buffer, 1024)) {
      $count += $bytesread;
    }

    my $end = exact_time;
    logit("ending read");
    my $elapsed = ($end - $start);
    my $kbytes = ($count / 1024.0);

    #my $upload_size = (stat("${upload_dir}/${fname}"))[7];
    #my $upload_ls = `/bin/ls -l "${upload_dir}/${fname}" `;

    printf "OK\n";
    logit(sprintf("OK %s %6.6f kbytes transfered in %6.6f (%4.2f kps)", $fname, $kbytes, $elapsed, ($kbytes / $elapsed) ));
  }

} else {
  printf "ERROR no file uploaded!\n";
  logit("ERROR no file uploaded!");
}
