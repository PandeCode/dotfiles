HOME=/home/shawn
 
export WINEESYNC=1
export WINEDEBUG=-all
export DXVK_LOG_LEVEL=none

export _JAVA_AWT_WM_NONREPARENTING=1

export TERMINAL=/usr/bin/st
export CC=/usr/bin/clang
export CXX=/usr/bin/clang++
export SHELL=/bin/bash
export EDITOR=/usr/bin/nvim

export GHCUP_BIN=$HOME/.ghcup/bin

export QT_QPA_PLATFORMTHEME="qt5ct"
export QT_AUTO_SCREEN_SCALE_FACTOR=0
export GTK2_RC_FILES="$HOME/.gtkrc-2.0"

export XMONAD_CONFIG_DIR=$HOME/.config/xmonad
export XMOBAR_CONFIG_DIR=$HOME/.config/xmobar
export DOOMDIR=$HOME/.doom.d
export XDG_CONFIG_HOME=$HOME/.config
export XDG_CACHE_HOME=$HOME/.cache
export PYTHONPYCACHEPREFIX=$HOME/.cache/cpython/
export PYTHONSTARTUP=$HOME/.pythonrc
export PYTHON_PATH=$HOME/dev/python/PYTHON_PATH

export DOTFIlES=$HOME/dotfiles
export PERSONAL_PATH=$HOME/dotfiles/PERSONAL_PATH

export YARN_BIN=$HOME/.yarn/bin
export RUBY_GEM_BIN_PATH=$HOME/.local/share/gem/ruby/3.0.0/bin

export GOPATH=$HOME/go

export PATH=$PERSONAL_PATH:$GHCUP_BIN:$PATH:$GOROOT/bin:$GOPATH/bin:$HOME/bin:$YARN_BIN:$RUBY_GEM_BIN_PATH:$HOME/.emacs.d/bin

preview="fzfPreview.sh {}"
export FZF_DEFAULT_OPTS="
--color=fg:#f8f8f2,bg:#282a36,hl:#bd93f9
--color=fg+:#f8f8f2,bg+:#44475a,hl+:#bd93f9
--color=info:#ffb86c,prompt:#50fa7b,pointer:#ff79c6
--color=marker:#ff79c6,spinner:#ffb86c,header:#6272a4
--layout=reverse
--info=inline
--height=80%
--multi
--border
--ansi
--preview-window=:hidden
--preview '$preview'
--prompt='∼ ' --pointer='▶' --marker='✓'
--bind '?:toggle-preview'
--bind 'ctrl-a:select-all'
--bind 'ctrl-y:execute-silent(echo {+} | pbcopy)'
--bind 'ctrl-e:execute(echo {+} | xargs -o vim)'
--bind 'ctrl-v:execute(code {+})'
--bind 'ctrl-k:preview-up'
--bind 'ctrl-j:preview-down'
--bind 'ctrl-r:reload(ps aux)' 
"

export FZF_DEFAULT_COMMAND="fdfind --follow --hidden --exclude .git --exclude 'node_modules' --color=always"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND --type d"

export FORGIT_FZF_DEFAULT_OPTS="
--exact
--border
--cycle
--reverse
--height '80%'
"
