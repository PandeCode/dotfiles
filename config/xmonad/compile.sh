#!/bin/sh

clear && tmux clear

emacs --batch --eval "(require 'org)" --eval '(org-babel-tangle-file "README.org")' &&
	xmonad --recompile &&
	xmonad --restart
