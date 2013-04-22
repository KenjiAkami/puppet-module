use strict;
use warnings;
use POSIX;

#my $site = shift;
chdir "/var/log/httpd/";

my $slow_time = 1_000_000;

my $zabbix_sender = "zabbix_sender -c /etc/zabbix/zabbix_agentd.conf >/dev/null";
my $logtail       = "/etc/zabbix/helper/logtail.pl";

my $today     = strftime "%Y%m%d", localtime;
my $yesterday = strftime "%Y%m%d", localtime(time - 60*60*24);

my @sites = map {s/-access_log.*//;$_} glob("*-access_log.$today");

my %results;
for my $site (@sites){
  my $result = count_log($site);
  $results{$site} = $result if $result;
}

for my $site (keys %results){
  send_result($site, $results{$site});
}
exit;

sub count_log {
  my $site = shift;

  my $offset  = "/tmp/zabbix_access_log.offset.$site";
  my $log         = "$site-access_log.$today";
  my $rotated_log = "$site-access_log.$yesterday";

  my $count_all  = 0;
  my $count_slow = 0;
  my $rate_slow  = 0;
  my $time_sum   = 0;
  my $time_avg   = 0;

  # 前回実行から6分以上たってたら空回しして終了。効率悪いけどとりあえず
  if( ! -e $offset || time - (stat $offset)[9] > 360){
    system("$logtail $log -r $rotated_log -o $offset >/dev/null");
    return ;
  }

  my $cmd = "$logtail $log -r $rotated_log -o $offset";
  my $fh;
  unless(open $fh, "$cmd |"){
  #  print 1;
    return;
  }

  while(<$fh>){
    /(\d+)( "[^"]*" "[^"]*")?$/ or next;
    my $access_time = $1;

    $count_all++;
    $count_slow++ if $access_time > $slow_time;
    $time_sum += $access_time;
  }
  close $fh;

  if($count_all != 0){
    $time_avg  = int(($time_sum / $count_all) / 1000);
    $rate_slow = $count_slow / $count_all;
  }
#  print "$site,$count_all,$rate_slow,$time_avg\n";
  return {
    count    => $count_all,
    res_time => $time_avg,
    slow     => $rate_slow
  };
}

sub send_result {
  my ($site, $result) = @_;
  system("$zabbix_sender -k http.count[$site] -o ".    $result->{count});
  system("$zabbix_sender -k http.res_time[$site] -o ". $result->{res_time});
  system("$zabbix_sender -k http.slow[$site] -o ".     $result->{slow});
  #print $count_all;
}
