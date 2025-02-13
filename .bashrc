# ~/.bashrc
## Load Functions ##
[[ -f ~/.bash_functions ]] && . ~/.bash_functions
[ -f /opt/miniconda3/etc/profile.d/conda.sh ] && source /opt/miniconda3/etc/profile.d/conda.sh
## Exports ##
export HISTSIZE=-1
export HISTFILESIZE=-1
export EDITOR=nvim
export GTK_USE_PORTAL=1

## PS1 defaults ##
terminal_defaults
unset -f terminal_defaults

## Vars ##
username="nikos"
laptop_ip="192.168.0.61"
compy_ip="192.168.0.139"
switch_ip="192.168.0.38"
switchroot_ip="192.168.0.110"
motog_ip="192.168.0.103"
local_ip="$(ip -c=never -o -4 addr | awk 'END{print $4}' | cut -d/ -f1)"

## PATH ##
append_path "~/.local/bin"
append_path "/opt/appimage"
append_path "~/.rsync_shared/bin/$(uname -m)"
append_path "~/.rsync_shared/script"
append_path "~/.rsync_shared/script/scrapers"

## Aliases ##

# Generic utils
alias relbash='exec bash'
alias cp="cp -i"
# alias df="df -h"
alias free="free -hm"
alias more=less
alias ip="ip --color"
alias ipb="ip --color --brief"
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'
alias ......='cd ../../../../..'
alias lsa='ls -a'
alias ll='ls -lh'
alias lla='ls -lah'
alias du='du -bsh'
alias getchmod='stat --format "%a"'
alias kys='shutdown now'

# Linux specific aliases
alias eskeyboard="setxkbmap -layout es"
alias watchmem="watch -n 0.5 free -m"
alias watchtemp="watch -n 0.5 sensors"
alias startx="startx /home/nikos/.xinitrc"
alias dropcache="echo 3 | sudo tee /proc/sys/vm/drop_caches"
alias delcache="rm -rf $HOME/.cache"
alias dmesgshutup="sudo dmesg --console-off"
alias ffmpeg="ffmpeg -hide_banner"

# Plasma aliases
alias replasma="killall plasmashell && kstart5 plasmashell"
alias rekwin="killall kwin_x11 && kstart5 kwin_x11"
alias relatte='killall latte-dock && kstart5 latte-dock'

# SSH aliases
alias sshltp="ssh $username@$laptop_ip"
alias sshswitch="ssh $username@$switch_ip"
alias sshdsk="ssh $username@$compy_ip"
alias sshmtg="ssh -t root@$motog_ip bash"
alias sshswrt="ssh -t root@$switchroot_ip bash"

# Utillities aliases
alias pacfzf="pacman -Slq | fzf --multi --preview 'pacman -Si {1}' | xargs -ro sudo pacman -S" 
alias pacfzf_r="pacman -Qq | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"
alias mpvwebcam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"
alias glavon='glava --compy & disown' 
alias glavoff='killall glava'
alias mount-exec='sudo mount -o defaults,auto,uid=1000,gid=users,umask=002'
alias streamx11='ffmpeg -f x11grab -r 15 -s 1920x1080 -i :0.0+0,0 -vcodec rawvideo -pix_fmt yuv420p -threads 0 -f v4l2 /dev/video0'
#TODO: Hacer un script para sync con cualquier dispositivo
alias syncmusic-motog="rsync -avhz --progress --update '/mnt/datos/Cosicas/Multimedia/HomeFolders/Music/' --delete root@192.168.0.103:/sdcard/Music"
alias sierrabzeconfig='kcmshell5 sierrabreezeenhancedconfig'
alias kill-orphans='sudo pacman -Rns $(pacman -Qqtd)'
alias pacsyu='sudo pacman -Syu'
alias pikasyu='pikaur -Syu'

alias xwinwrapmpv="xwinwrap -g 1920x1080 -ni -s -nf -b -un -ov -fdt -argb -- mpv -wid WID --no-osc --no-osd-bar"

