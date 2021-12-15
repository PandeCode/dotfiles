import System.IO
import System.Exit

import Data.Char (isSpace, toUpper)
import Data.Maybe
import Data.Monoid
import Data.Tree
import qualified Data.Map        as M
import Data.List
import Data.Ratio ((%))

import XMonad

import XMonad hiding ( (|||) )

import XMonad.Actions.CopyWindow
import XMonad.Actions.CycleWS
import XMonad.Actions.DynamicWorkspaces
import XMonad.Actions.EasyMotion (selectWindow, EasyMotionConfig(..), proportional, bar, fullSize)
import XMonad.Actions.FloatKeys
import XMonad.Actions.FloatSnap
import XMonad.Actions.GridSelect
import XMonad.Actions.Navigation2D
import XMonad.Actions.Promote
import XMonad.Actions.RotSlaves
import XMonad.Actions.Search
import XMonad.Actions.SinkAll
import XMonad.Actions.SpawnOn
import XMonad.Actions.TreeSelect
import XMonad.Actions.UpdatePointer
import XMonad.Actions.WindowGo

import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.ServerMode
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.UrgencyHook
import XMonad.Hooks.WorkspaceHistory

import XMonad.Layout hiding ( (|||) )
import XMonad.Layout.DwmStyle
import XMonad.Layout.Grid
import XMonad.Layout.IM
import XMonad.Layout.LayoutCombinators
import XMonad.Layout.LayoutHints
import XMonad.Layout.LayoutModifier
import XMonad.Layout.Magnifier
import XMonad.Layout.Named
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.Tabbed
import XMonad.Layout.ThreeColumns
import XMonad.Layout.ToggleLayouts
import XMonad.Layout.TwoPane
import XMonad.Layout.WindowNavigation

import XMonad.Prompt
import XMonad.Prompt.AppLauncher
import XMonad.Prompt.AppLauncher as AL
import XMonad.Prompt.AppendFile
import XMonad.Prompt.ConfirmPrompt
import XMonad.Prompt.DirExec
import XMonad.Prompt.Directory
import XMonad.Prompt.Email
import XMonad.Prompt.FuzzyMatch
import XMonad.Prompt.Input
import XMonad.Prompt.Layout
import XMonad.Prompt.Man
import XMonad.Prompt.OrgMode
import XMonad.Prompt.Pass
import XMonad.Prompt.RunOrRaise
import XMonad.Prompt.Shell
import XMonad.Prompt.Ssh
import XMonad.Prompt.Theme
import XMonad.Prompt.Unicode
import XMonad.Prompt.Window
import XMonad.Prompt.Workspace
import XMonad.Prompt.XMonad
import XMonad.Prompt.Zsh

import XMonad.Util.ClickableWorkspaces
import XMonad.Util.EZConfig
import XMonad.Util.Font
import XMonad.Util.Loggers
import XMonad.Util.NamedWindows (getName)
import XMonad.Util.Run
import XMonad.Util.Scratchpad
import XMonad.Util.SpawnOnce
import XMonad.Util.Themes
import XMonad.Util.Ungrab
import XMonad.Util.WindowProperties
import XMonad.Util.WorkspaceCompare
import XMonad.Util.XSelection

import qualified XMonad.Actions.ConstrainedResize as SQR
import qualified XMonad.Actions.FlexibleResize as FlexR
import qualified XMonad.Actions.Submap as SM
import qualified XMonad.Layout.Magnifier as Mag
import qualified XMonad.StackSet as W
import qualified XMonad.Util.Hacks as Hacks

myTerminal = "st"

myModMask = mod4Mask -- Rebind Mod to the Super key

myFont = "xft:DejaVu Sans Condensed-16:normal"

-- Deep ocean
deepOcean :: M.Map String [Char]
deepOcean =
  M.fromList
    [ ("background", "#0F111A"),
      ("foreground", "#8F93A2"),
      ("text", "#4B526D"),
      ("selectionBackground", "#717CB480"),
      ("selectionForeground", "#FFFFFF"),
      ("buttons", "#191A21"),
      ("secondBackground", "#181A1F"),
      ("disabled", "#464B5D"),
      ("contrast", "#090B10"),
      ("active", "#1A1C25"),
      ("border", "#0F111A"),
      ("highlight", "#1F2233"),
      ("tree", "#717CB430"),
      ("notifications", "#090B10"),
      ("accentColor", "#84ffff"),
      ("excludedFilesColor", "#292D3E"),
      ("greenColor", "#c3e88d"),
      ("yellowColor", "#ffcb6b"),
      ("blueColor", "#82aaff"),
      ("redColor", "#f07178"),
      ("purpleColor", "#c792ea"),
      ("orangeColor", "#f78c6c"),
      ("cyanColor", "#89ddff"),
      ("grayColor", "#717CB4"),
      ("whiteBlackColor", "#eeffff"),
      ("errorColor", "#ff5370"),
      ("commentsColor", "#717CB4"),
      ("variablesColor", "#eeffff"),
      ("linksColor", "#80cbc4"),
      ("functionsColor", "#82aaff"),
      ("keywordsColor", "#c792ea"),
      ("tagsColor", "#f07178"),
      ("stringsColor", "#c3e88d"),
      ("operatorsColor", "#89ddff"),
      ("attributesColor", "#ffcb6b"),
      ("numbersColor", "#f78c6c"),
      ("parametersColor", "#f78c6c")
    ]

