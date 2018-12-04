import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import qualified Graphics.X11.ExtraTypes.XF86 as XF86
import qualified XMonad.StackSet as W
import System.IO
import XMonad.Hooks.SetWMName
import XMonad.Layout.Spacing
import XMonad.Actions.CycleWS
import XMonad.Hooks.ManageHelpers
import XMonad.Util.Cursor

main = do
  xmproc <- spawnPipe ("xmobar -x 1 " ++ myXmobarrc)
  -- xmproc <- spawnPipe ("xmobar -x 2 " ++ myXmobarrc)
  
  xmonad $ defaultConfig {
    manageHook = myManageHook,
    layoutHook = myLayoutHook,
    logHook = dynamicLogWithPP xmobarPP
      { ppOutput = hPutStrLn xmproc,
        ppTitle = xmobarColor "green" "" . shorten 50
      },
    handleEventHook = myHandleEventHook,
    startupHook = myStartupHook,
    modMask = myModMask,
    terminal = myTerminal
  } `additionalKeys` myKeys

myKeys = [
    -- multimedia
    ((0, XF86.xF86XK_MonBrightnessUp), spawn "emacsclient -c"),
    ((0, XF86.xF86XK_AudioLowerVolume ), spawn "amixer -q set Master 2dB- unmute"),
    ((0, XF86.xF86XK_AudioRaiseVolume ), spawn "amixer -q set Master 2dB+ unmute"),
    ((0, XF86.xF86XK_AudioMute ), spawn "amixer -q set Master toggle && amixer -q set Headphone toggle"),
    -- ((0, XF86.xF86XK_AudioMute ), spawn "amixer -q sset Master toggle"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_minus), spawn "amixer -q set Master 2dB- unmute"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_equal), spawn "amixer -q set Master 2dB+ unmute"),

    -- brightness
    ((0, XF86.xF86XK_MonBrightnessDown ), spawn "xbacklight -dec 5"),
    ((0, XF86.xF86XK_MonBrightnessUp ), spawn "xbacklight -inc 5"),

    -- shortcuts
    ((mod4Mask, xK_backslash), spawn "emacsclient -c"),
    ((mod4Mask .|. shiftMask .|. mod1Mask .|. controlMask, xK_l), spawn "~/.screenlayout/laptop_only"),
    -- ((mod4Mask .|. mod1Mask .|. controlMask, xK_l), spawn "slock"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_l), spawn "deh-lock-and-suspend"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_s), spawn "mpc pause"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_x), spawn "xmodmap ~/.Xmodmap"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_p), spawn "mpc play"),
    ((mod4Mask .|. shiftMask .|. mod1Mask .|. controlMask, xK_equal), spawn "urxvt -e alsamixer"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_t), sendMessage ToggleStruts),

    -- workspaces
    ((mod4Mask .|. controlMask, xK_j), nextWS),
    ((mod4Mask .|. controlMask, xK_k), prevWS)
  ]
  ++
  [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0,2,1]
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myXmobarrc = "~/.xmonad/xmobar.hs"

myModMask = mod4Mask

myManageHook = composeAll
  [
    appName =? "urxvtfloat" --> doCenterFloat
  ]
  <+> manageDocks
  <+> manageHook defaultConfig

myStartupHook = do
  setDefaultCursor xC_left_ptr
  setWMName "LG3D"
  spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut true --expand true --width 15 --height 28 --alpha 0 --transparent true --tint 0x000000"

myTerminal = "urxvt"

-- this seems to keep xmobar from being hidden
-- https://unix.stackexchange.com/questions/288037/xmobar-does-not-appear-on-top-of-window-stack-when-xmonad-starts/303242#303242
myHandleEventHook = handleEventHook defaultConfig <+> docksEventHook

myLayoutHook = avoidStruts $ layoutHook defaultConfig
-- myLayoutHook = avoidStruts $ tiled ||| Mirror tiled ||| Full
--   where
--     tiled = smartSpacing 5 $ Tall nmaster delta ratio
--     nmaster = 1
--     ratio = 1/2
--     delta = 3/100
