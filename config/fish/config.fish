complete -f -c dotnet -a "(dotnet complete)"
thefuck --alias | source
starship init fish | source
set -gx RUST_BACKTRACE 1
set -gx BROWSER ~/.local/bin/google-chrome-stable
set -gx EDITOR nvim
set -gx GPG_TTY (tty)
set -g fish_emoji_width 1
set -g fish_ambiguous_width 1

source ~/.config/fish/functions/userFuntions.fish

if test -f /home/shawn/.autojump/share/autojump/autojump.fish
    . /home/shawn/.autojump/share/autojump/autojump.fish
end