myTheme :: M.Map String [Char]
myTheme = deepOcean

myNormalBorderColor :: [Char]
--myNormalBorderColor = "#dddddd" --  Light grey
myNormalBorderColor = fromMaybe "#dddddd" (M.lookup "borderColor" myTheme)

myFocusedBorderColor :: [Char]
--myFocusedBorderColor = "#ff0000" -- Solid red
myFocusedBorderColor = fromMaybe "#ff0000" (M.lookup "selectionForeground" myTheme)

myXPConfig            =
  def
    { searchPredicate = fuzzyMatch                                                    ,
      font            = myFont                                                      ,
      sorter          = fuzzySort                                                     ,
      bgColor         = fromMaybe "#0F111A" (M.lookup "background" myTheme)           ,
      fgColor         = fromMaybe "#8F93A2" (M.lookup "foreground" myTheme)           ,
      bgHLight        = fromMaybe "#717CB480" (M.lookup "selectionBackground" myTheme),
      fgHLight        = fromMaybe "#FFFFFF" (M.lookup "selectionForeground" myTheme)  ,
      borderColor     = fromMaybe "#0F111A" (M.lookup "border" myTheme)               ,
      position        = Top                                                           ,
      alwaysHighlight = True,
      promptKeymap    = vimLikeXPKeymap
    }

myTreeConf =
  TSConfig
    { ts_hidechildren = True,
      ts_background = 0x0F111A00,-- 0x70707070, --0xc0c0c0c0
      ts_font = myFont,
      ts_node = (0xff000000, 0xff50d0db),
      ts_nodealt = (0xff000000, 0xff10b8d6),
      ts_highlight = (0xffffffff, 0xffff0000),
      ts_extra = 0xff000000,
      ts_node_width = 200,
      ts_node_height = 30,
      ts_originX = 0,
      ts_originY = 0,
      ts_indent = 60,
      ts_navigate = XMonad.Actions.TreeSelect.defaultNavigation
    }

myTreeWorkspaces   =
  treeselectAction
    myTreeConf
    [
        makeNode "Browser"  "Workspace 1 \62056" (spawn "xdotool set_desktop 0")
    ,   makeNode "Terminal" "Workspace 2 \61728" (spawn "xdotool set_desktop 1")
    ,   makeNode "Code"     "Workspace 3 \61729" (spawn "xdotool set_desktop 2")
    ,   makeNode "Zoom"     "Workspace 4 \61501" (spawn "xdotool set_desktop 3")
    ,   makeNode "Media"    "Workspace 5 \61884" (spawn "xdotool set_desktop 4")
    ,   makeNode "Mail"     "Workspace 6 \61664" (spawn "xdotool set_desktop 5")
    ,   makeNode "Games"    "Workspace 7 \61723" (spawn "xdotool set_desktop 6")
    ,   makeNode "Browser"  "Workspace 8 \61734" (spawn "xdotool set_desktop 7")
    ,   makeNode "Notes"    "Workspace 9 \61462" (spawn "xdotool set_desktop 8")
    ]
    where
        makeNode   text description execute = Node(TSNode text description execute) []
        makeNodeC  text description execute children = Node(TSNode text description execute) children

myTree =
  treeselectAction
    myTreeConf
    [
      makeNodeC "Brightness" "Sets screen brightness using light" [
          makeNode "Bright" "FULL POWER!!"            (spawn "light -S 100")
        , makeNode "Normal" "Normal Brightness (50%)" (spawn "light -S 50")
        , makeNode "Dim"    "Quite dark"              (spawn "light -S 10")
        ]
    , makeNodeC "Power"    "Power Controls" [
          makeNode "Logout"   "Kill Xmonad"          (spawn "killall -9 xmonad-x86_64-linux'")
        , makeNode "Sleep"    "Enter Sleep Mode"     (spawn "playerctl -a pause;systemctl sleep'")
        , makeNode "Reboot"   "Restart Machine"      (spawn "reboot'")
        , makeNode "Lock"     "Lock Current Session" (spawn "betterlockscreen -l")
        , makeNode "Shutdown" "Poweroff the Machine" (spawn "shutdown 0'")
        ]
    ]
    where
        makeNode   text description execute = Node(TSNode text description execute) []
        makeNodeC  text description children = Node(TSNode text description (return ())) children

