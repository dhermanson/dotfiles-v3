-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup").widget
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- Load Debian menu entries
local debian = require("debian.menu")
local has_fdo, freedesktop = pcall(require, "freedesktop")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
   naughty.notify({ preset = naughty.config.presets.critical,
                    title = "Oops, there were errors during startup!",
                    text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
   local in_error = false
   awesome.connect_signal("debug::error", function (err)
                             -- Make sure we don't go into an endless error loop
                             if in_error then return end
                             in_error = true

                             naughty.notify({ preset = naughty.config.presets.critical,
                                              title = "Oops, an error happened!",
                                              text = tostring(err) })
                             in_error = false
   end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "zenburn/theme.lua")
-- beautiful.init(gears.filesystem.get_themes_dir() .. "xresources/theme.lua")
-- beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")
-- beautiful.init(gears.filesystem.get_themes_dir() .. "sky/theme.lua")

-- beautiful.init("/~/.config/awesome/themes/default/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "x-terminal-emulator"
editor = os.getenv("EDITOR") or "editor"
editor_cmd = terminal .. " -e " .. editor
home = os.getenv("HOME")


-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.tile.bottom,
   awful.layout.suit.spiral.dwindle,
   awful.layout.suit.corner.nw,
   awful.layout.suit.fair.horizontal,
   awful.layout.suit.fair,
   awful.layout.suit.spiral,
   awful.layout.suit.tile.left,
   awful.layout.suit.tile.top,
   awful.layout.suit.magnifier,
   awful.layout.suit.max,
   awful.layout.suit.max.fullscreen,
   awful.layout.suit.floating,
   -- awful.layout.suit.corner.ne,
   -- awful.layout.suit.corner.sw,
   -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Helper functions
local function client_menu_toggle_fn()
   local instance = nil

   return function ()
      if instance and instance.wibox.visible then
         instance:hide()
         instance = nil
      else
         instance = awful.menu.clients({ theme = { width = 250 } })
      end
   end
end
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() return false, hotkeys_popup.show_help end},
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end}
}

local menu_awesome = { "awesome", myawesomemenu, beautiful.awesome_icon }
local menu_terminal = { "open terminal", terminal }

if has_fdo then
   mymainmenu = freedesktop.menu.build({
         before = { menu_awesome },
         after =  { menu_terminal }
   })
else
   mymainmenu = awful.menu({
         items = {
            menu_awesome,
            { "Debian", debian.menu.Debian_menu.Debian },
            menu_terminal,
         }
   })
end


mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
-- mytextclock = wibox.widget.textclock{ format = "%a %b %d %I", refresh = 5, timezone = "local timezone" }
-- mytextclock = wibox.widget.textclock{}
mytextclock = wibox.widget.textclock("  %a %b %d %l:%M:%S  ", 2)

-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(
   awful.button({ }, 1, function(t) t:view_only() end),
   awful.button({ modkey }, 1, function(t)
         if client.focus then
            client.focus:move_to_tag(t)
         end
   end),
   awful.button({ }, 3, awful.tag.viewtoggle),
   awful.button({ modkey }, 3, function(t)
         if client.focus then
            client.focus:toggle_tag(t)
         end
   end),
   awful.button({ }, 4, function(t) awful.tag.viewnext(t.screen) end),
   awful.button({ }, 5, function(t) awful.tag.viewprev(t.screen) end)
)

