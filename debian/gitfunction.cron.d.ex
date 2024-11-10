#
# Regular cron jobs for the gitfunction package
#
0 4	* * *	root	[ -x /usr/bin/gitfunction_maintenance ] && /usr/bin/gitfunction_maintenance
