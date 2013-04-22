#!/usr/bin/perl
use strict;
use warnings;
use Getopt::Long;

my $rotated_log;   # ローテートされてるかもファイル
my $offset_file;   # 前回どこまでtailしたか保存するファイル
GetOptions(
  "rotated=s" => \$rotated_log,
  "offset=s"  => \$offset_file
);

my $log = shift
  or die "Usage: $0 log [-r rotated_log] [-o offset_file]\n";
$offset_file ||= "$log.offset";

# 途中終了による重複出力防止のため事前に権限をチェック
check_log($log);
if($rotated_log && -e $rotated_log){
  check_log($rotated_log);
}
check_offset_file($offset_file);

my $offset = load_offset($offset_file);
my $new_offset;

if($rotated_log && -e $rotated_log){
  $new_offset = tail_rotated_log($rotated_log, $offset);
  save_offset($offset_file, $new_offset) if $new_offset;
}

$new_offset = tail_log($log, $offset);
save_offset($offset_file, $new_offset) if $new_offset;

exit 0;


sub check_log {
  my $log = shift;

  -f $log && -r $log 
    or die "Can't access $log";
}

sub check_offset_file {
  my $offset_file = shift;

  if(-e $offset_file){
    -f $offset_file && -w $offset_file
      or die "Can't write offset_file:$offset_file";
  }else{
    open my $fh, ">", $offset_file
      or die "Can't create offset_file:$offset_file";
    close $fh;
  }
}

sub load_offset {
  my $offset_file = shift;

  open my $fh, '<', $offset_file or die $!;
  my $line = <$fh>;
  close $fh;

  my $offset = {ino => 0, pos => 0};
  if($line && $line =~ /^(\d+) (\d+)$/){
    $offset->{ino} = $1;
    $offset->{pos} = $2;
  }

  return $offset;
}

sub save_offset {
  my ($offset_file, $offset) = @_;

  open my $fh, '>', $offset_file or die $!;
  print $fh $offset->{ino} .' '.  $offset->{pos};
  close $fh;
}

sub tail_log {
  my ($log, $offset) = @_;
  my $ret_offset;

  my($ino, $size) = (stat $log)[1,7];

  if($offset->{ino} == $ino){
    if($offset->{pos} < $size){
      my $end_pos = tail_print($log, $offset->{pos});
      $ret_offset = {ino => $ino, pos => $end_pos};
    }
  }else{
    my $end_pos = tail_print($log, 0);
    $ret_offset = {ino => $ino, pos => $end_pos};
  }

  return $ret_offset;
}

sub tail_rotated_log {
  my ($log, $offset) = @_;
  my $ret_offset;

  my ($ino, $size) = (stat $log)[1,7];

  if($offset->{ino} == $ino && $offset->{pos} < $size){
    my $end_pos = tail_print($log, $offset->{pos});
    $ret_offset = {ino => $ino, pos => $end_pos};
  }

  return $ret_offset;
}

sub tail_print {
  my ($log, $start_pos) = @_;
  $start_pos ||= 0;

  open my $fh, "<", $log or die "$!";

  seek $fh, $start_pos, 0;
  print while <$fh>;
  my $end_pos = tell $fh;

  close $fh;

  return $end_pos;
}
