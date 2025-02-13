#!/bin/bash
# ~/.bash_functions */

## PS1 and other terminal defaults (stolen from manjaro) ##
terminal_defaults () {
	#Change the window title of X terminals
	case ${TERM} in
		xterm*|rxvt*|Eterm*|aterm|kterm|gnome*|interix|konsole*)
			PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\007"'
			;;
		screen*)
			PROMPT_COMMAND='echo -ne "\033_${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/\~}\033\\"'
			;;
	esac

	#Set colorful PS1 on colorful terminals.
	use_color=true; safe_term=${TERM//[^[:alnum:]]/?}; match_lhs=""
	[[ -z ${match_lhs} ]] && type -P dircolors >/dev/null && match_lhs=$(dircolors --print-database)
	[[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] && use_color=true
	if ${use_color}; then
		if [[ ${EUID} == 0 ]];
			then PS1='\[\033[01;31m\][\u@\h\[\033[01;36m\] \W\[\033[01;31m\]]\$\[\033[00m\] '
			else PS1='\[\033[01;32m\][\u@\h\[\033[01;37m\] \W\[\033[01;32m\]]\$\[\033[00m\] '
		fi
		alias ls='ls --color=auto'
		alias grep='grep --colour=auto'
		alias egrep='egrep --colour=auto'
		alias fgrep='fgrep --colour=auto'
	else
		if [[ ${EUID} == 0 ]];
			then PS1='\u@\h \W \$ '
			else PS1='\u@\h \w \$ '
		fi
	fi
	unset use_color safe_term match_lhs sh

	complete -cf sudo
	shopt -s checkwinsize; shopt -s expand_aliases; shopt -s histappend
	xhost +local:root > /dev/null 2>&1
}

## Append something to the PATH ##
append_path () {
	case ":$PATH:" in
		*:"$1":*)
			;;
		*)
			PATH="${PATH:+$PATH:}$1"
	esac
}

## Load pulseaudio TCP module ##
pashare (){
	port=12345
	case $1 in
		"start")
			pactl load-module module-simple-protocol-tcp rate=48000 format=s16le channels=2 source=0 record=true port=$port listen=0.0.0.0 &>/dev/null
			echo "TCP pulseaudio share enabled in $local_ip:$port"
			;;
		"stop")
			pactl unload-module module-simple-protocol-tcp &>/dev/null
			echo "TCP pulseaudio share disabled"
			;;
		*)
			echo "Usage:"
			echo "pashare start/stop"
			;;
	esac
}

## Load pulseaudio alsa loopback module for droidcam ##
droidcam-loopback (){
	case $1 in
		"start")
			pacmd load-module module-alsa-source device=hw:Loopback,1,0
			echo "Alsa loopback activated"
			;;
		"stop")
			pacmd unload-module module-alsa-source
			echo "Alsa loopback deactivated"
			;;
		*)
			echo "Usage:"
			echo "droidcam-loopback start/stop"
	esac
}

kpape (){
	dbus-send --session --dest=org.kde.plasmashell --type=method_call /PlasmaShell org.kde.PlasmaShell.evaluateScript "string:
var Desktops = desktops();
for (i=0;i<Desktops.length;i++) {
		d = Desktops[i];
		d.wallpaperPlugin = 'org.kde.image';
		d.currentConfigGroup = Array('Wallpaper',
									'org.kde.image',
									'General');
		d.writeConfig('Image', '$(readlink -f "$1")');
}"
}

## Launch some command with arguments and immediately disown it ##
launch-disown () {
	[[ -n "$1" ]] && \
		if [[ "$@" == "$1" ]]; then
			"$1" &>/dev/null & disown
		else
			args="$@";args="${args#* }"
			"$1" $args &>/dev/null & disown
		fi
}

## Compress a folder into a tar.xz using all cores ##
tarxz () {
	[[ -n $1 ]] \
		&& tar cvf "$(basename "$1").tar.xz" --use-compress-program='xz -1T0' "$1"
}

## Clone something from the AUR ##
aurclone () {
	git clone "https://aur.archlinux.org/$1.git"
}

## Convert an audio to MP3@320k keeping metadata with FFMPEG ##
ffmpeg2mp3 () {
	echo "=> Converting \"$1\" to mp3..."
	ffmpeg -i "$1" -ab 320k -map_metadata 0 -id3v2_version 3 "${1%%.*}.mp3" &>/dev/null
	echo "=> Audio saved to ${1%%.*}.mp3"
}

## Extract best audio source from youtube ##
yt-bestaudio () {
	yt-dlp -f 251 "$1" -x --audio-format flac --add-metadata --xattrs --embed-thumbnail --prefer-ffmpeg -o "%(title)s.%(ext)s"
}


## Create a tar.gz of a folder and send it with scp ##
#TODO: Rehacer esta aca o hacer un script
tarnsend () {
	if [ -z $1 ] || [ -z $2 ]; then
		echo "ERROR: Invalid usage"
		echo "Usage: tarnsend <infolder> <sshdirection/alias> [destinationfolder]"
		echo ""
		echo "Available aliases:"
		echo "laptop/compy/switch"
	else
		folder="$1"; tarname="$(basename -- "$1").tar.gz"
		if [[ "$2" == "$HOSTNAME" ]]; then
			echo "ERROR: Can't send file to the same device that is being used"
		else
			case $2 in
				"laptop")
					ssh="$username@$laptop_ip"
					;;
				"switch")
					ssh="$username@$switch_ip"
					;;
				"compy")
					ssh="$username@$compy_ip"
					;;
				*)
					ssh="$2"
			esac
			tar cf - "$folder"/* -P | pv -s $(du -sb "$folder" | awk '{print $1}') | gzip > "/tmp/$tarname"
			if [ -z $3 ]; then
				scp "/tmp/$tarname" "$ssh:$3"
			else
				scp "/tmp/$tarname" "$ssh:~"
				rm "/tmp/$tarname"
			fi
		fi
	fi
}

## Open TP-Link RTSP stream ##
#TODO: Hacer un script para esta aca
tpcamera () {
	tplink_ip="192.168.0.4"
	tp_user=$(base64 -d<<<"YWRtaW4K")
	tp_pass=$(base64 -d<<<"bWFyaW5vMTIK")
	mpv --profile=low-latency "rtsp://$tp_user:$tp_pass@$tplink_ip/h264_hd.sdp"
}

## Hostname dependent functions ##
case $HOSTNAME in
	"switch")
		# hwaccel gstreamer
		gstreamerTegra  () {
			gst-launch-1.0 filesrc location="$1" ! qtdemux name=demux ! decodebin ! nvvidconv flip-method=0 ! nv3dsink demux.audio_0 ! queue ! avdec_aac ! audioconvert ! pulsesink -e
			#gst-launch-1.0 filesrc location="$1" ! qtdemux name=demux ! decodebin ! nvvidconv flip-method=1 ! nvoverlaysink demux.audio_0 ! queue ! avdec_aac ! audioconvert ! pulsesink -e
		}

		# sdcard functions
		remountSwitchBoot () {
			sudo umount /mnt/sdcard
			sudo mount /dev/mmcblk1p1 /.boot
			sudo mount --bind /.boot/switchroot/arch /boot/switchroot/
		}
		remountSwitchSd () {
			sudo umount /boot/switchroot/ && sudo umount /.boot
			sudo mount -o defaults,auto,uid=1001,gid=984,umask=000 /dev/mmcblk1p1 /mnt/sdcard
		}
esac
