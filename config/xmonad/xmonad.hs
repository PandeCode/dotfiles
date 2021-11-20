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
import XMonad.Layout.ThreeColumns
--
import XMonad.Util.EZConfig
import XMonad.Util.Loggers
import XMonad.Util.SpawnOnce
import XMonad.Util.Ungrab

myTerminal = "st" -- Default Terminal

myModMask = mod4Mask -- Rebind Mod to the Super key

myNormalBorderColor = "#dddddd" --  Light grey

myFocusedBorderColor = "#ff0000" -- Solid red

-- ¹  ²  ³  ⁴  ⁵  ⁶  ⁷  ⁸ ⁹
--myWorkspaces = ["¹\62056", "²\61728", "³\61729", "⁴\61501", "⁵\61884", "⁶\61664", "⁷\61723", "⁸\61734", "⁹\61462"]

--                         
myWorkspaces = ["\62056", "\61728", "\61729", "\61501", "\61884", "\61664", "\61723", "\61734", "\61462"]

-- WINDOW MANAGEMENT

{- ORMOLU_DISABLE -}
-- doShift = send to tag on creation
-- doIgnore = don't tile and  sticky on all workspaces
myManageHook :: ManageHook
myManageHook =
  composeAll
    [ isDialog                        --> doFloat,
      className =? "Gimp"             --> doFloat,
      className =? "Xmessage"         --> doFloat,
      className =? "vimb"             --> doFloat,
      role =? "popup"                 --> doIgnore,
      title =? "Ozone X11"            --> doIgnore,
      title =? "Spotify"              --> doShift (myWorkspaces !! 4),
      title =? "Picture-in-picture"   --> doIgnore, --TODO: on all tags
      -- WORKSPACE 1
      className =? "Browser"          --> doShift (myWorkspaces !! 0),
      className =? "Firefox"          --> doShift (myWorkspaces !! 0),
      className =? "Google-chrome"    --> doShift (myWorkspaces !! 0),
      className =? "Opera"            --> doShift (myWorkspaces !! 0),
      -- WORKSPACE 2
      className =? "St"               --> doShift (myWorkspaces !! 1),
      className =? "st"               --> doShift (myWorkspaces !! 1),
      className =? "terminal"         --> doShift (myWorkspaces !! 1),
      className =? "st-256color"      --> doShift (myWorkspaces !! 1),
      -- WORKSPACE 3
      className =? "ModernGL"         --> doShift (myWorkspaces !! 2),
      className =? "Emacs"            --> doShift (myWorkspaces !! 2),
      className =? "emacs"            --> doShift (myWorkspaces !! 2),
      className =? "neovide"          --> doShift (myWorkspaces !! 2),
      className =? "Code"             --> doShift (myWorkspaces !! 2),
      className =? "Code - Insiders"  --> doShift (myWorkspaces !! 2),
      -- WORKSPACE 4
      className =? "hakuneko-desktop" --> doShift (myWorkspaces !! 3),
      className =? "Unity"            --> doShift (myWorkspaces !! 3),
      className =? "unityhub"         --> doShift (myWorkspaces !! 3),
      className =? "UnityHub"         --> doShift (myWorkspaces !! 3),
      className =? "zoom"             --> doShift (myWorkspaces !! 3),
      -- WORKSPACE 5
      className =? "Spotify"          --> doShift (myWorkspaces !! 4),
      className =? "vlc"              --> doShift (myWorkspaces !! 4),
      -- WORKSPACE 6
      className =? "Mail"             --> doShift (myWorkspaces !! 5),
      className =? "Thunderbird"      --> doShift (myWorkspaces !! 5),
      -- WORKSPACE 7
      className =? "riotclientux.exe" --> doShift (myWorkspaces !! 6),
      className =? "leagueclient.exe" --> doShift (myWorkspaces !! 6),
      className =? "Zenity"           --> doShift (myWorkspaces !! 6),
      className =? "zenity"           --> doShift (myWorkspaces !! 6),
      className =? "wine"             --> doShift (myWorkspaces !! 6),
      className =? "wine.exe"         --> doShift (myWorkspaces !! 6),
      className =? "explorer.exe"     --> doShift (myWorkspaces !! 6)
    ]
  where
    role = stringProperty "WM_WINDOW_ROLE"
    shiftWorkspaceClassName1 = []
    shiftWorkspaceClassName2 = []
    shiftWorkspaceClassName3 = []
    shiftWorkspaceClassName4 = []
    shiftWorkspaceClassName5 = []
    shiftWorkspaceClassName6 = ["Mail", "Thunderbird"]
    shiftWorkspaceClassName7 = ["riotclientux.exe", "leagueclient.exe", "Zenity", "zenity", "wine", "wine.exe", "explorer.exe"]

