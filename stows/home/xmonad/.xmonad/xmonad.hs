import XMonad
import qualified XMonad.StackSet as W
import XMonad.Util.EZConfig
import XMonad.Hooks.SetWMName
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Hooks.UrgencyHook
import XMonad.Layout.SubLayouts
import XMonad.Layout.WindowNavigation
import XMonad.Layout.BoringWindows
import XMonad.Layout.Tabbed
import XMonad.Actions.CycleWS
import System.IO
import XMonad.Util.Run(spawnPipe)
 
-- The main function.
main = xmonad =<< statusBar myBar myPP toggleStrutsKey myConfig
-- main = do
--   xmproc <- spawnPipe "xmobar ~/.xmobarrc"
--   xmonad $ myConfig


-- myLayout = addTabs shrinkText def
--          $ subLayout [0,1,2] (Simplest ||| Tall 1 0.2 0.5 ||| Circle)
--          $ Tall 1 0.2 0.5 ||| Full

-- myExtraWorkspaces = [(xK_0, "0"),(xK_minus, "tmp"),(xK_equal, "swap")]

-- myWorkspaces = ["1","2","3","4","5","6","7","8","9"] ++ (map snd myExtraWorkspaces)
myWorkspaces = [
  "q", "w", "e", "r", "t",
  "a", "s", "d", "f", "g",
  "z", "x", "c", "v", "b"
  ]


myModMask = mod4Mask
 
myKeys =
    [
      ("M-x s l", spawn "$HOME/.screenlayout/laptop_only") 
    , ("M-x s h", spawn "$HOME/.screenlayout/home") 
    , ("M-x s w", spawn "$HOME/.screenlayout/work") 
    , ("M-M1-C-p", spawn "mpc play") 
    , ("M-M1-C-s", spawn "mpc pause") 
    , ("M-x m a", spawn "urxvt -e alsamixer") 
    , ("M-x m n", spawn "urxvt -e ncmpcpp") 
    , ("M-M1-C-l", spawn "slock") 
    , ("M-M1-C-j", spawn "amixer -q set Master 2dB- unmute") 
    , ("M-M1-C-k", spawn "amixer -q set Master 2dB+ unmute") 
    , ("M-M1-C-m", spawn "amixer -q -D pulse set Master toggle") 
    , ("M-M1-C-<Backspace>", spawn "deh-lock-and-suspend") 
    , ("M-M1-C-b", sendMessage ToggleStruts) 
    , ("M-\\", spawn "emacsclient -c")
    , (("M-C-j"), nextWS)
    , (("M-C-k"), prevWS)
    ]
    ++
    [ (mask ++ "M-" ++ [key], screenWorkspace scr >>= flip whenJust (windows . action))
         | (key, scr)  <- zip "wer" [0,2,1] -- was [0..] *** change to match your screen order ***
         , (action, mask) <- [ (W.view, "") , (W.shift, "S-")]
    ]
    -- ++
    -- -- learn more haskell so that i don't have to hardcode each one of these :)
    -- [
    --   ("M-C-a", windows $ W.greedyView "a")
    -- , ("M-C-S-a", windows $ W.shift "a")
    -- , ("M-C-s", windows $ W.greedyView "s")
    -- , ("M-C-S-s", windows $ W.shift "s")
    -- , ("M-C-d", windows $ W.greedyView "d")
    -- , ("M-C-S-d", windows $ W.shift "d")
    -- , ("M-C-f", windows $ W.greedyView "f")
    -- , ("M-C-S-f", windows $ W.shift "f")
    -- , ("M-C-g", windows $ W.greedyView "g")
    -- , ("M-C-S-g", windows $ W.shift "g")
    -- , ("M-C-z", windows $ W.greedyView "z")
    -- , ("M-C-S-z", windows $ W.shift "z")
    -- , ("M-C-x", windows $ W.greedyView "x")
    -- , ("M-C-S-x", windows $ W.shift "x")
    -- , ("M-C-c", windows $ W.greedyView "c")
    -- , ("M-C-S-c", windows $ W.shift "c")
    -- , ("M-C-v", windows $ W.greedyView "v")
    -- , ("M-C-S-v", windows $ W.shift "v")
    -- , ("M-C-b", windows $ W.greedyView "b")
    -- , ("M-C-S-b", windows $ W.shift "b")
    -- , ("M-C-q", windows $ W.greedyView "q")
    -- , ("M-C-S-q", windows $ W.shift "q")
    -- , ("M-C-w", windows $ W.greedyView "w")
    -- , ("M-C-S-w", windows $ W.shift "w")
    -- , ("M-C-e", windows $ W.greedyView "e")
    -- , ("M-C-S-e", windows $ W.shift "e")
    -- , ("M-C-r", windows $ W.greedyView "r")
    -- , ("M-C-S-r", windows $ W.shift "r")
    -- , ("M-C-t", windows $ W.greedyView "t")
    -- , ("M-C-S-t", windows $ W.shift "t")
    -- ]

myLayoutHook = avoidStruts $ layoutHook defaultConfig

myManageHook = manageHook defaultConfig <+> manageDocks

-- commmand to launch the bar
myBar = "xmobar"

myTerminal = "urxvt"

-- Custom PP, configure it as you like. It determines what is being written to the bar.
myPP = xmobarPP { ppCurrent = xmobarColor "#429942" "" . wrap "<" ">" }

-- Key binding to toggle the gap for the bar.
toggleStrutsKey XConfig {XMonad.modMask = modMask} = (modMask, xK_b)

myStartupHook = setWMName "LG3D"

-- Main configuration, override the defaults to your liking.
myConfig = defaultConfig {
      modMask = myModMask,
      terminal = myTerminal,
      startupHook = myStartupHook,
      layoutHook = myLayoutHook,
      manageHook = myManageHook
      -- workspaces = myWorkspaces
    } `additionalKeysP` myKeys