{-
myWorkspaces = ["¹\62056", "²\61728", "³\61729", "⁴\61501", "⁵\61884", "⁶\61664", "⁷\61723", "⁸\61734", "⁹\61462"]
myWorkspaces = ["\62056", "\61728", "\61729", "\61501", "\61884", "\61664", "\61723", "\61734", "\61462"]
-}

myWorkspaces =
  [ makeFullAction "xdotool set_desktop 0" "1 2" " 1 3" "1 4" "1 5" " \62056 ",
    makeFullAction "xdotool set_desktop 1" "2 2" " 2 3" "2 4" "2 5" " \61728 ",
    makeFullAction "xdotool set_desktop 2" "3 2" " 3 3" "3 4" "3 5" " \61729 ",
    makeFullAction "xdotool set_desktop 3" "4 2" " 4 3" "4 4" "4 5" " \61501 ",
    makeFullAction "xdotool set_desktop 4" "5 2" " 5 3" "5 4" "5 5" " \61884 ",
    makeFullAction "xdotool set_desktop 5" "6 2" " 6 3" "6 4" "6 5" " \61664 ",
    makeFullAction "xdotool set_desktop 6" "7 2" " 7 3" "7 4" "7 5" " \61723 ",
    makeFullAction "xdotool set_desktop 7" "8 2" " 8 3" "8 4" "8 5" " \61734 ",
    makeFullAction "xdotool set_desktop 8" "9 2" " 9 3" "9 4" "9 5" " \61462 "
  ]
  where
    wsScript = "~/dotfiles/scripts/xmobar/workspaces.sh "
    makeFullAction a1 a2 a3 a4 a5 t = "<action=`" ++ a1 ++ "` button=1>" ++ "<action=`" ++ wsScript ++ a2 ++ "` button=2>" ++ "<action=`" ++ wsScript ++ a3 ++ "` button=3>" ++ "<action=`" ++ wsScript ++ a4 ++ "` button=4>" ++ "<action=`" ++ wsScript ++ a5 ++ "` button=5>" ++ t ++ "</action></action></action></action></action>"

myXmobarPP :: PP
myXmobarPP              =
  def
    {
      ppSep               = magenta " • "
      , ppTitleSanitize   = xmobarStrip

      --, ppHiddenNoWindows = lowWhite . wrap " " "" --  unused workspaces

      , ppCurrent         =  xmobarBorder "Top" "#8be9fd" 2 -- Current Workspace

      , ppHidden          =  white -- Visible but not current

      , ppUrgent          = red . wrap (yellow "!") (yellow "!")
      , ppOrder           = \[ws, l, _, wins] -> [ws, l, wins]
      , ppExtras          = [logTitles formatFocused formatUnfocused] -- for updates
    }
  where
    formatFocused       = wrap (white "[") (white "]") . magenta . ppWindow
    formatUnfocused     = wrap (lowWhite "[") (lowWhite "]") . blue . ppWindow
    -- Windows should have *some* title, which should not not exceed a
    -- sane length.
    ppWindow :: String -> String
    ppWindow            = xmobarRaw . (\w -> if null w then "untitled" else w) . shorten 30
    blue, lowWhite, magenta, red, white, yellow :: String -> String
    magenta             = xmobarColor "#ff79c6" ""
    blue                = xmobarColor "#bd93f9" ""
    white               = xmobarColor "#f8f8f2" ""
    yellow              = xmobarColor "#f1fa8c" ""
    red                 = xmobarColor "#ff5555" ""
    lowWhite            = xmobarColor "#bbbbbb" ""

navWrapAround=False

gridSelectSpawn = spawnSelected def ["neovide", "emacsclient -c -a emacs", "chrome", "st"]
notesPromptFunc = do
        spawn ("date>>"++"/home/shawn/dev/personal/NOTES")
        appendFilePrompt myXPConfig "/home/shawn/dev/personal/NOTES"

toggleFullScreen = do
        sendMessage (JumpToLayout ("Full"))
        -- sendMessage (JumpToLayout ("Tall"))
        sendMessage (ToggleStruts)

myEasyMotionConfig:: EasyMotionConfig
myEasyMotionConfig =  def {
      txtCol      = fromMaybe "#ffffff" (M.lookup "foreground" myTheme)
    , bgCol       = fromMaybe "#000000" (M.lookup "background" myTheme)
    -- , overlayF    = proportional (0.3::Double)
    , borderCol   = fromMaybe "#000000" (M.lookup "borderColor" myTheme)
    -- , sKeys       = AnyKeys [xK_s, xK_d, xK_f, xK_j, xK_k, xK_l]
    -- , cancelKey   = xK_q
    -- , borderPx    = 1
    -- , maxChordLen = 0
    , emFont      = myFont
 }

