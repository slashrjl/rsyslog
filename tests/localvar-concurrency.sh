#!/bin/bash
# Test concurrency of message variables
# Added 2015-11-03 by rgerhards
# This file is part of the rsyslog project, released  under ASL 2.0
echo ===============================================================================
echo \[localvar-concurrency.sh\]: testing concurrency of local variables

uname
if [ `uname` = "SunOS" ] ; then
   echo "This test currently does not work on all flavors of Solaris."
   exit 77
fi

. $srcdir/diag.sh init
. $srcdir/diag.sh startup localvar-concurrency.conf
sleep 1
. $srcdir/diag.sh tcpflood -m500000
. $srcdir/diag.sh shutdown-when-empty # shut down rsyslogd when done processing messages
. $srcdir/diag.sh wait-shutdown
. $srcdir/diag.sh seq-check 0 499999
. $srcdir/diag.sh exit
