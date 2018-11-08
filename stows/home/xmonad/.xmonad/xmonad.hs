import XMonad
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run(spawnPipe)
import XMonad.Util.EZConfig
import qualified XMonad.StackSet as W
import System.IO
import XMonad.Hooks.SetWMName
import XMonad.Layout.Spacing
import XMonad.Actions.CycleWS

main = do
  xmproc <- spawnPipe ("xmobar -x 2 " ++ myXmobarrc)
  
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
    ((mod4Mask, xK_backslash), spawn "emacsclient -c"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_l), spawn "slock"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_s), spawn "mpc pause"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_p), spawn "mpc play"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_minus), spawn "amixer -q set Master 2dB- unmute"),
    ((mod4Mask .|. shiftMask .|. mod1Mask .|. controlMask, xK_equal), spawn "amixer -q set Master 2dB+ unmute"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_equal), spawn "urxvt -e alsamixer"),
    ((mod4Mask .|. mod1Mask .|. controlMask, xK_t), sendMessage ToggleStruts),
    ((mod4Mask .|. controlMask, xK_j), nextWS),
    ((mod4Mask .|. controlMask, xK_k), prevWS)
  ]
  ++
  [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [0,2,1]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myXmobarrc = "~/.xmonad/xmobar.hs"

myModMask = mod4Mask

myManageHook = manageDocks <+> manageHook defaultConfig

myStartupHook = setWMName "LG3D"

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