myKeybinds = [

    -- Waiting on
    --("M-r c"   , confirmPromptPrompt def                  ),
    --("M-S-r d" , directoryPrompt def                  ),
    --("M-r e"   , emailPrompt def                          ),
    --("M-r f"   , fuzzyMatchPrompt def                     ),
    --("M-r i"   , inputPrompt def                          ),
    --("M-r p"   , passPrompt def                           ),
    --("M-S-r s" , sshPrompt def                        ),
    --("M-p w"   , windowPrompt myXPConfig  Goto allWindows ),
    --("M-S-r w" , workspacePrompt def                  ),    -- Looks cursed on my config
    --("M-r z"   , zshPrompt def                            ),

    -- NO use
    --("M-r a",launchApp myXPConfig "st -e ")
    --("M-r s",shellPrompt myXPConfig) 

    -- SHOWKEYS START

        ("M-/",     spawn "/home/shawn/dotfiles/scripts/xmoand/help.sh") -- Help

    ,   ("M-r /",   spawn "/home/shawn/dotfiles/scripts/xmoand/help.sh r") -- Help Prompt
    ,   ("M-r n",   notesPromptFunc) -- Plain Notes Prompt
    ,   ("M-r o",   orgPrompt myXPConfig "TODO" "/home/shawn/dev/personal/org/todos.org") -- Org Prompt
    ,   ("M-r d",   dirExecPrompt myXPConfig spawn "/home/shawn/dotfiles/scripts") -- Execute Scripts Directory
    ,   ("M-r l",   layoutPrompt myXPConfig) -- Layout Prompt
    ,   ("M-r m",   manPrompt myXPConfig) -- Man Prompt
    ,   ("M-r r",   runOrRaisePrompt myXPConfig) --  Run or raise window
    ,   ("M-r p",   prompt ("st" ++ " -e") myXPConfig) -- Prompt Terminal Program
    ,   ("M-r t",   themePrompt myXPConfig)                                           -- Theme Prompt
    ,   ("M-r u",   unicodePrompt "/home/shawn/dotfiles/extras/unicode" myXPConfig) -- Unicode Prompt
    ,   ("M-r w g", windowPrompt myXPConfig Goto wsWindows)                     -- Prompt: Goto window
    ,   ("M-r w b", windowPrompt myXPConfig Bring allWindows)                   -- Prompt: Bring window to Current Workspace
    ,   ("M-r x",   xmonadPrompt myXPConfig)                                          -- Xmonad Prompt

    ,   ("M-x",  myTree) -- Open Tree
    ,   ("M-S-x",myTreeWorkspaces) -- Open Tree workspaces

    ,   ("M-n /", spawn "/home/shawn/dotfiles/scripts/xmoand/help.sh n") -- Help Notifications
    ,   ("M-n c",spawn "kill -s USR1 $(pidof deadd-notification-center)")                                                                    -- Notifications Center
    ,   ("M-n h o",    spawn  "notify-send.py a  --hint boolean:deadd-notification-center:true int:id:0 boolean:state:true type:string:buttons") --  Highlight On
    ,   ("M-n h f",    spawn  "notify-send.py a  --hint boolean:deadd-notification-center:true int:id:0 boolean:state:false type:string:buttons") --  Highlight Off
    ,   ("M-n d c",    spawn  "notify-send.py a  --hint boolean:deadd-notification-center:true string:type:clearInCenter") --  Clear Center
    ,   ("M-n d p",    spawn  "notify-send.py a  --hint boolean:deadd-notification-center:true string:type:clearPopups") --  Clear Popups
    ,   ("M-n p",spawn  "notify-send.py a --hint boolean:deadd-notification-center:true string:type:pausePopups") --  Pause Notifications
    ,   ("M-n u",spawn  "notify-send.py a --hint boolean:deadd-notification-center:true string:type:unpausePopups") --  Unpause Notifications
    ,   ("M-n r",spawn  "notify-send.py a --hint boolean:deadd-notification-center:true string:type:reloadStyle") --  Reload Style
    ,   ("M-n t g",    spawn  "notify-send.py 'Icons are' 'COOL' --hint string:image-path:face-cool") --  Gtk icon
    ,   ("M-n t i",    spawn  "notify-send.py 'Images' 'COOL' --hint string:image-path:file://$HOME/Pictures/Wallpapers/minecraft_swamp.jpeg") --  Image file
    ,   ("M-n t n",    spawn  "notify-send.py 'Does pop up' -t 1") --  Notification Center Only
    ,   ("M-n t a",    spawn  "notify-send.py '1' '2' --hint boolean:action-icons:true  --action yes:face-cool no:face-sick") --  Action buttons gtk icons
    ,   ("M-n t p 1",  spawn  "notify-send.py 'This notification has a progressbar' '33%' --hint int:has-percentage:33") --  with progress bar
    ,   ("M-n t p 2",  spawn  "notify-send.py 'This notification has a progressbar' '33%' --hint int:value:33") --  with progress bar
    ,   ("M-n t s",    spawn  "notify-send.py 'This notification has a slider' '33%' --hint int:has-percentage:33 --action changeValue:abc") --  with slider

    ,   ("M-n /", spawn "/home/shawn/dotfiles/scripts/xmoand/help.sh w") -- Help Background
    ,   ("M-w r",    spawn  "randbg")                                                                                                        -- Random Background
    ,   ("M-w p",    spawn  "prevbg")                                                                                                        -- Previous Background
    ,   ("M-w n",    spawn  "nextbg")                                                                                                        -- Next Background

    ,   ("M-g",  goToSelected def) -- Grid Select go to window
    ,   ("M-S-g",gridSelectSpawn) -- Grid Select swap program

    ,   ("M-n /", spawn "/home/shawn/dotfiles/scripts/xmoand/help.sh c") -- Help Layouts
    ,   ("M-c l 1",    sendMessage $ JumpToLayout "Tall") -- Switch to "Tall" layout
    ,   ("M-c l 2",    sendMessage $ JumpToLayout "Mirror Tall")  -- Switch to "Mirror Tall" layout
    ,   ("M-c l 3",    sendMessage $ JumpToLayout "Full") -- Switch to "Full" layout
    ,   ("M-c l 4",    sendMessage $ JumpToLayout "Magnifier NoMaster ThreeCol") -- Switch to "Magnifier NoMaster ThreeCol" layout

    ,   ("M-v",  spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}'") -- Select from Green Clip and set as current clipboard value
    ,   ("M-S-v",spawn "rofi -modi 'clipboard:greenclip print' -show clipboard -run-command '{cmd}' ; sleep 0.5; xdotool type $(xclip -o -selection clipboard)") -- Select from Green Clip and paste
    ,   ("M-C-S-v",    spawn "pkill greenclip && greenclip clear && greenclip daemon & notify-send 'System' 'Greenclip Cleared' ;") -- Clear Green Clip

    ,   ("M1-<F4>",    kill)                                                                                                                 -- Alt F4, kill windwow
    ,   ("M-S-l",spawn "betterlockscreen -lock")                                                                                             -- Lock WM
    ,   ("M1-<F2>",    spawn "dmenu_run  -f -i -l 10 -p 'sh -c'")                                                                            -- Dmenu launch program

    ,   ("M-<Print>",  spawn "flameshot full -p $HOME/Pictures/Screenshots")                                                                 -- Full Screenshot
    ,   ("M-S-<Print>",spawn "flameshot gui  -p $HOME/Pictures/Screenshots")                                                                 -- Snip Screenshot

    ,   ("M-z", spawn "eww open                                                                                                              --toggle sidebar") -- Spawn Eww Sidebar
    ,   ("M-S-z", spawn "eww open                                                                                                            --toggle dubs") -- Spawn Eww dubs

    ,   ("M-s /", spawn "/home/shawn/dotfiles/scripts/xmoand/help.sh s") -- Help Spawn
    ,   ("M-s c", spawn "~/dotfiles/PERSONAL_PATH/click4ever")                                                                               -- Spawn Click4ever (~/dotfiles/PERSONAL_PATH/click4ever")
    ,   ("M-s p", spawn "pavucontrol 1>> ~/log/pavucontrol.log 2>> ~/log/pavucontrol.err.log")                                               -- Spawn pavucontrol
    ,   ("M-s r", spawn "vokoscreenNG 1>> ~/log/vokoscreenNG.log 2>> ~/log/vokoscreenNG.err.log")                                            -- Spawn vokoscreenNG
    ,   ("M-s b", spawnOn (head myWorkspaces) "chrome 1>> ~/log/chrome.log 2>> ~/log/chrome.err.log")                                        -- Spawn chrome
    ,   ("M-s h", spawnOn (myWorkspaces !! 3) "hakuneko-desktop 1>> ~/log/hakuneko-desktop.log 2>> ~/log/hakuneko-desktop.err.log")          -- Spawn hakuneko-desktop
    ,   ("M-s s", spawnOn (myWorkspaces !! 4) "dex /usr/share/applications/spotify.desktop 1>> ~/log/spotify.log 2>> ~/log/spotify.err.log") -- Spawn spotify

    , ("<XF86XK_MonBrightnessDown>",   spawn "$HOME/dotfiles/scripts/dwm/light.sh down")                                                   -- light down
    , ("<XF86XK_MonBrightnessUp>",     spawn "$HOME/dotfiles/scripts/dwm/light.sh up")                                                     -- light up
    , ("<XF86XK_AudioLowerVolume>",    spawn "$HOME/dotfiles/scripts/dwm/vol.sh down")                                                     -- vol down
    , ("<XF86XK_AudioRaiseVolume>",    spawn "$HOME/dotfiles/scripts/dwm/vol.sh up")                                                       -- vol up
    , ("<XF86XK_AudioMute>",     spawn "$HOME/dotfiles/scripts/dwm/vol.sh mute")                                                           -- vol mute
    , ("<XF86XK_AudioPlay>",     spawn "$HOME/dotfiles/scripts/dwm/media.sh play-pause")                                                   -- media play-pause
    , ("<XF86XK_AudioNext>",     spawn "$HOME/dotfiles/scripts/dwm/media.sh next")                                                         -- media next
    , ("<XF86XK_AudioPrev>",     spawn "$HOME/dotfiles/scripts/dwm/media.sh previous")                                                     -- media previous

    , ("M-<F2>",     spawn "$HOME/dotfiles/scripts/dwm/light.sh down")                                                                     -- light down
    , ("M-<F3>",     spawn "$HOME/dotfiles/scripts/dwm/light.sh up")                                                                       -- light up
    , ("M-<F7>",     spawn "$HOME/dotfiles/scripts/dwm/vol.sh down")                                                                       -- vol down
    , ("M-<F8>",     spawn "$HOME/dotfiles/scripts/dwm/vol.sh up")                                                                         -- vol up
    , ("M-<F6>",     spawn "$HOME/dotfiles/scripts/dwm/vol.sh mute")                                                                       -- vol mute
    , ("M-<F10>",    spawn "$HOME/dotfiles/scripts/dwm/media.sh play-pause")                                                               -- media play-pause
    , ("M-<F11>",    spawn "$HOME/dotfiles/scripts/dwm/media.sh next")                                                                     -- media next
    , ("M-<F9>",     spawn "$HOME/dotfiles/scripts/dwm/media.sh previous")                                                                 -- media previous

    , ("M-a",  windows copyToAll)                                                                                                          -- Make window sticky
    , ("M-S-a",killAllOtherCopies)                                                                                                         -- Unstick window

    , ("M-t /", spawn "/home/shawn/dotfiles/scripts/xmoand/help.sh t") -- Help Toggles
    , ("M-t f", toggleFullScreen)                                                                                                          -- Toggle Fullscreen
    , ("M-t M-f", toggleFullScreen)                                                                                                        -- Toggle Fullscreen
    , ("M-t t", withFocused $ windows . W.sink)                                                                                            -- Force focused window back into tiling
    , ("M-t M-t", withFocused $ windows . W.sink)                                                                                          -- Force focused window back into tiling

    , ("M-h", sendMessage $ Go L)                                                                                                            -- focus left
    , ("M-j", sendMessage $ Go D)                                                                                                            -- focus down
    , ("M-k", sendMessage $ Go U)                                                                                                            -- focus up
    , ("M-l", sendMessage $ Go R)                                                                                                            -- focus right
    , ("M-S-h", sendMessage $ Swap L)                                                                                                        -- swap left
    , ("M-S-j", sendMessage $ Swap D)                                                                                                        -- swap down
    , ("M-S-k", sendMessage $ Swap U)                                                                                                        -- swap up
    , ("M-S-l", sendMessage $ Swap R)                                                                                                        -- swap right
    , ("M-C-h", sendMessage $ Move L)                                                                                                        -- move left
    , ("M-C-j", sendMessage $ Move D)                                                                                                        -- move down
    , ("M-C-k", sendMessage $ Move U)                                                                                                        -- move up
    , ("M-C-l", sendMessage $ Move R)                                                                                                        -- move right

                                                                                                                                             -- float
    , ("M-<L>", withFocused (keysMoveWindow (-20,0)))                                                                                        -- move float left
    , ("M-<R>", withFocused (keysMoveWindow (20,0)))                                                                                         -- move float right
    , ("M-<U>", withFocused (keysMoveWindow (0,-20)))                                                                                        -- move float up
    , ("M-<D>", withFocused (keysMoveWindow (0,20)))                                                                                         -- move float down
    , ("M-S-<L>", withFocused (keysResizeWindow (-20,0) (0,0)))                                                                              --shrink float at right
    , ("M-S-<R>", withFocused (keysResizeWindow (20,0) (0,0)))                                                                               --expand float at right
    , ("M-S-<D>", withFocused (keysResizeWindow (0,20) (0,0)))                                                                               --expand float at bottom
    , ("M-S-<U>", withFocused (keysResizeWindow (0,-20) (0,0)))                                                                              --shrink float at bottom
    , ("M-C-<L>", withFocused (keysResizeWindow (20,0) (1,0)))                                                                               --expand float at left
    , ("M-C-<R>", withFocused (keysResizeWindow (-20,0) (1,0)))                                                                              --shrink float at left
    , ("M-C-<U>", withFocused (keysResizeWindow (0,20) (0,1)))                                                                               --expand float at top
    , ("M-C-<D>", withFocused (keysResizeWindow (0,-20) (0,1)))                                                                              --shrink float at top

    , ("M-e f", (selectWindow myEasyMotionConfig) >>= (`whenJust` windows . W.focusWindow))                                                -- EasyMotion focus window
    , ("M-e k", (selectWindow myEasyMotionConfig) >>= (`whenJust` killWindow))                                                             -- EasyMotion kill window

    -- SHOWKEYS END

    -- ,   ("M-j", windowGo D navWrapAround) -- Focus Window Down
    -- ,   ("M-h", windowGo L navWrapAround) -- Focus Window Left
    -- ,   ("M-l", windowGo R navWrapAround) -- Focus Window Right

    -- ,   ("M-S-k",sendMessage MirrorExpand) -- Resize Window Up
    -- ,   ("M-S-j",sendMessage MirrorShrink) -- Resize Window Down
    -- ,   ("M-S-h",sendMessage Shrink) -- Resize Window Left
    -- ,   ("M-S-l",sendMessage Expand) -- Resize Window Right

    -- ,   ("M-C-k", windowSwap U navWrapAround) -- Move Window Up
    -- ,   ("M-C-j", windowSwap D navWrapAround) -- Move Window Down
    -- ,   ("M-C-h", windowSwap L navWrapAround) -- Move window Left
    -- ,   ("M-C-l", windowSwap R navWrapAround) -- Move window Right

    --    , ("M-f h", withFocused $ snapMove L Nothing)
    --    , ("M-f l", withFocused $ snapMove R Nothing)
    --    , ("M-f k", withFocused $ snapMove U Nothing)
    --    , ("M-f j", withFocused $ snapMove D Nothing)

    --    , ("M-f S-h", withFocused $ snapShrink R Nothing)
    --    , ("M-f S-l", withFocused $ snapGrow R Nothing)
    --    , ("M-f S-k", withFocused $ snapShrink D Nothing)
    --    , ("M-f S-j", withFocused $ snapGrow D Nothing)

    -- , ("M-f S-h", withFocused (keysResizeWindow (-10, 0) (1, 0) )) -- Resize Floating Windowa 10px to the left
    -- , ("M-f S-k", withFocused (keysResizeWindow (0, -10) (0, 1) )) -- Resize Floating Windowa 10px to the up
    -- , ("M-f S-j", withFocused (keysResizeWindow (0, 10) (0, 1) )) -- Resize Floating Windowa 10px to the down

    -- , ("M-f l", withFocused (keysMoveWindow (10,0))) -- Move Window 10 px to right
    -- , ("M-f h", withFocused (keysMoveWindow (-10,0))) -- Move Window 10 px to left
    -- , ("M-f k", withFocused (keysMoveWindow (0,-10))) -- Move Window 10 px to up
    -- , ("M-f j", withFocused (keysMoveWindow (0,10))) -- Move Window 10 px to down


 ]

myManageHook :: ManageHook
myManageHook      =
  composeAll . concat $ [
      [resource  =? r --> doIgnore                    | r <- ignoreResource],
      [role      =? r --> doIgnore                    | r <- ignoreRole],

      [role      =? r --> doCenterFloat               | r <- centerFloatRole],

      [className =? c --> doFloat                     | c <- floatClassName],
      [className =? c --> doCenterFloat               | c <- centerFloatClassName],

      [className =? c --> doShift (head myWorkspaces) | c <- shiftWorkspaceClassName1],
      [className =? c --> doShift (myWorkspaces !! 1) | c <- shiftWorkspaceClassName2],
      [className =? c --> doShift (myWorkspaces !! 2) | c <- shiftWorkspaceClassName3],
      [className =? c --> doShift (myWorkspaces !! 3) | c <- shiftWorkspaceClassName4],
      [className =? c --> doShift (myWorkspaces !! 4) | c <- shiftWorkspaceClassName5],
      [className =? c --> doShift (myWorkspaces !! 5) | c <- shiftWorkspaceClassName6],
      [className =? c --> doShift (myWorkspaces !! 6) | c <- shiftWorkspaceClassName7],
      [className =? c --> doShift (myWorkspaces !! 7) | c <- shiftWorkspaceClassName8],
      [className =? c --> doShift (myWorkspaces !! 8) | c <- shiftWorkspaceClassName9],
      [isFullscreen --> doFullFloat],
      [isDialog --> doCenterFloat],


      [title     =? "Ozone X11" --> doIgnore],
      [title     =? "Picture-in-picture" --> doFloat],

      [title   =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [name    =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [netName =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [className =? "spotify" --> doShift (myWorkspaces !! 4)],

      [isInProperty "WM_NAME" "Spotify" --> doShift (myWorkspaces !! 4)],
      [isInProperty "_NET_WM_NAME" "Spotify" --> doShift (myWorkspaces !! 4)],
      [isInProperty "WM_CLASS" "Spotify" --> doShift (myWorkspaces !! 4)],

      [isInProperty "WM_NAME" "spotify" --> doShift (myWorkspaces !! 4)],
      [isInProperty "_NET_WM_NAME" "spotify" --> doShift (myWorkspaces !! 4)],
      [isInProperty "WM_CLASS" "spotify" --> doShift (myWorkspaces !! 4)]

    ]
  where
    name                     = stringProperty "WM_NAME"
    netName                  = stringProperty "_NET_WM_NAME"
    role                     = stringProperty "WM_WINDOW_ROLE"
    class_                   = stringProperty "WM_CLASS"
    clientMachine            = stringProperty "WM_CLIENT_MACHINE"
    iconName                 = stringProperty "WM_ICON_NAME"
    netIconName              = stringProperty "_NET_WM_ICON_NAME"
    localeName               = stringProperty "WM_LOCALE_NAME"

    centerFloatClassName     = ["Vimb", "Xmessage", "Gimp", "Open File", "leagueclientux.exe", "riotclientux.exe", "riotclientservices.exe", "League of Legends"]

    floatClassName           = []

    centerFloatRole          = ["GtkFileChooserDialog"]

    ignoreResource           = ["desktop", "desktop_window"]
    ignoreRole               = ["popup"]

    shiftWorkspaceClassName1 = ["Browser", "Firefox", "Google-chrome", "Opera"]
    shiftWorkspaceClassName2 = ["St", "st", "terminal", "st-256color"]
    shiftWorkspaceClassName3 = ["ModernGL", "Emacs", "emacs", "neovide", "Code", "Code - Insiders"]
    shiftWorkspaceClassName4 = ["hakuneko-desktop", "Unity", "unityhub", "UnityHub", "zoom"]
    shiftWorkspaceClassName5 = ["Spotify", "vlc"]
    shiftWorkspaceClassName6 = ["Mail", "Thunderbird"]
    shiftWorkspaceClassName7 = ["riotclientux.exe", "leagueclient.exe", "Zenity", "zenity", "wineboot.exe", "Wine", "wine", "wine.exe", "explorer.exe", "Albion Online Launcher", "Albion Online", "Albion-Online", "riotclientservices.exe", "League of Legends"]
    shiftWorkspaceClassName8 = []
    shiftWorkspaceClassName9 = []

myLayout     = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| noBorders Full ||| threeCol ||| tabbed shrinkText (theme smallClean)))
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1 -- Default number of windows in the master pane
    ratio    = 1 / 2 -- Default proportion of screen occupied by master pane
    delta    = 3 / 100 -- Percent of screen to increment by when resizing panes

myStartupHook = do
  spawnOnce (wrapLog "randbg")

  spawn (wrapLogP "trayer" "~/dotfiles/config/xmobar/trayer")
  spawn (wrapLogP "picom" "picom -b --experimental-backend")
  spawn (wrapLog "deadd-notification-center")

  spawn (wrapLogP "xflux" "xflux -l 0")

  spawn (wrapLogP "eww" "eww daemon")

  spawn (wrapLog "nm-applet")
  spawn (wrapLogP "greeeclip" "greenclip daemon")
  spawn (wrapLog "flameshot")

  spawnOn (myWorkspaces !! 1) (wrapLog "st")

  where
    wrapLog app = "pidof " ++ app ++ " > /dev/null && echo ''" ++ app ++ "' is already running.' || " ++ app ++ " 1>> ~/log/" ++ app ++ ".log 2>> ~/log/" ++ app ++ ".err.log &"
    wrapLogP app run = "pidof " ++ app ++ " > /dev/null && echo ''" ++ app ++ "' is already running.' || " ++ run ++ " 1>> ~/log/" ++ app ++ ".log 2>> ~/log/" ++ app ++ ".err.log &"

main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . setEwmhActivateHook doAskUrgent
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

myConfig                 =
  def
    { modMask            = myModMask,
      layoutHook         = myLayout,
      terminal           = myTerminal,
      manageHook         = manageDocks <+> myManageHook,
      startupHook        = myStartupHook,
      normalBorderColor  = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      handleEventHook    = handleEventHook def <+> Hacks.windowedFullscreenFixEventHook <+> serverModeEventHook <+> serverModeEventHookCmd <+> serverModeEventHookF "XMONAD_PRINT" (io . putStrLn),
      --workspaces         = toWorkspaces myTreeWorkspaces
      workspaces         =  myWorkspaces
    }
    `additionalKeysP` myKeybinds
