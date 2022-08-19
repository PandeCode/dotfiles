thefuck --alias | source
starship init fish | source

complete -f -c dotnet -a "(dotnet complete)"

if test -f /home/shawn/.autojump/share/autojump/autojump.fish
    . /home/shawn/.autojump/share/autojump/autojump.fish
end

set -g fish_emoji_width 1
set -g fish_ambiguous_width 1

set -gx GPG_TTY (tty)

[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish
