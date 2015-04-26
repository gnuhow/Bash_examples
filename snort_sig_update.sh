#! /bin/bash

crontab -e
30 2 * * * pp-update.sh >> /var/syslog
 
vi pp-update.sh
	myemail="gnuhow@gmail.com"
	server_name="server1"

	# Create a log of the daily update.
	date >> /var/log/pulledpork
	pulledpork.pl -c /etc/pulledpork/pulledpork.conf >> /var/log/pulledpork
	service snort restart >> /var/log/pulledpork
	
	# Check if Snort updates successfully.
	check_update=grep -c "Fly Piggy Fly!" /var/log/pulledpork
	check_run=grep -c "running" /var/log/pulledpork

	if {check_update -eq 0}; then
		if {check_run -eq 0}; then
			mail -s “$server_name PP update has a problem!” $myemail < /var/log/pulledpork
	fi

