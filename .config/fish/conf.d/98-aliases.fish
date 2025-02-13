## aliases

alias lsa="ls -a"
alias ll="ls -l"
alias lla="ls -la"
#alias mv="mv -i"
#alias cp="cp -i"
#alias rm="rm -i"

alias kys="systemctl poweroff"
alias gts="systemctl suspend"
alias reboot="systemctl reboot"

alias sudo="doas"
alias ip="ip --color"
alias ipget="ip -br -c a"
alias hotp='htop'
alias hopt='htop'
alias botp='btop'
alias bopt='btop'
alias n='nnn -dea'
alias nc='ncmpcpp'
alias nv='nvim'
alias delcache='rm -rf ~/.cache'
alias dropcache='echo 3 | sudo tee /proc/sys/vm/drop_caches'
alias reswap='sudo systemctl restart zramd ; sudo swapoff -a ; sudo swapon -a'
alias redaemons='sudo systemctl restart jellyfin;systemctl --user restart syncthing'
alias killvirt='sudo systemctl stop {libvirtd-admin.socket,libvirtd,libvirtd.socket,libvirtd-ro.socket,virtlogd,virtlogd.socket,virtlogd-admin.socket}'

alias rekwin="killall kwin_x11 && kstart5 kwin_x11"
# alias replasma="killall plasmashell && kstart5 plasmashell"
alias replasma='systemctl --user restart plasma-plasmashell.service'
alias dpmson='xset +dpms && xset s on'
alias dpmsoff='xset -dpms && xset s off'
alias tmux="tmux -2"
alias py="python3"

alias calc="qalc -t"
alias fetch="fastfetch"
alias mpvwebcam="mpv av://v4l2:/dev/video0 --profile=low-latency --untimed"
alias droidcamloop='pacmd load-module module-alsa-source source_properties=device.description=DroidCam device=hw:Loopback,1,0'
alias droidcamloopkill='pacmd unload-module module-alsa-source'

alias lutrisfzf='lutris "lutris:rungame/$(sqlite3 .local/share/lutris/pga.db ".separator \t" "select name,slug from games order by lastplayed desc" | fzf -d "\t" --with-nth=1 --layout=reverse | cut -f2)" & disown'
alias ytfzfpip='ytfzf -u mpvpip'
alias ytfzfsubs='ytfzf -cS --sort'
alias pvol='pactl set-sink-volume @DEFAULT_SINK@'

# Funny package aliases hehehaha
alias killorphans='sudo apt autoremove -y'
# alias killorphans='sudo pacman -Rns $(pacman -Qqtd)'
# alias killfamily="sudo pacman -Rns"
# alias pacgenocide="sudo pacman -Scc"
# alias pachitlist="pacman -Qqe | fzf --multi --preview 'pacman -Qi {1}' | xargs -ro sudo pacman -Rns"

alias randhash='openssl rand -base64 12'
alias randpolschizo="curl -s https://a.4cdn.org/pol/catalog.json | jq '.[0].threads[2].last_replies[0].com' | sed 's/<.*>//gm' | recode -f html...ascii"
alias getdolar='curl https://dolarapi.com/v1/dolares -s | sed \'s/Contado con liquidación/CCL/g\' | jq -r \'(["Tipo","Precio"] | (., map(length*"-"))), (.[] | [.nombre, .venta]) | @tsv\' | column -t'
alias dtf='/usr/bin/git --git-dir=$HOME/.dtf/__repo/ --work-tree=$HOME'
alias emacst='emacs -nw'
alias luaenv='eval "$(luarocks path --bin)"'
alias cpplines="find . ! -wholename './.git/*' ! -wholename './build/*' ! -wholename '*extern*' \\( -name '*.cpp' -o -name '*.hpp' \\) | xargs wc -l"

