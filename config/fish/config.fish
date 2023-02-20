starship init fish | source
thefuck --alias | source

set -g fish_emoji_width 1
set -g fish_ambiguous_width 1
set -gx GPG_TTY (tty)

[ -f /usr/share/autojump/autojump.fish ]; and source /usr/share/autojump/autojump.fish

if test -f /home/shawn/.autojump/share/autojump/autojump.fish
    . /home/shawn/.autojump/share/autojump/autojump.fish
end
if status is-interactive
    # Commands to run in interactive sessions can go here
end