## Hostname dependent shit ##
case $HOSTNAME in
    "compy")
		## Unaliases ##
		unalias sshdsk
		
		## Devkitpro exports ##
		export DEVKITPRO=/opt/devkitpro
		export DEVKITARM=/opt/devkitpro/devkitARM
		export DEVKITPPC=/opt/devkitpro/devkitPPC
		export LIBVA_DRIVER_NAME=radeonsi
		export VDPAU_DRIVER=radeonsi
		
		## Proton Exports ##
		export STEAM_COMPAT_DATA_PATH=/home/nikos/.proton
		export STEAM_COMPAT_CLIENT_INSTALL_PATH=""
		
		## Wine aliases ##
		alias wine32="WINEARCH=win32 WINEPREFIX=/home/nikos/.wine32 wine"
		alias winetricks32="WINEARCH=win32 WINEPREFIX=/home/nikos/.wine32 winetricks"
		
		## Random Utillities ##
		# Network webcam aliases
		#alias env4l2loop="sudo modprobe v4l2loopback exclusive_caps=1"
		#alias disv4l2loop="sudo modprobe -r v4l2loopback"
		#alias netwebcam="ssh nikos@192.168.0.61 ffmpeg -an -f video4linux2 -s 1280x720 -i /dev/video0 -r 10 -b:v 5000k -f avi - | ffmpeg -re -i /dev/stdin -c:v rawvideo -map 0:v -f v4l2 /dev/video0"
		#alias netwebcamll="ssh $laptop_ssh ffmpeg -an -f video4linux2 -s 1280x720 -i /dev/video0 -r 10 -b:v 5000k -f avi - | ffmpeg -re -i /dev/stdin -codec copy -map 0:v -f v4l2 /dev/video0"
		#alias mpvnetwebcam="ssh nikos@192.168.0.61 ffmpeg -an -f video4linux2 -s 1280x720 -i /dev/video0 -r 10 -b:v 5000k -f avi - | mpv /dev/stdin --profile=low-latency --untimed"
		
		# FFMPEG aliases
		#alias hwffmpeg="VK_ICD_FILENAMES=/usr/share/vulkan/icd.d/amd_pro_icd64.json ffmpeg -hwaccel auto -vaapi_device /dev/dri/renderD128"
        ;;
    "laptop")
		## Unaliases ##
		unalias sshltp
		
		## Driver exports ##
		# Intel drivers
		export LIBVA_DRIVER_NAME=i965
		export VDPAU_DRIVER=va_gl
		# ATI Drivers
		#export LIBVA_DRIVER_NAME=radeonsi
		#export VDPAU_DRIVER=radeonsi
		
		## Wine Exports ##
		export WINEPREFIX="$HOME/.wine32"
		export WINEARCH=win32
		
		## Proton Exports ##
		export STEAM_COMPAT_DATA_PATH=/home/nikos/.proton
		export STEAM_COMPAT_CLIENT_INSTALL_PATH=""
		export PROTON_USE_WINED3D=1
		export LITE_SCALE=0.9
		alias wine32="WINEARCH=win32 WINEPREFIX=/home/nikos/.wine32 wine"
		## Distcc configs ##
		#append_path "/usr/lib/distcc/bin"
		#export PATH=$PATH:/usr/lib/distcc/bin
		#export DISTCC_HOSTS="localhost/2 $compy_ip/4"
		
		## Random Utillities ##
		alias inteltop="intel_gpu_top"
		alias checkbat='upower -i /org/freecompy/UPower/devices/battery_BAT1 | grep -E "state|to\ full|percentage"'
		alias wifidmesg="sudo dmesg | grep -Ei 'firm|wl' | grep -v drm"
        ;;
    "switch")
		## Unaliases ##
		unalias sshswitch
		#unset -f joycon-ssh
		
		## Distcc configs ##
		#append_path "/usr/lib/distcc/bin"
		#export PATH=$PATH:/usr/lib/distcc/bin
		#export DISTCC_HOSTS="localhost/4 $compy_ip/4:3636"
		
		## Random exports ##
		#export DISPLAY=:0
		export LC_ALL="es_AR.UTF-8"
		
		## Random Utillities ##
		alias checkbat='upower -i /org/freecompy/UPower/devices/battery_battery | grep -E "state|to\ full|percentage"'
		alias nvplist="cat /etc/nvpmodel.conf | grep 'POWER_MODEL ID'"
		alias nvpmodel="sudo nvpmodel"
        ;;
esac
