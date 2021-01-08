#!/bin/bash
rm /etc/hosts
while true
do
	pomo_st_output=$(pomo st)
	first_letter="${pomo_st_output:0:1}"

	if [[ ${first_letter} == "B" ]]
	then
		rm /etc/hosts
		cp /etc/unified_without_social.txt /etc/hosts
		echo "It's B"
		sleep 300
		rm /etc/hosts
		cp /etc/unified_with_social.txt /etc/hosts
	elif [[ ${first_letter} == "R" ]]
	then
		echo "It's R and It's running"
		sleep 10
	elif [[ ${first_letter} == "P" ]]
	then
		echo "It's P and so It's paused"
		sleep 5
	fi
done