local tasklist_buttons = gears.table.join(
   awful.button({ }, 1, function (c)
         if c == client.focus then
            c.minimized = true
         else
            -- Without this, the following
            -- :isvisible() makes no sense
            c.minimized = false
            if not c:isvisible() and c.first_tag then
               c.first_tag:view_only()
            end
            -- This will also un-minimize
            -- the client, if needed
            client.focus = c
            c:raise()
         end
   end),
   awful.button({ }, 3, client_menu_toggle_fn()),
   awful.button({ }, 4, function ()
         awful.client.focus.byidx(1)
   end),
   awful.button({ }, 5, function ()
         awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
   -- Wallpaper
   if beautiful.wallpaper then
      local wallpaper = beautiful.wallpaper
      -- If wallpaper is a function, call it with the screen
      if type(wallpaper) == "function" then
         wallpaper = wallpaper(s)
      end
      gears.wallpaper.maximized(wallpaper, s, true)
   end
end

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
-- screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
      -- Wallpaper
      -- set_wallpaper(s)

      -- Each screen has its own tag table.
      -- awful.tag({ "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "a ", "b ", "c ", "d ", "e ", "f ", "g ", "h ", "i ", "j ", "k ", "l ", "m ", "n ", "o ", "p ", "q ", "r ", "s ", "t ", "u ", "v ", "w ", "x ", "y ", "z " }, s, awful.layout.layouts[1])
      awful.tag({ "1 ", "2 ", "3 ", "4 ", "5 ", "6 ", "7 ", "8 ", "9 ", "a ", "s ", "d ", "q ", "w ", "e ", "r ", "g ", "z ", "x ", "v ", "b "  }, s, awful.layout.layouts[1])

      -- Create a promptbox for each screen
      s.mypromptbox = awful.widget.prompt()
      -- Create an imagebox widget which will contain an icon indicating which layout we're using.
      -- We need one layoutbox per screen.
      s.mylayoutbox = awful.widget.layoutbox(s)
      s.mylayoutbox:buttons(gears.table.join(
                               awful.button({ }, 1, function () awful.layout.inc( 1) end),
                               awful.button({ }, 3, function () awful.layout.inc(-1) end),
                               awful.button({ }, 4, function () awful.layout.inc( 1) end),
                               awful.button({ }, 5, function () awful.layout.inc(-1) end)))
      -- Create a taglist widget
      s.mytaglist = awful.widget.taglist(s, awful.widget.taglist.filter.all, taglist_buttons)

      -- Create a tasklist widget
      s.mytasklist = awful.widget.tasklist(s, awful.widget.tasklist.filter.currenttags, tasklist_buttons)

      -- Create the wibox
      s.mywibox = awful.wibar({ position = "top", screen = s })

      -- Add widgets to the wibox
      s.mywibox:setup {
         layout = wibox.layout.align.horizontal,
         { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            -- mylauncher,
            s.mytaglist,
            s.mypromptbox,
         },
         s.mytasklist, -- Middle widget
         { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
            wibox.widget.systray(),
            mytextclock,
            s.mylayoutbox,
         },
      }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
                awful.button({ }, 3, function () mymainmenu:toggle() end),
                awful.button({ }, 4, awful.tag.viewnext),
                awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
   -- awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
   --    {description="show help", group="awesome"}),
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
      {description = "view next", group = "tag"}),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
      {description = "go back", group = "tag"}),

   awful.key({ modkey,           }, "j",
      function ()
         awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   awful.key({ modkey,           }, "Down",
      function ()
         awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   awful.key({ modkey,           }, "k",
      function ()
         awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),
   awful.key({ modkey,           }, "Up",
      function ()
         awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),
   -- awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
   --           {description = "show main menu", group = "awesome"}),

   -- Layout manipulation
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),
   awful.key({ modkey,           }, "Tab",
      function ()
         awful.client.focus.history.previous()
         if client.focus then
            client.focus:raise()
         end
      end,
      {description = "go back", group = "client"}),


   -- Standard program
   awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
      {description = "open a terminal", group = "launcher"}),
   awful.key({ modkey, "Mod1", "Control" }, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),
   awful.key({ modkey, "Mod1", "Control", "Shift"   }, "q", awesome.quit,
      {description = "quit awesome", group = "awesome"}),

   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
      {description = "decrease master width factor", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
      {description = "increase the number of columns", group = "layout"}),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
      {description = "decrease the number of columns", group = "layout"}),
   awful.key({ modkey,           }, "[", function () awful.layout.inc( 1)                end,
      {description = "select next", group = "layout"}),
   awful.key({ modkey,           }, "]", function () awful.layout.inc(-1)                end,
      {description = "select previous", group = "layout"}),

   awful.key({ modkey, "Control" }, "n",
      function ()
         local c = awful.client.restore()
         -- Focus restored client
         if c then
            client.focus = c
            c:raise()
         end
      end,
      {description = "restore minimized", group = "client"}),

   -- Prompt
   -- awful.key({ modkey, "Control", "Mod1" },            "r",     function () awful.screen.focused().mypromptbox:run() end,
   --    {description = "run prompt", group = "launcher"}),

   -- awful.key({ modkey }, "x",
   --    function ()
   --       awful.prompt.run {
   --          prompt       = "Run Lua code: ",
   --          textbox      = awful.screen.focused().mypromptbox.widget,
   --          exe_callback = awful.util.eval,
   --          history_path = awful.util.get_cache_dir() .. "/history_eval"
   --       }
   --    end,
   --    {description = "lua execute prompt", group = "awesome"}),
   -- Menubar
   -- awful.key({ modkey }, "p", function() menubar.show() end,
   --           {description = "show the menubar", group = "launcher"})
   
   -- My mods
   awful.key({ modkey}, "p", function() awful.util.spawn("rofi -show run -width 70") end),
   -- awful.key({ modkey, "Control", "Mod1" }, "x", function() awful.util.spawn("xmodmap " .. home .. "/.Xmodmap") end),
   -- awful.key({ modkey, "Control", "Mod1" }, "p", function() awful.util.spawn("mpc play") end),
   -- awful.key({ modkey, "Shift", "Control", "Mod1" }, "p", function() awful.util.spawn("mpc pause") end),
   awful.key({ modkey, "Control", "Mod1" }, "-", function() awful.util.spawn("amixer -q set Master 2dB- unmute") end),
   awful.key({ modkey, "Control", "Mod1" }, "=", function() awful.util.spawn("amixer -q set Master 2dB+ unmute") end),
   awful.key({ modkey, "Shift", "Control", "Mod1" }, "-", function() awful.util.spawn("amixer -q -c 1 set Speaker 2dB- unmute") end),
   awful.key({ modkey, "Shift", "Control", "Mod1" }, "=", function() awful.util.spawn("amixer -q -c 1 set Speaker 2dB+ unmute") end),
   -- awful.key({ modkey, "Control", "Mod1" }, "a", function() awful.util.spawn("urxvtc -e sh -c 'alsamixer -c 1'") end),
   awful.key({ modkey, "Control", "Mod1" }, "l", function() awful.util.spawn("deh-lock-and-suspend") end),
   -- awful.key({ modkey, "Control", "Mod1" }, "s", function() awful.util.spawn_with_shell("sleep 0.6 && deh-scrot") end),
   awful.key({ modkey, "Shift", "Control", "Mod1" }, "l", function() awful.util.spawn(home .. "/.screenlayout/laptop_only") end),
   -- awful.key({ modkey, "Shift", "Control", "Mod1" }, "v", function() awful.util.spawn("pavucontrol") end),
   awful.key({ modkey, "Control", "Mod1" }, "h", function() awful.util.spawn(home .. "/.screenlayout/home.sh") end),
   awful.key({ modkey, "Control", "Mod1" }, "w", function() awful.util.spawn(home .. "/.screenlayout/work.sh") end),
   awful.key({ modkey, "Shift", "Control", "Mod1" }, "r", function() awful.util.spawn("nitrogen --restore") end),
   awful.key({ modkey }, '\\', function() awful.util.spawn("emacsclient -c") end),
   -- awful.key({ modkey }, "e", function() awful.util.spawn("deh-file-manager") end),
   awful.key({ modkey }, "space", function () awful.util.spawn("rofi -show window -width 70") end,  {description = "switch windows", group = "client"}),
   -- awful.key({ modkey, "Control" }, "space", function () awful.util.spawn("rofi -show windowcd -width 70") end,  {description = "switch windows", group = "client"})
   awful.key({ modkey, "Control" }, "space", function () awful.util.spawn("rofi -show windowcd -width 70") end,  {description = "switch windows", group = "client"}),
   -- awful.key({ modkey }, "g", function () awful.util.spawn("rofi -show windowcd -width 70") end,  {description = "switch windows", group = "client"}),
   -- awful.key({ modkey }, "semicolon", function () awful.util.spawn("rofi -show windowcd -width 70") end,  {description = "switch windows", group = "client"}),
   -- awful.key({ modkey, "Control" }, "space", function () awful.util.spawn("rofi -show run -width 70") end)

   -- awful.key({ modkey }, "t", function () client.focus =  awful.client.next(3, awful.client.getmaster()); client.focus:raise() end,
   --            {description = "focus master+3", group = "client"})
   -- awful.key({ modkey }, "w", function () client.focus = awful.client.getmaster(); client.focus:raise() end,
   --    {description = "focus master", group = "client"}),
   -- awful.key({ modkey }, "e", function () client.focus =  awful.client.next(1, awful.client.getmaster()); client.focus:raise() end,
   --    {description = "focus master+1", group = "client"}),
   -- awful.key({ modkey }, "r", function () client.focus =  awful.client.next(2, awful.client.getmaster()); client.focus:raise() end,
   --    {description = "focus master+2", group = "client"})

   --- Sound
   -- awful.key({ }, "XF86AudioPlay", function () awful.util.spawn("mpc toggle") end),
   awful.key({ }, "XF86AudioNext", function () awful.util.spawn("mpc next") end),
   awful.key({ }, "XF86AudioPrev", function () awful.util.spawn("mpc prev") end),
   awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -c 0 set Master 1dB+") end),
   awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -c 0 set Master 1dB-") end),
   awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -c 0 set Master toggle") end),

    -- Brightness

   awful.key({ }, "XF86MonBrightnessDown", function ()
         awful.util.spawn("xbacklight -dec 10") end),
   awful.key({ }, "XF86MonBrightnessUp", function ()
         awful.util.spawn("xbacklight -inc 10") end)
)

