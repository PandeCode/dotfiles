alias cls=clear
alias ccache='go clean --modcache & npm cache clean --force & yarn cache clean --force & python3 -m pip cache purge & python2 -m pip cache purge & rm -fr /home/shawn/.cache/thumbnails ~/.local/share/baloo & sudo journalctl --vacuum-time=3d && yay -Scc --noconfirm & yay -R (yay -Qtdq) --noconfirm'
alias cmg='cmake -D CMAKE_EXPORT_COMPILE_COMMANDS=ON -S . -B Debug && ln -s ./Debug/compile_commands.json ./compile_commands.json'
alias cmb='cmake --build Debug/'
alias cmc='rm -fr CMakeCache.txt cmake_install.cmake Makefile CMakeFiles Debug/ compile_commands.json build'
alias chrome='google-chrome-stable --force-dark-mode'
alias cs='xclip -selection clipboard -o'
alias f=fuck
alias idea='nvim /home/shawn/dev/ideas.txt'
alias l='ls -latr'
alias md=mkdir
alias mesa='sudo sysctl dev.i915.perf_stream_paranoid=0'
alias pacman='sudo pacman'
alias pamac='sudo pamac'
alias py=python3
alias sizeof='du -h --max-depth=0'
alias sl=ls
alias tcls='clear && tmux clear'
alias tls='clear && tmux clear'
alias tree='tree -I "CMakeFiles|node_modules|cache"'
alias weather='curl wttr.in && curl "wttr.in?format=1" && curl "wttr.in?format=2"&& curl "wttr.in?format=3" && curl "wttr.in?format=4" && curl wttr.in/moon'

alias browsePackages="yay -Slq | fzf --preview 'yay -Si {}' --layout=reverse"
alias browseInstalledPackages="yay -Qq | fzf --preview 'yay -Qil {}' --layout=reverse --bind 'enter:execute(yay -Qil {} | less)'"
