{- ORMOLU_DISABLE -}
import XMonad

--
import XMonad.Actions.CopyWindow
import XMonad.Actions.SpawnOn
--
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.ManageHelpers
import XMonad.Hooks.StatusBar
import XMonad.Hooks.StatusBar.PP
--
import XMonad.Layout.Magnifier
import XMonad.Layout.NoBorders
import XMonad.Layout.PerWorkspace
import XMonad.Layout.ResizableTile -- Actions.WindowNavigation is nice too
--
import XMonad.Layout.ThreeColumns

import XMonad.Util.EZConfig -- or use another method of binding resizable keys
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab


import qualified XMonad.StackSet as W
import qualified Data.Map as M
import Data.Char (isSpace, toUpper)
import Data.Maybe ( fromJust, isJust )
import Data.Monoid
import Data.Tree
{- ORMOLU_ENABLE -}

myTerminal = "st" -- Default Terminal

myModMask = mod4Mask -- Rebind Mod to the Super key

myNormalBorderColor = "#dddddd" --  Light grey

myFocusedBorderColor = "#ff0000" -- Solid red

-- ¹  ²  ³  ⁴  ⁵  ⁶  ⁷  ⁸ ⁹
--myWorkspaces = ["¹\62056", "²\61728", "³\61729", "⁴\61501", "⁵\61884", "⁶\61664", "⁷\61723", "⁸\61734", "⁹\61462"]

--                         
myWorkspaces = ["\62056", "\61728", "\61729", "\61501", "\61884", "\61664", "\61723", "\61734", "\61462"]

myWorkspaceIndices = M.fromList $ zip myWorkspaces [1 ..] -- (,) == \x y -> (x,y)

clickable ws = "<action=xdotool key super+" ++ show i ++ ">" ++ ws ++ "</action>"
  where
    i = fromJust $ M.lookup ws myWorkspaceIndices

-- XMOBAR

{- ORMOLU_DISABLE -}
-- TODO: Use backgrounds when theming
myXmobarPP :: PP
myXmobarPP              =
  def
    { ppSep             = magenta " • ",
	  ppTitleSanitize   = xmobarStrip,
      ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2, -- Current Window
      ppHidden          = white . wrap " " "", -- Visible but not current
	  -- ppHiddenNoWindows = lowWhite . wrap " " "", --  unused workspaces
	  ppUrgent          = red . wrap (yellow "!") (yellow "!"),
      ppOrder           = \[ws, l, _, wins] -> [ws, l, wins],
	  ppExtras          = [logTitles formatFocused formatUnfocused] -- for updates
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

-- WINDOW MANAGEMENT

{- ORMOLU_DISABLE -}
-- doShift = send to tag on creation
-- doShiftAndGo = send to tag on creation and go
-- doIgnore = don't tile and  sticky on all workspaces
myManageHook :: ManageHook
myManageHook      =
  composeAll . concat $
    [ [resource  =? r --> doIgnore | r <- ignoreResource],
      [role      =? r --> doIgnore | r <- ignoreRole],
      --[role =? "popup" --> doIgnore],
      [className =? c --> doFloat | c <- shiftWorkspaceClassName1],
      --[className =? "Gimp" --> doFloat],
      --[className =? "Xmessage" --> doFloat],
      --[className =? "Vimb" --> doFloat],
      [className =? c --> doShift (head myWorkspaces) | c <- shiftWorkspaceClassName1],
      [className =? c --> doShift (myWorkspaces !! 1) | c <- shiftWorkspaceClassName2],
      [className =? c --> doShift (myWorkspaces !! 2) | c <- shiftWorkspaceClassName3],
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
      [title     =? "Picture-in-picture" --> doIgnore],

      [title   =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [name    =? "Spotify" --> doShift (myWorkspaces !! 4)],
      [netName =? "Spotify" --> doShift (myWorkspaces !! 4)],
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

    floatClassName           = ["vimb", "Xmessage", "Gimp"]

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

-- STARTUP

myStartupHook = do
  spawnOnce "randbg"
  spawnOn (myWorkspaces !! 1) "pidof st        > /dev/null && echo 'st is already running.'        || st 1>> st.log 2>> st.err.log&"
  spawnOnce "pidof nm-applet > /dev/null && echo 'nm-applet is already running.' || nm-applet 1>> nm-applet.log 2>> nm-applet.err.log&"
  spawnOnce "pidof xflux     > /dev/null && echo 'xflux is already running.'     || xflux -l 0 1>> xflux.log 2>> xflux.err.log&"
  spawnOnce "pidof picom     > /dev/null && echo 'picom is already running.'     || picom -b --experimental-backend 1>> picom.log 2>> picom.err.log&"
  spawnOnce "pidof clipit    > /dev/null && echo 'clipit is already running.'    || clipit 1>> clipit.log 2>> clipit.err.log&"

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

-- KEYBINDS

mySpawn p = spawn ("xsetroot -cursor_name watch;xtoolwait " ++ p ++ ";xsetroot -cursor_name left_ptr")

{- ORMOLU_DISABLE -}
myKeybinds = [
    -- SHOWKEYS START
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
      workspaces         = myWorkspaces
    }
    `additionalKeysP` myKeybinds
{- ORMOLU_ENABLE -}
