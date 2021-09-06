function cmd
    #mkdir -p $argv
    #cd $argv
    eval {mkdir,cd}\ $argv\;
end
funcsave cmd