{- ORMOLU_ENABLE -}

-- STARTUP

myStartupHook = do
  spawnOnce "randbg"
  spawnOn (myWorkspaces !! 1) "pidof st        > /dev/null && echo 'st is already running.'        || st &"
  spawnOnce "pidof nm-applet > /dev/null && echo 'nm-applet is already running.' || nm-applet &"
  spawnOnce "pidof xflux     > /dev/null && echo 'xflux is already running.'     || xflux -l 0 &"
  spawnOnce "pidof picom     > /dev/null && echo 'picom is already running.'     || picom -b --experimental-backend &"
  spawnOnce "pidof clipit    > /dev/null && echo 'clipit is already running.'    || clipit &"

-- LAYOUTS

{- ORMOLU_DISABLE -}
myLayout     = smartBorders tiled ||| Mirror tiled ||| noBorders Full ||| smartBorders threeCol
  where
    threeCol = magnifiercz' 1.3 $ ThreeColMid nmaster delta ratio
    tiled    = Tall nmaster delta ratio
    nmaster  = 1 -- Default number of windows in the master pane
    ratio    = 1 / 2 -- Default proportion of screen occupied by master pane
    delta    = 3 / 100 -- Percent of screen to increment by when resizing panes
{- ORMOLU_ENABLE -}

-- XMOBAR

{- ORMOLU_DISABLE -}
-- TODO: Use backgrounds when theming
myXmobarPP :: PP
myXmobarPP              =
  def
    { ppSep             = magenta " • ",
      ppTitleSanitize   = xmobarStrip,
      ppCurrent         = wrap " " "" . xmobarBorder "Top" "#8be9fd" 2,
      ppHidden          = white . wrap " " "",
      ppHiddenNoWindows = lowWhite . wrap " " "",
      ppUrgent          = red . wrap (yellow "!") (yellow "!"),
      ppOrder           = \[ws, l, _, wins] -> [ws, l, wins],
      ppExtras          = [logTitles formatFocused formatUnfocused]
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

-- KEYBINDS

mySpawn p = spawn ("xsetroot -cursor_name watch;xtoolwait " ++ p ++ ";xsetroot -cursor_name left_ptr")

{- ORMOLU_DISABLE -}
myKeybinds =
  [ ("M1-<F4>",                 kill),
    ("M-S-z",                   spawn "xscreensaver-command -lock"),
    ("M1-<F2>",                 spawn "dmenu_run  -f -i -l 10 -p 'sh -c'"),
    ("M-S-<Print>",             unGrab *> spawn "scrot -s"),
    --
    --("M-t f", toggleBorder),
    --("M-t b", toggleBorder),
    --("M-t t", toggleBorder),
    --
    ("M-s p",                   spawn "pavucontrol"),
    ("M-s r",                   spawn "vokoscreenNG"),
    ("M-s b",                   spawnOn (myWorkspaces !! 0) "chrome"),
    ("M-s h",                   spawnOn (myWorkspaces !! 3) "hakuneko-desktop"),
    ("M-s s",                   spawnOn (myWorkspaces !! 4) "dex /usr/share/applications/spotify.desktop"),
    --
    ("<XF86AudioLowerVolume>",  spawn ("$HOME/dotfiles/scripts/dwm/vol.sh down")),
    ("<XF86AudioMute>",         spawn ("$HOME/dotfiles/scripts/dwm/vol.sh mute")),
    ("<XF86AudioNext>",         spawn ("$HOME/dotfiles/scripts/dwm/media.sh next")),
    ("<XF86AudioPlay>",         spawn ("$HOME/dotfiles/scripts/dwm/media.sh play-pause")),
    ("<XF86AudioPrev>",         spawn ("$HOME/dotfiles/scripts/dwm/media.sh previous")),
    ("<XF86AudioRaiseVolume>",  spawn ("$HOME/dotfiles/scripts/dwm/vol.sh up")),
    ("<XF86MonBrightnessDown>", spawn ("$HOME/dotfiles/scripts/dwm/light.sh down")),
    ("<XF86MonBrightnessUp>",   spawn ("$HOME/dotfiles/scripts/dwm/light.sh up")),

    -- Make window sticky
     ("M-a", windows copyToAll),

    -- Unstick window
     ("M-S-a",  killAllOtherCopies)
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
      layoutHook         = myLayout, -- Use custom layouts
      terminal           = myTerminal,
      manageHook         = manageDocks <+> myManageHook, -- Match on certain windows
      startupHook        = myStartupHook,
      normalBorderColor  = myNormalBorderColor,
      focusedBorderColor = myFocusedBorderColor,
      workspaces         = myWorkspaces
    }
    `additionalKeysP` myKeybinds
{- ORMOLU_ENABLE -}