clientkeys = gears.table.join(
   awful.key({ modkey,  }, "f",
      function (c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   -- awful.key({ modkey, "Shift" }, "w",
   --    function (c)
   --       local clientOriginallyInDestination = awful.client.getmaster()
   --       c:swap( clientOriginallyInDestination )
   --       -- client.focus = clientOriginallyInDestination
   --       -- client.focus:raise()
   --    end,
   --    {description = "move to master", group = "client"}),
   -- awful.key({ modkey, "Shift" }, "e",
   --    function (c)
   --       local clientOriginallyInDestination = awful.client.next(1, awful.client.getmaster())
   --       c:swap( clientOriginallyInDestination )
   --       -- client.focus = clientOriginallyInDestination
   --       -- client.focus:raise()
   --    end,
   --    {description = "move to master+1", group = "client"}),
   -- awful.key({ modkey, "Shift" }, "r",
   --    function (c)
   --       local clientOriginallyInDestination = awful.client.next(2, awful.client.getmaster())
   --       c:swap( clientOriginallyInDestination )
   --       -- client.focus = clientOriginallyInDestination
   --       -- client.focus:raise()
   --    end,
   --    {description = "move to master+2", group = "client"}),
   awful.key({ modkey, "Shift",    }, "c",      function (c) c:kill()                         end,
      {description = "close", group = "client"}),
   -- awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
   awful.key({ modkey, "Control" }, "f",  awful.client.floating.toggle                     ,
      {description = "toggle floating", group = "client"}),
   awful.key({ modkey, "Control" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ modkey,  }, "semicolon", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
      {description = "move to screen", group = "client"}),
   -- awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
   --    {description = "toggle keep on top", group = "client"}),
   awful.key({ modkey,           }, "n",
      function (c)
         -- The client currently has the input focus, so it cannot be
         -- minimized, since minimized clients can't have the focus.
         c.minimized = true
      end ,
      {description = "minimize", group = "client"}),
   awful.key({ modkey,           }, "m",
      function (c)
         c.maximized = not c.maximized
         c:raise()
      end ,
      {description = "(un)maximize", group = "client"}),
   awful.key({ modkey, "Control" }, "m",
      function (c)
         c.maximized_vertical = not c.maximized_vertical
         c:raise()
      end ,
      {description = "(un)maximize vertically", group = "client"}),
   awful.key({ modkey, "Shift"   }, "m",
      function (c)
         c.maximized_horizontal = not c.maximized_horizontal
         c:raise()
      end ,
      {description = "(un)maximize horizontally", group = "client"})
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
   globalkeys = gears.table.join(globalkeys,
                                 -- View tag only.
                                 awful.key({ modkey }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          tag:view_only()
                                       end
                                    end,
                                    {description = "view tag #"..i, group = "tag"}),
                                 -- Toggle tag display.
                                 awful.key({ modkey, "Control" }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          awful.tag.viewtoggle(tag)
                                       end
                                    end,
                                    {description = "toggle tag #" .. i, group = "tag"}),
                                 -- Move client to tag.
                                 awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag then
                                             client.focus:move_to_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "move focused client to tag #"..i, group = "tag"}),
                                 -- Toggle tag on focused client.
                                 awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag then
                                             client.focus:toggle_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "toggle focused client on tag #" .. i, group = "tag"}),

                                 -- View tag only.
                                 awful.key({ modkey, "Mod1" }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          tag:view_only()
                                       end
                                    end,
                                    {description = "view tag #"..i, group = "tag"}),
                                 -- Toggle tag display.
                                 awful.key({ modkey, "Mod1", "Control" }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          awful.tag.viewtoggle(tag)
                                       end
                                    end,
                                    {description = "toggle tag #" .. i, group = "tag"}),
                                 -- Move client to tag.
                                 awful.key({ modkey, "Mod1", "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag then
                                             client.focus:move_to_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "move focused client to tag #"..i, group = "tag"}),
                                 -- Toggle tag on focused client.
                                 awful.key({ modkey, "Mod1", "Control", "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag then
                                             client.focus:toggle_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "toggle focused client on tag #" .. i, group = "tag"})
   )
