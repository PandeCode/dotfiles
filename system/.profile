source ~/dotfiles/extras/envs.sh

export NO_AT_BRIDGE=1
eval $(dbus-launch --sh-syntax)
export DBUS_SESSION_BUS_ADDRESS
export DBUS_SESSION_BUS_PID
export DBUS_SESSION_BUS_WINDOWID
