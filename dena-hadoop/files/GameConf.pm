package _;

our $LOG_DIR = "/data/game/log";
our $RUN_DIR = "/data/game/run";

our $TEST_MODE = 0;
our $IDC = "SD";

our $NEED_BASIC_AUTH = 0; # 1:use basic auth, 0: nouse basic auth
our $BASIC_AUTH_USER="your_user_name";
our $BASIC_AUTH_PASS="your_password";

our $HOST='172.24.5.253';## semi domestic
our $PROTOCOL='http';
our $HTTP_TIMEOUT = 30; # sec
our $HTTP_USER_AGENT="HadoopLog Daemon for 3rdParty";
our $HTTP_PATH="/recvlog/";

use lib "/usr/dena/mbga_send_log/lib";

1;