end



-- local alphabet = "abcdefghijklmnopqrstuvwxyz"
local alphabet = "asdqwergzxvb"

-- add comma, period, and semicolon

for i = 1, #alphabet do
   local alphabet_letter = alphabet:sub(i, i)
   globalkeys = gears.table.join(globalkeys,
                                 -- View tag only.
                                 awful.key({ modkey, }, alphabet_letter,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i + 9]
                                       if tag then
                                          tag:view_only()
                                       end
                                    end,
                                    {description = "view tag ".. alphabet_letter, group = "tag"}),
                                 -- Toggle tag display.
                                 awful.key({ modkey, "Control" }, alphabet_letter,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i + 9]
                                       if tag then
                                          awful.tag.viewtoggle(tag)
                                       end
                                    end,
                                    {description = "toggle tag " .. alphabet_letter, group = "tag"}),
                                 -- Move client to tag.
                                 awful.key({ modkey, "Shift" }, alphabet_letter,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i + 9]
                                          if tag then
                                             client.focus:move_to_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "move focused client to tag ".. alphabet_letter, group = "tag"}),
                                 -- Toggle tag on focused client.
                                 awful.key({ modkey, "Control", "Shift" }, alphabet_letter,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i + 9]
                                          if tag then
                                             client.focus:toggle_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "toggle focused client on tag " .. alphabet_letter, group = "tag"})
   )
