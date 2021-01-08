#!/bin/bash
timer_break(){
 hour=0
 min=5
 sec=0
        while [ $hour -ge 0 ]; do
                 while [ $min -ge 0 ]; do
                         while [ $sec -ge 0 ]; do
                                 echo -ne "$hour:$min:$sec\033[0K\r"
                                 let "sec=sec-1"
                                 sleep 1
                         done
                         sec=59
                         let "min=min-1"
                 done
                 min=59
                 let "hour=hour-1"
         done

}

timer_work(){
 hour=0
 min=25
 sec=0
        while [ $hour -ge 0 ]; do
                 while [ $min -ge 0 ]; do
                         while [ $sec -ge 0 ]; do
                                 echo -ne "$hour:$min:$sec\033[0K\r"
                                 let "sec=sec-1"
                                 sleep 1
                         done
                         sec=59
                         let "min=min-1"
                 done
                 min=59
                 let "hour=hour-1"
         done

}

main(){
	while true
	do
		if ! [[ -f /etc/hosts_without_social.txt  ]] && ! [[ -f /etc/hosts_with_social.txt ]]; then

			wget https://raw.githubusercontent.com/Cloufish/dotfiles/main/hosts_without_social.txt -O /etc/hosts_without_social.txt
			wget https://raw.githubusercontent.com/Cloufish/dotfiles/main/hosts_with_social.txt -O /etc/hosts_with_social.txt
		fi 

		rm /etc/hosts
		cp /etc/hosts_with_social.txt /etc/hosts
		timer_work
		notify-send "BREAK TIME! (5min)"
		rm /etc/hosts
		cp /etc/hosts_without_social.txt /etc/hosts
		timer_break
		notify-send "WORK TIME! (25min)"
	done

}

 if [ "${UID}" -ne 0 ]; then
 	echo "You need to execute this command as SUDO "
 	echo "sudo <script>"
 	exit 1
 fi

 main