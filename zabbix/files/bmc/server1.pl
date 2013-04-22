#!/usr/bin/perl
# Script provided for Zabbix community by Rick Wagner (wagner.234@gmail.com)
 
 
use strict;
use warnings;
 
die usage() if ($#ARGV == -1);
 
my $regex    = qr/\s*\|\s*/;
my $val;
 
#my $OUTPUT;
 
if (open( FILE, "< /etc/zabbix/server1.dump")) {
    while (<FILE>) {
        chomp($_);
 
        my @fields = split (/$regex/,$_);
        #print $fields[0];
        if ($#fields >= 2 && $ARGV[0] eq $fields[0]) {
            last if ($fields[2] eq 'ns');
 
            $val = $fields[1];
            last;
        }
    }
 
 
} else {
    die "Error:. $!\n";
}
 
if (defined($val)) {
    ($val) = ($val =~ /^(\d+)\s+/);
    print $val."\n";
    exit(0);
} else {
    exit (-1);
}
 
sub usage {
    return "Usage: ./$0 <key>"
}