end


-- TODO: implement this stuff
-- globalkeys = gears.table.join(globalkeys,
--                               -- View tag only.
--                               awful.key({ modkey }, "a",
--                                  function ()
--                                     local screen = awful.screen.focused()
--                                     local tag = screen.tags[1 + 9]
--                                     if tag then
--                                        tag:view_only()
--                                     end
--                                  end,
--                                  {description = "view tag a", group = "tag"})
-- )

clientbuttons = gears.table.join(
   awful.button({ }, 1, function (c) client.focus = c; c:raise() end),
   awful.button({ modkey }, 1, function (c) client.focus = c; c:raise(); awful.mouse.client.move() end),
   awful.button({ modkey }, 3, awful.mouse.client.resize))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
   -- All clients will match this rule.
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = clientkeys,
                    buttons = clientbuttons,
                    screen = awful.screen.preferred,
                    placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                    size_hints_honor = false
     }
   },

   -- Floating clients.
   { rule_any = {
        instance = {
           "DTA",  -- Firefox addon DownThemAll.
           "copyq",  -- Includes session name in class.
        },
        class = {
           "Arandr",
           "Gpick",
           "Kruler",
           "MessageWin",  -- kalarm.
           "Sxiv",
           "Wpa_gui",
           "pinentry",
           "veromix",
           "xtightvncviewer"},

        name = {
           "Event Tester",  -- xev.
        },
        role = {
           "AlarmWindow",  -- Thunderbird's calendar.
           "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
   }, properties = { floating = true }},
   --
   --
   -- Floating clients for emacs find file.
   -- { rule_any = {
   --     name = {
   --       "deh-find-file",
   --       "deh-tmux-find-file",
   --       "alacritty",
   --       "urxvtfloat",
   --       -- "tmux",
   --     },
   --     class = {
   --        "urxvtfloat"
   --     }
   -- }, properties = { floating = true, placement = awful.placement.centered }},
   -- Floating clients for any urxvt with the class of urxvt (this is signified by urxvt's -name arg)
   -- { rule_any = {
   --      class = {
   --         "URxvt",
   --      },
   --      instance = {
   --         "urxvtfloat"
   --      }
   -- }, properties = { floating = true, placement = awful.placement.centered }},

   -- Floating clients for any urxvt which has instance of "urxvtfloat" (this is signified by urxvt's -name urxvtfloat)
   {
      rule = { class = "URxvt", instance = "urxvtfloat" },
      properties = { floating = true, placement = awful.placement.centered }
   },

   -- Add titlebars to normal clients and dialogs
   { rule_any = {type = { "normal", "dialog" }
                }, properties = { titlebars_enabled = true }
   },

   -- Set Firefox to always map on the tag named "2" on screen 1.
   -- { rule = { class = "Firefox" },
   --   properties = { screen = 1, tag = "2" } },
   -- Intellij

   {
      rule = {
         class = "jetbrains-.*",
         instance = "sun-awt-X11-XWindowPeer",
         name = "win.*"
      },
      properties = {
         floating = true,
         focus = true,
         focusable = false,
         ontop = true,
         placement = awful.placement.restore,
         buttons = {}
      }
   },

}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
                         -- Set the windows at the slave,
                         -- i.e. put it at the end of others instead of setting it master.
                         if not awesome.startup then
                            awful.client.setslave(c)
                            awful.placement.no_offscreen(c)
                         end

                         -- if awesome.startup and
                         --    not c.size_hints.user_position
                         -- and not c.size_hints.program_position then
                         --    -- Prevent clients from being unreachable after screen count changes.
                         --    awful.placement.no_offscreen(c)
                         -- end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
                         -- buttons for the titlebar
                         local buttons = gears.table.join(
                            awful.button({ }, 1, function()
                                  client.focus = c
                                  c:raise()
                                  awful.mouse.client.move(c)
                            end),
                            awful.button({ }, 3, function()
                                  client.focus = c
                                  c:raise()
                                  awful.mouse.client.resize(c)
                            end)
                         )

                         awful.titlebar(c) : setup {
                            { -- Left
                               awful.titlebar.widget.iconwidget(c),
                               buttons = buttons,
                               layout  = wibox.layout.fixed.horizontal
                            },
                            { -- Middle
                               { -- Title
                                  align  = "center",
                                  widget = awful.titlebar.widget.titlewidget(c)
                               },
                               buttons = buttons,
                               layout  = wibox.layout.flex.horizontal
                            },
                            { -- Right
                               awful.titlebar.widget.floatingbutton (c),
                               awful.titlebar.widget.maximizedbutton(c),
                               awful.titlebar.widget.stickybutton   (c),
                               awful.titlebar.widget.ontopbutton    (c),
                               awful.titlebar.widget.closebutton    (c),
                               layout = wibox.layout.fixed.horizontal()
                            },
                            layout = wibox.layout.align.horizontal
                                                   }
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
                         if awful.layout.get(c.screen) ~= awful.layout.suit.magnifier
                         and awful.client.focus.filter(c) then
                            client.focus = c
                         end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- make rofi possible to raise minimized clients
client.connect_signal("request::activate",
                      function(c, context, hints)
                         if c.minimized then
                            c.minimized = false
                         end
                         awful.ewmh.activate(c, context, hints)
end)
