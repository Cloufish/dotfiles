alias g=git
alias dco="docker-compose up"
alias dab="docker attach blackarch-zsh"
alias interlace="interlace -tL test.txt -threads 5 -c"
alias pomo="/usr/local/sbin/pomodoro-timer.sh &>/dev/null &"

function thm(){
	sudo openvpn home/cloufisz/Pentesting/VPNs/TryHackMe/Cloufish.ovpn &>/dev/null&
	docker-compose /home/cloufisz/Learning/blackarch-zsh-container/blackarch-zsh
	docker attach blackarch-zsh
}

function bbrf() {
        source ~/bbrf-client/.env/bin/activate;
        python ~/bbrf-client/bbrf.py "$@"
        deactivate
}
