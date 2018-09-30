import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
 
-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig

modm = mod4Mask
 
myKeys =
    [
      ("M-x s l", spawn "$HOME/.screenlayout/laptop_only.sh") 
    , ("M-x s h", spawn "$HOME/.screenlayout/home.sh") 
    , ("M-\\", spawn "emacsclient -c") 
    ]
    ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "wer" [2,0,1] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]

myLayoutHook = avoidStruts $ layoutHook defaultConfig

myManageHook = manageHook defaultConfig <+> manageDocks

-- commmand to launch the bar
myBar = "xmobar"

myTerminal = "konsole"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myStartupHook = setWMName "LG3D"

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig {
      modMask = modm,
      terminal = myTerminal,
      startupHook = myStartupHook,
      layoutHook = myLayoutHook,
      manageHook = myManageHook
    } `additionalKeysP` myKeys
