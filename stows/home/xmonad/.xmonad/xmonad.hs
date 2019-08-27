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
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.Place
import XMonad.Actions.TagWindows
import XMonad.Prompt
-- import DBus.Client

-- main = do
--   xmproc <- spawnPipe ("xmobar -x 1 " ++ myXmobarrc)
--   -- xmproc <- spawnPipe ("xmobar " ++ myXmobarrc)
--   -- xmproc <- spawnPipe ("xmobar -x 2 " ++ myXmobarrc)
--   -- spawn "stalonetray"
  
--   xmonad $ 

main = xmonad =<< statusBar ("xmobar " ++ myXmobarrc) myPP toggleStrutsKey (ewmh myConfig)

myConfig = defaultConfig {
    manageHook = myManageHook,
    layoutHook = myLayoutHook,
    -- logHook = dynamicLogWithPP xmobarPP
    --   { ppOutput = hPutStrLn xmproc,
    --     ppTitle = xmobarColor "green" "" . shorten 50
    --   },
    -- handleEventHook = myHandleEventHook,
    startupHook = myStartupHook,
    modMask = myModMask,
    terminal = myTerminal,
    borderWidth = myBorderWidth,
    normalBorderColor  = myNormalBorderColor,
    focusedBorderColor = myFocusedBorderColor
  } `additionalKeys` myKeys

-- key binding to toggle the gap for the bar
toggleStrutsKey XConfig {XMonad.modMask = mod4Mask} = (mod4Mask, xK_b)
normalBorderCol, focusedBorderCol, currentCol, layoutCol :: String
currentCol       = "#fff"
layoutCol        = "#aaa"
normalBorderCol  = "#000"
-- focusedBorderCol = "#4af" -- and current window's title in status bar
focusedBorderCol = "#b16286" -- and current window's title in status bar
myNormalBorderColor  = "#282828"
myFocusedBorderColor = "#b16286"

-- what's displayed in the status bar
myPP :: PP
myPP = defaultPP
        { ppCurrent = xmobarColor currentCol "" . wrap "[" "]"
        , ppLayout = xmobarColor layoutCol ""
        , ppTitle = xmobarColor focusedBorderCol ""
        }

myKeys = [
    -- multimedia
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

    ((mod4Mask, xK_space), spawn "rofi -show window -width 95"),
    ((mod4Mask, xK_bracketleft ), sendMessage NextLayout), -- %! Rotate through the available layout algorithms

    -- layouts
    
    -- ((mod4Mask, xK_bracketleft), spawn "rofi -show run"),
    ((mod4Mask, xK_p), spawn "rofi -show run"),
    --  Reset the layouts on the current workspace to default
    -- ((mod4Mask , xK_bracketleft ), setLayout $ XMonad.layoutHook defaultConfig),

    -- workspaces
    -- ((modm,xK_j     ), windows W.focusDown)
    -- ((mod4Mask .|. controlMask, xK_j), nextWS),
    ((mod4Mask .|. controlMask, xK_j), nextWS),
    ((mod4Mask, xK_Up), windows W.focusUp),
    ((mod4Mask, xK_Down), windows W.focusDown),
    ((mod4Mask, xK_Right), nextWS),
    -- ((mod4Mask .|. controlMask, xK_j), windows W.focusDown),
    -- ((mod4Mask .|. controlMask, xK_n), nextWS),
    -- ((mod4Mask .|. controlMask, xK_k), prevWS),
    ((mod4Mask .|. controlMask, xK_k), prevWS),
    ((mod4Mask, xK_Left), prevWS),
    -- ((mod4Mask .|. controlMask, xK_p), prevWS),
    -- ((mod4Mask, xK_n), nextWS),
    -- ((mod4Mask, xK_p), prevWS),
    -- ((mod4Mask, xK_f), nextWS),
    -- ((mod4Mask, xK_b), prevWS),
    ((mod4Mask,               xK_semicolon     ), spawn "exe=`dmenu_path | dmenu` && eval \"exec $exe\""),
    ((mod4Mask, xK_i), withFocused (addTag "abc")),
    ((mod4Mask, xK_o), withFocused (delTag "abc")),
    ((mod4Mask, xK_d), focusUpTaggedGlobal "abc")
  ]
  ++
  [((m .|. myModMask, key), screenWorkspace sc >>= flip whenJust (windows . f))
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0,1,2]
        -- | (key, sc) <- zip [xK_w, xK_e, xK_r] [0,2,1]
        | (key, sc) <- zip [xK_w, xK_e, xK_r] [1,0,2]
        , (f, m) <- [(W.view, 0), (W.shift, shiftMask)]]

myXmobarrc = "~/.xmonad/xmobar.hs"

myModMask = mod4Mask

myManageHook = composeAll
  [
    appName =? "urxvtfloat" --> doCenterFloat,
    appName =? "urxvtreplfloat" --> placeHook lowerRight <+> doFloat,
    appName =? "urxvtreplowndesktop" --> doShift (show 6)
    -- appName =? "urxvtreplfloat" --> doRectFloat (W.RationalRect 0 0.5 1 0.5)
  ]
  <+> manageHook defaultConfig
  <+> manageDocks
 where
      upperRight = (withGaps (20,20,20,20) (fixed (1, 0.05)))
      lowerRight = (withGaps (20,20,20,20) (fixed (1, 0.95)))


myStartupHook = do
  setDefaultCursor xC_left_ptr
  -- spawn "trayer --edge top --align right --SetDockType true --SetPartialStrut false --expand true --width 15 --height 28 --alpha 0 --transparent true --tint 0x000000"
  setWMName "LG3D"

myTerminal = "urxvt"

myBorderWidth = 4


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

