{- ORMOLU_DISABLE -}
import Data.Char (isSpace, toUpper)
import Data.Maybe 
import Data.Monoid
import Data.Tree

import XMonad

import XMonad.Actions.CopyWindow
import XMonad.Actions.GridSelect
import XMonad.Actions.SpawnOn
import XMonad.Actions.TreeSelect

import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
import XMonad.Hooks.WorkspaceHistory

import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile
import XMonad.Layout.ThreeColumns

import XMonad.Util.ClickableWorkspaces
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

import qualified Data.Map as M
import qualified XMonad.StackSet as W
{- ORMOLU_ENABLE -}

myTerminal = "st" -- Default Terminal

myModMask = mod4Mask -- Rebind Mod to the Super key

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
myNormalBorderColor = fromMaybe "#dddddd" (M.lookup "background" myTheme)

myFocusedBorderColor :: [Char]
--myFocusedBorderColor = "#ff0000" -- Solid red
myFocusedBorderColor = fromMaybe "#ff0000" (M.lookup "selectionForeground" myTheme)

{-
myWorkspaces = ["1", "2", "3", "4", "5", "6", "7", "8", "9"]
 ¹  ²  ³  ⁴  ⁵  ⁶  ⁷  ⁸ ⁹
myWorkspaces = ["¹\62056", "²\61728", "³\61729", "⁴\61501", "⁵\61884", "⁶\61664", "⁷\61723", "⁸\61734", "⁹\61462"]
                         
myWorkspaces = ["\62056", "\61728", "\61729", "\61501", "\61884", "\61664", "\61723", "\61734", "\61462"]

myWorkspaces =
  [ "<action=`xdotool key super+1` button=1>\62056</action>",
    "<action=`xdotool key super+2` button=1>\61728</action>",
    "<action=`xdotool key super+3` button=1>\61729</action>",
    "<action=`xdotool key super+4` button=1>\61501</action>",
    "<action=`xdotool key super+5` button=1>\61884</action>",
    "<action=`xdotool key super+6` button=1>\61664</action>",
    "<action=`xdotool key super+7` button=1>\61723</action>",
    "<action=`xdotool key super+8` button=1>\61734</action>",
    "<action=`xdotool key super+9` button=1>\61462</action>"
  ]
makeAction a b t = "<action=`" ++ a ++ "` button=" ++ b ++ ">" ++ t ++ "</action>"

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

-- XMOBAR
-- https://hackage.haskell.org/package/xmonad-contrib-0.17.0/docs/XMonad-Hooks-StatusBar-PP.html#g:2
{- ORMOLU_DISABLE -}
-- TODO: Use backgrounds when theming
myXmobarPP :: PP
myXmobarPP              =
  def
    {
      ppSep             = magenta " • "
      , ppTitleSanitize   = xmobarStrip
      --, ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2  -- Current Workspace
      --, ppHiddenNoWindows = lowWhite . wrap " " "" --  unused workspaces

      , ppCurrent         =  xmobarBorder "Top" "#8be9fd" 2  -- Current Workspace
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
{- ORMOLU_ENABLE -}

--myPromptConfig = def
--{
--position = Top
--, promptBorderWidth = 0
--, defaultText = ""
--, alwaysHighlight = True
--, height = 32
--, font = "xft:DejaVu Sans Condensed-16:normal"
--, autoComplete = Just 500000
--, searchPredicate = fuzzyMatch
--}

{- ORMOLU_DISABLE -}
myTreeConf =
  TSConfig
    { ts_hidechildren = True,
      ts_background = 0x70707070, --0xc0c0c0c0
      ts_font = "xft:DroidSansMono Nerd Font:size=14",
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
          makeNode "Logout"   "Kill Xmonad"          (spawn "xmessage 'killall -9 xmonad-x86_64-linux'")
        , makeNode "Sleep"    "Enter Sleep Mode"     (spawn "xmessage 'amixer set Master mute;systemctl sleep'")
        , makeNode "Reboot"   "Restart Machine"      (spawn "xmessage 'reboot'")
        , makeNode "Lock"     "Lock Current Session" (spawn "xmessage 'betterlockscreen -l'")
        , makeNode "Shutdown" "Poweroff the Machine" (spawn "xmessage 'shutdown 0'")
        ]
    ]
    where
        makeNode   text description execute = Node(TSNode text description execute) []
        makeNodeC  text description children = Node(TSNode text description (return ())) children
{- ORMOLU_ENABLE -}

-- KEYBINDS

mySpawn p = spawn ("xsetroot -cursor_name watch;xtoolwait " ++ p ++ ";xsetroot -cursor_name left_ptr")

{- ORMOLU_DISABLE -}
myKeybinds = [
    -- SHOWKEYS START
    --("M-x", treeselectWorkspace myTreeConf myTreeWorkspaces W.greedyViewj,
    ("M-x", myTree),
    ("M-S-x",  myTreeWorkspaces),

    ("M-g", goToSelected def),
    ("M-S-g", spawnSelected def ["neovide","emacsclient -c -a emacs","chrome"]),

    ("M-c l 1", sendMessage $ JumpToLayout "Tall") ,
    ("M-c l 2", sendMessage $ JumpToLayout "Mirror Tall") ,
    ("M-c l 3", sendMessage $ JumpToLayout "Full") ,
    ("M-c l 4", sendMessage $ JumpToLayout "Magnifier NoMaster ThreeCol") ,

    ("M1-<F4>",                 kill),
    ("M-S-z",                   spawn "xscreensaver-command -lock"),
    ("M1-<F2>",                 spawn "dmenu_run  -f -i -l 10 -p 'sh -c'"),
    ("M-S-<Print>",             unGrab *> spawn "scrot -s"),
    --
    --("M-t s",                   sendMessage ToggleStruts),
    --("M-t f", toggleBorder),
    --("M-t b", toggleBorder),
    --("M-t t", toggleBorder),
    --
    ("M-s p",                   spawn "pavucontrol 1>> pavucontrol.log 2>> pavucontrol.err.log"),
    ("M-s r",                   spawn "vokoscreenNG 1>> vokoscreenNG.log 2>> vokoscreenNG.err.log"),
    ("M-s b",                   spawnOn (head myWorkspaces) "chrome 1>> chrome.log 2>> chrome.err.log"),
    ("M-s h",                   spawnOn (myWorkspaces !! 3) "hakuneko-desktop 1>> hakuneko-desktop.log 2>> hakuneko-desktop.err.log"),
    ("M-s s",                   spawnOn (myWorkspaces !! 4) "dex /usr/share/applications/spotify.desktop 1>> spotify.log 2>> spotify.err.log"),
    --

    ("M-<F2>" {-XF86XK_MonBrightnessDown,-}, spawn "$HOME/dotfiles/scripts/dwm/light.sh down" ),
    ("M-<F3>" {-XF86XK_MonBrightnessUp,-},   spawn "$HOME/dotfiles/scripts/dwm/light.sh up" ),
    ("M-<F7>" {-XF86XK_AudioLowerVolume,-},  spawn "$HOME/dotfiles/scripts/dwm/vol.sh down"),
    ("M-<F8>" {-XF86XK_AudioRaiseVolume,-},  spawn "$HOME/dotfiles/scripts/dwm/vol.sh up"),
    ("M-<F6>" {-XF86XK_AudioMute,-},         spawn "$HOME/dotfiles/scripts/dwm/vol.sh mute" ),
    ("M-<F10>" {-XF86XK_AudioPlay,-},        spawn "$HOME/dotfiles/scripts/dwm/media.sh play-pause" ),
    ("M-<F11>" {-XF86XK_AudioNext,-},        spawn "$HOME/dotfiles/scripts/dwm/media.sh next      " ),
    ("M-<F9>" {-XF86XK_AudioPrev,-},         spawn "$HOME/dotfiles/scripts/dwm/media.sh previous  " ),

    -- Make window sticky
    ("M-a", windows copyToAll),

    -- Unstick window
    ("M-S-a",  killAllOtherCopies),

    -- Fullscreen
    ("M-f", sendMessage $ JumpToLayout "Full"),

    -- resize both axes in resizableTall

    ("M-C-k", sendMessage MirrorExpand),
    ("M-C-j", sendMessage MirrorShrink),
    ("M-C-h", sendMessage Shrink),
    ("M-C-l", sendMessage Expand)

    

    -- SHOWKEYS END
 ]
{- ORMOLU_ENABLE -}

-- WINDOW MANAGEMENT
{- ORMOLU_DISABLE -}
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
      [isDialog --> doFloat],

      [title     =? "Ozone X11" --> doIgnore],
      [title     =? "Picture-in-picture" --> doFloat],

      [title   =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [name    =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [netName =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [className =? "spotify" --> doShift (myWorkspaces !! 4)],
      [title   =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [title   =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [title   =? "Spotify" --> doShift (myWorkspaces !! 4)]
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

    centerFloatClassName     = ["Vimb", "Xmessage", "Gimp", "Open File"]
      
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
    shiftWorkspaceClassName7 = ["riotclientux.exe", "leagueclient.exe", "Zenity", "zenity", "wine", "wine.exe", "explorer.exe"]
    shiftWorkspaceClassName8 = []
    shiftWorkspaceClassName9 = []

{- ORMOLU_ENABLE -}

-- LAYOUTS
{- ORMOLU_DISABLE -}
myLayout     = avoidStruts (smartBorders (tiled ||| Mirror tiled ||| noBorders Full ||| threeCol))
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1 -- Default number of windows in the master pane
    ratio    = 1 / 2 -- Default proportion of screen occupied by master pane
    delta    = 3 / 100 -- Percent of screen to increment by when resizing panes
{- ORMOLU_ENABLE -}

-- STARTUP

myStartupHook = do
  spawnOnce "randbg"

  spawnOn (myWorkspaces !! 1) (wrapLog "st")

  spawnOnce (wrapLog "nm-applet")
  spawnOnce (wrapLog "clipit")
  spawnOnce (wrapLog "deadd-notification-center")

  spawnOnce (wrapLogP "trayer" "~/dotfiles/config/xmobar/trayer")
  spawnOnce (wrapLogP "xflux" "xflux -l 0")
  spawnOnce (wrapLogP "picom" "picom -b --experimental-backend")
  where
    wrapLog app = "pidof " ++ app ++ " > /dev/null && echo ''" ++ app ++ "' is already running.' || " ++ app ++ " 1>> ~/log/" ++ app ++ ".log 2>> ~/log/" ++ app ++ ".err.log&"
    wrapLogP app run = "pidof " ++ app ++ " > /dev/null && echo ''" ++ app ++ "' is already running.' || " ++ run ++ " 1>> ~/log/" ++ app ++ ".log 2>> ~/log/" ++ app ++ ".err.log&"

-- MAIN
main :: IO ()
main =
  xmonad
    . ewmhFullscreen
    . ewmh
    . withEasySB (statusBarProp "xmobar" (pure myXmobarPP)) defToggleStrutsKey
    $ myConfig

{- ORMOLU_DISABLE -}
myConfig                 =
  def
    { modMask            = myModMask,
      layoutHook         = myLayout,
      terminal           = myTerminal,
      manageHook         = manageDocks <+> myManageHook,
      startupHook        = myStartupHook,
      normalBorderColor  = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      --workspaces         = toWorkspaces myTreeWorkspaces
      workspaces         =  myWorkspaces
    }
    `additionalKeysP` myKeybinds
{- ORMOLU_ENABLE -}
