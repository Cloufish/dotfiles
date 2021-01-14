#!/bin/bash

#notify-send() {
    #Detect the name of the display in use
#    local display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"

    #Detect the user using such display
#    local user=$(who | grep '('$display')' | awk '{print $1}' | head -n 1)

#    #Detect the id of the user
#    local uid=$(id -u $user)

#    sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus notify-send "$@"
#}

mpv() {
    #Detect the name of the display in use
    local display=":$(ls /tmp/.X11-unix/* | sed 's#/tmp/.X11-unix/X##' | head -n 1)"

    #Detect the user using such display
    local user=$(who | grep '('$display')' | awk '{print $1}' | head -n 1)

    #Detect the id of the user
    local uid=$(id -u $user)

    sudo -u $user DISPLAY=$display DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/$uid/bus mpv "$@"
}

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

timer_long_break(){
 hour=0
 min=30
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

	username=$(logname)
	
	hosts_dir=/home/${username}/.local/hosts
	mkdir -p $hosts_dir
	if ! [[ -f "${hosts_dir}/hosts_without_social.txt"  ]] || ! [[ -f "${hosts_dir}/hosts_with_social.txt" ]] || ! [[ -f "${hosts_dir}/hosts" ]]; then

		wget https://raw.githubusercontent.com/Cloufish/dotfiles/main/hosts_without_social.txt -O ${hosts_dir}/hosts_without_social.txt
		wget https://raw.githubusercontent.com/Cloufish/dotfiles/main/hosts_with_social.txt -O ${hosts_dir}/hosts_with_social.txt
		touch ${hosts_dir}/hosts
		sudo rm /etc/hosts
	fi

	if ! [[ -f "/etc/hosts" ]]; then
		sudo ln ${hosts_dir}/hosts /etc/hosts
	fi

	sounds_dir=/home/${username}/.local/sounds
	mkdir -p ${sounds_dir}

	if ! [ -f ${sounds_dir}/sound_break.mp3 ] && ! [ -f ${sounds_dir}/sound_long_break.mp3 ] && ! [ -f ${sounds_dir}/sound_work.mp3 ]; then
		echo -e "DOWNLOADING SOUNDS...\n\n"
		wget -O ${sounds_dir}/sound_break.mp3 "https://proxy.notificationsounds.com/notification-sounds/coins-497/download/file-sounds-869-coins.mp3"
		wget -O ${sounds_dir}/sound_long_break.mp3 "https://proxy.notificationsounds.com/sound-effects/chimes-440/download/file-sounds-922-chimes.mp3"
		wget -O ${sounds_dir}/sound_work.mp3 "https://proxy.notificationsounds.com/message-tones/office-2-453/download/file-sounds-847-office-2.mp3"
 
		echo -e "\n\n"
	fi

	while true
	do

		number_of_pomodoro_series=0

		mpg123 -f -2000 ${sounds_dir}/sound_work.mp3 & notify-send -u normal --expire-time=10000 "WORK TIME! (25min)"
		cat ${hosts_dir}/hosts_with_social.txt > ${hosts_dir}/hosts
		number_of_pomodoro_series=$((number_of_pomodoro_series+1))
		timer_work
		
		if (( ${number_of_pomodoro_series} == 4 )); then
			mpg123 -f -2000 ${sounds_dir}/sound_long_break.mp3 & notify-send -u normal --expire-time=10000 "LONG BREAK TIME! (30min)" 
			cat ${hosts_dir}/hosts_without_social.txt  > ${hosts_dir}/hosts
			#systemctl suspend & 
			timer_long_break

		elif (( ${number_of_pomodoro_series} < 4 )); then
			mpg123 -f -2000 ${sounds_dir}/sound_break.mp3 & notify-send -u normal --expire-time=10000 "BREAK TIME! (5min)"
			cat ${hosts_dir}/hosts_without_social.txt > ${hosts_dir}/hosts
			#systemctl suspend & 
			timer_break
		fi

	done

}

 #if [ "${UID}" -ne 0 ]; then
 #	echo "You need to execute this command as SUDO "
 #	echo "sudo <script>"
 #	exit 1
 #fi


 main