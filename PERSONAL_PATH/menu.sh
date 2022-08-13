#!/bin/sh

CONFIGDIR=$HOME/dotfiles/dotfiles/config/
TERMINAL=st

function getShaders {
	shaderDir="$HOME/dotfiles/config/picom/shaders"
	shaders=`ls $shaderDir`

	for shader in $shaders
	do
		echo "		${shader::-5}	~/dotfiles/config/picom/setShader.sh $shaderDir/$shader"
	done
}


cat << EOF | xmenu -i -p 0x25:1 | sh &
Background
	Random                                    	 randbg
	Previous                                  	 prevbg
	
Media
	Play                                      	 playerctl play
	Pause                                     	 playerctl pause
	
Picom
	Shaders
$(getShaders)
	Off                                       	 killall -9 picom
	On                                        	 picom --experimental-background -b 1>> ~/log/picom.log 2>> ~/log/picom.err.log
	Rounded Corners                           	 ~/dotfiles/scripts/picom.sh rounded
	Blur                                      	 ~/dotfiles/scripts/picom.sh blur
	Animation                                 	 ~/dotfiles/scripts/picom.sh animation
	
Lang
	Clipboard To English                      	 ~/dotfiles/scripts/lang/clipboardToEnglish
	Clipboard To Speech                       	 ~/dotfiles/scripts/lang/clipboardToSpeech
	Clipboard To Speech English               	 ~/dotfiles/scripts/lang/clipboardToSpeechEn
	Picture To English                        	 ~/dotfiles/scripts/lang/pictureToEnglish
	Picture To Clipboard                      	 ~/dotfiles/scripts/lang/pictureToClipboard
	QR Code                                   	 ~/dotfiles/scripts/lang/qrCodeToClipboard
	
 Notifications
	Notifications Center                      	 kill -s USR1 \$(pidof deadd-notification-center)
	Highlight On                              	 notify-send.py a --hint boolean:deadd-notification-center:true int:id:0 boolean:state:true type:string:buttons
	Highlight Off                             	 notify-send.py a --hint boolean:deadd-notification-center:true int:id:0 boolean:state:false type:string:buttons
	Clear Center                              	 notify-send.py a --hint boolean:deadd-notification-center:true string:type:clearInCenter
	Clear Popups                              	 notify-send.py a --hint boolean:deadd-notification-center:true string:type:clearPopups
	Pause                                     	 notify-send.py a --hint boolean:deadd-notification-center:true string:type:pausePopups
	Unpause                                   	 notify-send.py a --hint boolean:deadd-notification-center:true string:type:unpausePopups
	Reload Style                              	 notify-send.py a --hint boolean:deadd-notification-center:true string:type:reloadStyle
	Tests
		Gtk icon                              	 notify-send.py "Icons are" "COOL"  --hint string:image-path:face-cool
		Image file                            	 notify-send.py "Images" "COOL"  --hint string:image-path:file://$HOME/Pictures/Wallpapers/minecraft_swamp.jpeg
		Notification Center Only              	 notify-send.py "Does pop up" -t 1
		Action buttons gtk icons              	 notify-send.py "1" "2"  --hint boolean:action-icons:true  --action yes:face-cool no:face-sick
		with progress bar                     	 notify-send.py "This notification has a progressbar" "33%"  --hint int:has-percentage:33
		with progress bar                     	 notify-send.py "This notification has a progressbar" "33%"  --hint int:value:33
		with slider                           	 notify-send.py "This notification has a slider" "33%"  --hint int:has-percentage:33 --action changeValue:abc
	
 Applications
	 Chrome                                  	 chrome
	 Terminal                                	 $TERMINAL
	 Files                                   	 nautilus
	 Keys                                    	 vimb ~/dev/Keys/keys.html
	
	 School
		 canvas-tui                          	 $TERMINAL -e canvas-tui
		 Zotero                              	 zotero
		 CS                                  	 $TERMINAL -e ranger  ~/Documents/school
	 Comms
		Discord (GUI)                         	 discord
		Discord (cordless)                    	 $TERMINAL -e cordless
		 Email (Neomutt)                     	 $TERMINAL -e neomuttjj
		 IRC (weechat)                       	 $TERMINAL -e weechat
		 SMS (kde-connect)                   	 kdeconnect-sms --style gtk2
		 Slack                               	 slack
		 Signal (GUI)                        	 signal-desktop
		 Telegram (GUI)                      	 telegram-desktop
		 Telegram (nctelegram)               	 nctelegram
	 Finance
		 Crypto (TUI)                        	 $TERMINAL -e cointop
		 Stocks (TUI)                        	 $TERMINAL -e mop
		 Stonks (CLI)                        	 $TERMINAL -e mop
	 Utilities
		 Calculator (TUI)                    	 $TERMINAL -e qalq
		 Calculator (GUI)                    	 qalculate-gtk
		 Calendar (khal)                     	 $TERMINAL -e khal interactive
		 Color Picker                        	 gpick
		 Map (TUI)                           	 $TERMINAL -e mapscii
		
		 System
			 Keyboard (Corsair)              	 ckb-next
			 Fonts                           	 gucharmap
			 Smartphone (kdeconnect)         	 kdeconnect-app --style gtk2
			 Docker (lazydocker)             	 $TERMINAL -e lazydocker
			 Kill Window                     	 xkill
			 Screen Recording (vokoscreenNG) 	 vokoscreenNG
			 Screenshot
				GUI                           	 flameshot gui
				All Displays                  	 flameshot screen -d 5000 -n 3 -p $HOME/Photos/screenshots
				Middle Display                	 flameshot screen -d 5000 -n 0 -p $HOME/Photos/screenshots
				Right Display                 	 flameshot screen -d 5000 -n 1 -p $HOME/Photos/screenshots
				Left Display                  	 flameshot screen -d 5000 -n 2 -p $HOME/Photos/screenshots
		 Personal
			 Nextcloud                       	 nextcloud --style gtk2
			 Passwords (keepassxc)           	 keepassxc --style gtk2
			 Keys (Seahorse)                 	 seahorse
		 Theming
			lxappearance                      	 lxappearance
			GTK (oomox)                       	 oomox-gui
			Qt (qt5ct)                        	 qt5ct --style gtk2
			WPGTK                             	 wpg
		 Monitors
			System (ytop)                     	 $TERMINAL -e ytop
			System (bashtop)                  	 $TERMINAL -e bashtop
			System (glances)                  	 $TERMINAL -e glances
			
			Disk Usage (GUI)                  	 baobab
			Disk Usage (TUI)                  	 $TERMINAL -e ncdu
			IO (iotop)                        	 $TERMINAL -e iotop
			
			Kernel (kmon)                     	 $TERMINAL -e kmon
			Intel GPU (intel_gpu_top)         	 $TERMINAL -e sudo intel_gpu_top
			Nvidia GPU (nvtop)                	 $TERMINAL -e nvtop
			Power (powertop)                  	 $TERMINAL -e powertop
			
			DNS (dnstop)                      	 $TERMINAL -e powertop
			Network Usage (jnettop)           	 $TERMINAL -e jnettop
			Network Load (nload)              	 $TERMINAL -e nload
			Bandwidth (bmon)                  	 $TERMINAL -e bmon
			Media Server                      	 $TERMINAL -e jellyfinips.sh
		 Media
			 EasyTag                         	 easytag
	 Entertainment
		 Media
			VLC                               	 vlc
			 Podcasts (castero)              	 castero
			 RSS (newsboat)                  	 newsboat
			 Reddit (tuir)                   	 tuir
			 Music (cmus)                    	 cmus
			 Spotify (GUI)                   	 spotify
			 Spotify (spotifytui)            	 spt
			Soulseek (Nicotine+)              	 nicotine
		 Games
			 Steam                           	 steam
			Itch                              	 itch
			Lutris                            	 lutris
			Tetris                            	 tetris
			Solitaire                         	 ttysolitaire
			Battleship                        	 bs
			Minecraft                         	 minecraft-launcher
			Dopewars                          	 dopewars
		 Misc
			cava                              	 $TERMINAL -e cava
			pipes.sh                          	 $TERMINAL -e pipes.sh
			rain.sh                           	 $TERMINAL -e rain.sh
			unimatrix                         	 $TERMINAL -e unimatrix -l Gg
			asciiquarium                      	 $TERMINAL -e asciiquarium
			bonsai.sh                         	 $TERMINAL -e bonsai -l -i -T
			eDEX-UI                           	 sh -c (cd $HOME/Programs/edex-ui/ ; npm start)
		Sounds
			ahhyooaaawhoaaa.mp3               	 mpv --volume=50 ~/Music/SoundEffects/ahhyooaaawhoaaa.mpv
			bruh.m4a                          	 mpv --volume=50 ~/Music/SoundEffects/bruh.m4a	mpv
			realln.mp3                        	 mpv --volume=50 ~/Music/SoundEffects/realln.mp3	mpv
	 Science
		 Astronomy
			Celestia                          	 celestia
		 Biology
			Pymol                             	 pymol
		 Chemistry
			ptable                            	 $TERMINAL -e ptable
			chemtool                          	 chemtool
		 Math
			Desmos                            	 desmos
			Geogebra                          	 geogebra
		Anki                                  	 anki
	 Development
		 IDEs
			Neovim                            	 $TERMINAL -e nvim
			VS Code                           	 code
			Dr. Racket                        	 drracket
		 Github (TUI)                        	 $TERMINAL -e github
		bitwise                               	 bitwise
		Github Activity (TUI)                 	 $TERMINAL -e sh -c 'ghcal --no-ansi ; read'
		QDbusViewer                           	 qdbusviewer --style gtk2

 Configs
	 System
		 i3                                  	 $TERMINAL -e nvim $CONFIGDIR/i3/config
		 Start Menu                          	 $TERMINAL -e nvim $HOME/dotfiles/dotfiles/scripts/xmenu.sh
		 Notifications                       	 $TERMINAL -e nvim $CONFIGDIR/wal/templates/dunstrc
		 Smartphone                          	 kdeconnect-settings --style gtk2
		 Sound                               	 pavucontrol
		 Shell
			fish
				config.fish                   	 $TERMINAL -e nvim $CONFIGDIR/fish/config.fish
				Web Config                    	 fish -c fish_config
			bash                              	 $TERMINAL -e nvim $HOME/.bashrc
		 polybar
			config                            	 $TERMINAL -e nvim $CONFIGDIR/polybar/config
			launch.sh                         	 $TERMINAL -e nvim $CONFIGDIR/polybar/scripts/launch.sh
		 rofi
			config                            	 $TERMINAL -e nvim $CONFIGDIR/rofi/config
			template                          	 $TERMINAL -e nvim $CONFIGDIR/wal/templates/custom-rofi.rasi
		 Utilities
			 khard                           	 $TERMINAL -e nvim $CONFIGDIR/khard/khard.conf
			 khal                            	 $TERMINAL -e nvim $CONFIGDIR/khal/config
			 vdirsyncer                      	 $TERMINAL -e nvim $CONFIGDIR/vdirsyncer/config
		 .Xresources                         	 $TERMINAL -e nvim $HOME/.Xresources
	 User
		ranger                                	 $TERMINAL -e nvim $CONFIGDIR/ranger/rc.conf
		newsboat                              	 $TERMINAL -e nvim $CONFIGDIR/newsboat/config
		neomutt
			neomuttrc                         	 $TERMINAL -e nvim $CONFIGDIR/neomutt/neomuttrc
			colors                            	 $TERMINAL -e nvim $CONFIGDIR/neomutt/colors
			settings                          	 $TERMINAL -e nvim $CONFIGDIR/neomutt/settings
			mappings                          	 $TERMINAL -e nvim $CONFIGDIR/neomutt/mappings
			mailcap                           	 $TERMINAL -e nvim $CONFIGDIR/neomutt/mailcap
		neovim
			coc-settings                      	 $TERMINAL -e nvim $HOME/.config/nvim/coc-settings.json
			functions                         	 $TERMINAL -e nvim $HOME/.config/nvim/configs/functions.vim
			main                              	 $TERMINAL -e nvim $HOME/.config/nvim/configs/main.vim
			mappings                          	 $TERMINAL -e nvim $HOME/.config/nvim/configs/mappings.vim
			plugin-settings                   	 $TERMINAL -e nvim $HOME/.config/nvim/configs/plugin-settings.vim
			plugins                           	 $TERMINAL -e nvim $HOME/.config/nvim/configs/plugin.vim
		neofetch                              	 $TERMINAL -e nvim $CONFIGDIR/neofetch/config.conf
		htop                                  	 $TERMINAL -e nvim $CONFIGDIR/htop/htoprc
		s-tui                                 	 $TERMINAL -e nvim $CONFIGDIR/s-tui/s-tui.conf
		spicetify                             	 $TERMINAL -e nvim $CONFIGDIR/spicetify/config.ini
		stonks                                	 $TERMINAL -e nvim $CONFIGDIR/stonks.yml

 System
	Update
		All                                   	 $TERMINAL -e sudo ~/dotfiles/scripts/updateAll.sh
		pacman                                	 $TERMINAL -e sudo pacman -Syyuu --overwrite "*" --noconfirm
		paru                                  	 $TERMINAL -e sudo clear; CXX=g++ CC=gcc paru -Syyuu --overwrite "*" --noconfirm
		python3                               	 $TERMINAL -e python3 -m pip install --upgrade \$(python3 -m pip list --outdated | sed "1,2d;s/ .*//;")
		python2                               	 $TERMINAL -e python2 -m pip install --upgrade \$(python2 -m pip list --outdated  | sed "1,2d;s/ .*//;")
		cargo                                 	 $TERMINAL -e cargo install \$(cargo install --list | egrep '^[a-z0-9_-]+ v[0-9.]+:$' | cut -f1 -d' ')
		ruby                                  	 $TERMINAL -e gem update --system
		go                                    	 $TERMINAL -e go get -u  && go mod tidy
		npm                                   	 $TERMINAL -e sudo npm -g upgrade
		yarn                                  	 $TERMINAL -e yarn global upgrade
	Clean Cache
		All                                   	 $TERMINAL -e sudo ~/dotfiles/scripts/cleanAll.sh
		Files                                 	 $TERMINAL -e sudo rm -fr ~/.npm ~/.lesshst ~/.cache/thumbnails ~/.local/share/baloo ~/.cache/cpython/
		pacman|paru                           	 $TERMINAL -e sudo clear; paru -Scc --noconfirm & paru -R (paru -Qtdq) --noconfirm
		python3                               	 $TERMINAL -e python3 -m pip cache purge
		python2                               	 $TERMINAL -e python2 -m pip cache purge
		npm                                   	 $TERMINAL -e npm cache clean --force
		yarn                                  	 $TERMINAL -e yarn cache clean --force
		go                                    	 $TERMINAL -e go clean --modcache
	
	 Refresh dwm                             	 pkill -9 dwm
	 Refresh dwmblocks                       	 pkill -9 dwmblocks
	
	 Logout                                  	 pkill -9 bash
	 Shutdown                                	 poweroff
	 Reboot                                  	 reboot
EOF
