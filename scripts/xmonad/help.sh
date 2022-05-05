#!/bin/bash

case "$1" in
	p) # Prompt
		notify-send "Prompt" "\
'M-p n'     --> Plain Notes Prompt
'M-p o'     --> Org Prompt
'M-p d'     --> Execute Scripts Directory
'M-p l'     --> Layout Prompt
'M-p m'     --> Man Prompt
'M-p r'     --> Run or raise window
'M-p p'     --> Prompt Terminal Program
'M-p t'     --> Theme Prompt
'M-p u'     --> Unicode Prompt
'M-p w g'   --> Prompt: Goto window
'M-p w b'   --> Prompt: Bring window to Current Workspace
'M-p x'     --> Xmonad Prompt\
"
		;;
	n) # Notification
		notify-send "Notification" "\
'M-n c'     --> Notifications Center
'M-n h o'   --> Highlight On
'M-n h f'   --> Highlight Off
'M-n d c'   --> Clear Center
'M-n d p'   --> Clear Popups
'M-n p'     --> Pause Notifications
'M-n u'     --> Unpause Notifications
'M-n r'     --> Reload Style
'M-n t g'   --> Gtk icon
'M-n t i'   --> Image file
'M-n t n'   --> Notification Center Only
'M-n t a'   --> Action buttons gtk icons
'M-n t p 1' --> with progress bar
'M-n t p 2' --> with progress bar
'M-n t s'   --> with slider\
"
		;;
	w) # Notification
		notify-send "Wallpaper" "\
'M-w r'     --> Random Background
'M-w p'     --> Previous Background
'M-w n'     --> Next Background\
"
		;;
	c) # Change Layout
		notify-send "Change Layout" "\
'M-c 1'     --> Switch to 'Tall' layout
'M-c 2'     --> Switch to 'Mirror Tall' layout
'M-c 3'     --> Switch to 'Full' layout
'M-c 4'     --> Switch to 'Magnifier NoMaster ThreeCol' layout\
"
		;;
	s) # Spawn
		notify-send "Spawn" "\
'M-s c'     --> Spawn Click4ever
'M-s p'     --> Spawn pavucontrol
'M-s r'     --> Spawn vokoscreenNG
'M-s b'     --> Spawn chrome
'M-s h'     --> Spawn hakuneko-desktop
'M-s s'     --> Spawn spotify\
"
		;;

	t) # Toggle
		notify-send "Toggle" "\
'M-t f'     --> Toggle Fullscreen
'M-t M-f'   --> Toggle Fullscreen
'M-t t'     --> Force focused window back into tiling
'M-t M-t'   --> Force focused window back into tiling\
"
		;;

	i) # Info
		notify-send "Info" "\
'M-i /'     --> Help Info
'M-i p'     --> Info ping
'M-i b'     --> Info battery
'M-i d'     --> Info date
'M-i c'     --> Info cpu
'M-i m'     --> Info memory\
"
		;;

	m) # Menu
		notify-send "Menu" "\
'M-m /'     --> Help Menu
'M-m p'     --> Menu ping
'M-m b'     --> Menu battery
'M-m d'     --> Menu date
'M-m c'     --> Menu cpu
'M-m m'     --> Menu memory
'M-m M-m'   --> Menu Mein
"
		;;

	*) # Default
		notify-send "Default" "\
'/'  Help 
'M-p /' Prompt 

'M-x'  Open Tree 
'M-S-x'  Open Tree workspaces 

'M-n /'  Notifications 

'M-w /'  Wallpaper

'M-g'  Grid Select go to window 
'M-S-g'  Grid Select swap program 

'M-c /'  Help Layouts 

'M-v'  Select from Green Clip and set as current clipboard value 
'M-S-v'  Select from Green Clip and paste 
'M-C-S-v'  Clear Green Clip 
'M1-<F4>'  Alt F4, kill windwow 
'M-S-l'  Lock WM 
'M1-<F2>'  Dmenu launch program 
'M-<Print>'  Full Screenshot 
'M-S-<Print>'  Snip Screenshot 
'M-z'  Spawn Eww Sidebar 
'M-S-z'  Spawn Eww dubs 

'M-s /'  Help Spawn 

'<XF86XK_MonBrightnessDown>'  light down 
'<XF86XK_MonBrightnessUp>'  light up 
'<XF86XK_AudioLowerVolume>'  vol down 
'<XF86XK_AudioRaiseVolume>'  vol up 
'<XF86XK_AudioMute>'  vol mute 
'<XF86XK_AudioPlay>'  media play-pause 
'<XF86XK_AudioNext>'  media next 
'<XF86XK_AudioPrev>'  media previous 
'M-<F2>'  light down 
'M-<F3>'  light up 
'M-<F7>'  vol down 
'M-<F8>'  vol up 
'M-<F6>'  vol mute 
'M-<F10>'  media play-pause 
'M-<F11>'  media next 
'M-<F9>'  media previous 
'M-a'  Make window sticky 
'M-S-a'  Unstick window 

'M-t /'  Help Toggles 

'M-h'  focus left 
'M-j'  focus down 
'M-k'  focus up 
'M-l'  focus right 

'M-S-h'  swap left 
'M-S-j'  swap down 
'M-S-k'  swap up 
'M-S-l'  swap right 

'M-C-h'  move left 
'M-C-j'  move down 
'M-C-k'  move up 
'M-C-l'  move right 

'M-<L>'  move float left 
'M-<R>'  move float right 
'M-<U>'  move float up 
'M-<D>'  move float down 

'M-S-<L>'   
'M-S-<R>'   
'M-S-<D>'   
'M-S-<U>'   
'M-C-<L>'   
'M-C-<R>'   
'M-C-<U>'   
'M-C-<D>'   

'M-e f'  EasyMotion focus window 
'M-e k'  EasyMotion kill window \
"
		;;
esac
