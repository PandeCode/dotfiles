picom --refresh-rate 30 --glx-no-rebind-pixmap --use-damage  --xrender-sync-fence  --backend glx --glx-fshader-win "$(cat clortkeyramp.glsl)" --config picom.conf
