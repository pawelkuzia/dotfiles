package.loaded["naughty.dbus"] = {} 

-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
-- local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
local switcher = require("awesome-switcher")
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
beautiful.init("/home/pawelkuzia/.config/awesome/themes/wheatleydark 2/theme.lua")
local bling = require("bling")
-- bling.module.flash_focus.enable()

--- Enable Wndow Switcher 
--~ bling.widget.window_switcher.enable {
    --~ type = "thumbnail", -- set to anything other than "thumbnail" to disable client previews

    --~ -- keybindings (the examples provided are also the default if kept unset)
    --~ hide_window_switcher_key = "Escape", -- The key on which to close the popup
    --~ minimize_key = "n",                  -- The key on which to minimize the selected client
    --~ unminimize_key = "N",                -- The key on which to unminimize all clients
    --~ kill_client_key = "q",               -- The key on which to close the selected client
    --~ cycle_key = "Tab",                   -- The key on which to cycle through all clients
    --~ previous_key = "Left",               -- The key on which to select the previous client
    --~ next_key = "Right",                  -- The key on which to select the next client
    --~ vim_previous_key = "h",              -- Alternative key on which to select the previous client
    --~ vim_next_key = "l",                  -- Alternative key on which to select the next client

    --~ cycleClientsByIdx = awful.client.focus.byidx,               -- The function to cycle the clients
    --~ filterClients = awful.widget.tasklist.filter.currenttags,   -- The function to filter the viewed clients
--~ }



-- Lain
local lain = require("lain")


local quake = lain.util.quake({
  app = "kitty",
  argname = '--class %s',
  name = 'Quakacritty',
  border = 3,
  height = 0.5,
  width = 1280,
  horiz = "center",
  followtag = true,
  visible = false,
  overlap = false,
  followtag = false,
})
-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {
    awful.layout.suit.floating,
    bling.layout.centered,
    -- bling.layout.vertical,
    -- awful.layout.suit.tile,
    -- awful.layout.suit.max,
    -- awful.layout.suit.max.fullscreen,
    -- awful.layout.suit.magnifier,
    awful.layout.suit.tile.right,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    -- awful.layout.suit.fair,
    -- awful.layout.suit.fair.horizontal,
    -- awful.layout.suit.spiral,
    -- awful.layout.suit.spiral.dwindle,
    -- awful.layout.suit.corner.nw,
    -- awful.layout.suit.corner.ne,
    -- awful.layout.suit.corner.sw,
    -- awful.layout.suit.corner.se,
}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {
   { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
   { "manual", terminal .. " -e man awesome" },
   { "edit config", editor_cmd .. " " .. awesome.conffile },
   { "restart", awesome.restart },
   { "quit", function() awesome.quit() end },
}

mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                    { "open terminal", terminal }
                                  }
                        })

mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
                                     menu = mymainmenu })

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- Keyboard map indicator and switcher
mykeyboardlayout = awful.widget.keyboardlayout()

-- {{{ Wibar
-- Create a textclock widget
mytextclock = wibox.widget.textclock()



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
                                                  c:emit_signal(
                                                      "request::activate",
                                                      "tasklist",
                                                      {raise = true}
                                                  )
                                              end
                                          end),
                     awful.button({ }, 3, function()
                                              awful.menu.client_list({ theme = { width = 500 } })
                                          end),
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
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
   set_wallpaper(s)

    -- Each screen has its own tag table.
--    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" }, s, awful.layout.layouts[1])
if s.index == 1 then
    --~ awful.tag({ "main", "game", "misc" }, screen[1], awful.layout.layouts[1])
    awful.tag({ "main" }, screen[1], awful.layout.layouts[2])
    awful.tag({ "game"}, screen[1], awful.layout.layouts[3])
    awful.tag({ "misc" }, screen[1], awful.layout.layouts[1])
end
if s.index == 2 then
    awful.tag({ "mail" }, screen[2], awful.layout.layouts[4])
    awful.tag({ "obs"}, screen[2], awful.layout.layouts[5])
end
if s.index == 3 then
    awful.tag({ "im", "stream"}, screen[3], awful.layout.layouts[4])
end
    

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
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
        
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
            layout   = {
        spacing_widget = {
            {
                forced_width  = 5,
                forced_height = 18,
                thickness     = 1,
                color         = "#585b70",
                widget        = wibox.widget.separator
            },
            valign = "center",
            halign = "center",
            widget = wibox.container.place,
        },
        spacing = 50,
        layout  = wibox.layout.fixed.horizontal
    }
    }

-- Create spearator

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s })

    -- Add widgets to the wibox
    s.mywibox:setup {
		
		spacing = 10,
        layout = wibox.layout.align.horizontal,
--        expand = "all",
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
--            wibox.layout.margin(mylauncher, 12, 6, 6, 6),
            wibox.layout.margin(s.mytaglist, 12, 0, 0, 0),
            s.mypromptbox,
            wibox.widget.textbox("        "),
        },
        -- Middle widghet
        s.mytasklist,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            mykeyboardlayout,
--            wibox.widget.systray(),
            wibox.layout.margin(wibox.widget.systray(), 6, 6, 6, 6),
            mytextclock,
            wibox.layout.margin(s.mylayoutbox, 6, 12, 6, 6),
        },
    }
end)
-- }}}
local beautiful     = require "beautiful"
local menubar_utils = require "menubar.utils"
-- {{{ Mouse bindings
root.buttons(gears.table.join(
    --~ awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    awful.key({ "Control", "Shift"}, "space",  function () awful.spawn("rofi -config /home/pawelkuzia/.config/rofi/config_awesome.rasi  -show combi") end,
              {description="start rofi", group="awesome"}), 
    awful.key({ "Control", "Shift"}, "f",  function () awful.spawn("rofi -config /home/pawelkuzia/.config/rofi/config_awesome.rasi  -show search") end,
              {description="start rofi", group="awesome"}), 
     --~ awful.key({ "Mod1",           }, "Tab",
      --~ function ()
          --~ switcher.switch( 1, "Mod1", "Alt_L", "Shift", "Tab")
      --~ end),
    
    --~ awful.key({ "Mod1", "Shift"   }, "Tab",
      --~ function ()
          --~ switcher.switch(-1, "Mod1", "Alt_L", "Shift", "Tab")
      --~ end),             
    awful.key({"Mod1"}, "Tab", function () awful.spawn("rofi -show window -theme-str 'window {width: 30%;} listview {lines: 15; dynamic: true;}' -kb-accept-entry '!Alt-Tab,!Alt+Alt_L' -kb-row-down 'Alt+Tab' -selected-row 1 -steal-focus") end,
              {description="window switcher", group="awesome"}),
	--~ awful.key({"Mod1"}, "Tab", function() awesome.emit_signal("bling::window_switcher::turn_on") end, 
			--~ {description = "Window Switcher", group = "bling"}),         
    awful.key({"Mod4", "Shift"}, "s", function () awful.spawn('flameshot gui -s -c -p "/home/pawelkuzia/Pictures/screenshots/"') end,
              {description="flameshot", group="awesome"}),
    awful.key({ modkey,           }, "e",      function () awful.spawn("nemo") end,
              {description="File Explorer", group="launcher"}),
     awful.key({ modkey, "Control", "Shift" }, "p", function () awful.spawn("bash /home/pawelkuzia/Scripts/compfy-switch.sh") end,
        {description = "przesuwaj", group = "client"}),

    awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
              {description="show help", group="awesome"}),
    awful.key({ modkey, "Control" }, "Left",   awful.tag.viewprev,
          {description = "view previous", group = "tag"}),
        awful.key({ modkey,  "Control" }, "Right",  awful.tag.viewnext,
           {description = "view next", group = "tag"}),
    awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
              {description = "go back", group = "tag"}),


    awful.key({ modkey,           }, "Right",
        function ()
            awful.client.focus.byidx( 1)
        end,
        {description = "focus next by index", group = "client"}
    ),
    awful.key({ modkey,           }, "Left",
        function ()
            awful.client.focus.byidx(-1)
        end,
        {description = "focus previous by index", group = "client"}
    ),
    awful.key({ modkey,           }, "w", function () mymainmenu:show() end,
              {description = "show main menu", group = "awesome"}),

    -- Quake Terminal
    awful.key({ Mod1, }, "grave", function () quake:toggle() end),

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
            --~ awful.client.focus.history.previous()
            --~ if client.focus then
                --~ client.focus:raise()
            --~ end
            bling.module.flash_focus.flashfocus(client.focus) 
        end,
        {description = "go back", group = "client"}),

    -- Standard program
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end,
              {description = "open a terminal", group = "launcher"}),
    awful.key({ modkey, "Control" }, "r", awesome.restart,
              {description = "reload awesome", group = "awesome"}),
    awful.key({ modkey, "Shift"   }, "BackSpace", awesome.quit,
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
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
              {description = "select next", group = "layout"}),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
              {description = "select previous", group = "layout"})

--     awful.key({ modkey, "Control" }, "n",
--               function ()
--                   local c = awful.client.restore()
--                   -- Focus restored client
--                   if c then
--                     c:emit_signal(
--                         "request::activate", "key.unminimize", {raise = true}
--                     )
--                   end
--               end,
--               {description = "restore minimized", group = "client"}),

--     -- Prompt
--     awful.key({ modkey },            "r",     function () awful.screen.focused().mypromptbox:run() end,
--               {description = "run prompt", group = "launcher"}),

--     awful.key({ modkey }, "x",
--               function ()
--                   awful.prompt.run {
--                     prompt       = "Run Lua code: ",
--                     textbox      = awful.screen.focused().mypromptbox.widget,
--                     exe_callback = awful.util.eval,
--                     history_path = awful.util.get_cache_dir() .. "/history_eval"
--                   }
--               end,
--               {description = "lua execute prompt", group = "awesome"}),
--     -- Menubar
--     awful.key({ modkey }, "p", function() menubar.show() end,
--               {description = "show the menubar", group = "launcher"})
)

clientkeys = gears.table.join(
    awful.key({ modkey,           }, "f",
        function (c)
            c.fullscreen = not c.fullscreen
            c:raise()
        end,
        {description = "toggle fullscreen", group = "client"}),
    awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
              {description = "close", group = "client"}),
    awful.key({ modkey }, "v",  awful.client.floating.toggle                     ,
              {description = "toggle floating", group = "client"}),
    awful.key({ modkey, "Control", "Shift" }, "w", function (c) c:swap(awful.client.getmaster()) end,
              {description = "move to master", group = "client"}),
    awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
              {description = "move to screen", group = "client"}),
    awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
              {description = "toggle keep on top", group = "client"}),
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
        
        
-- -- Pseudo Tiling Pana Pawełka        
--      awful.key({ modkey, "Control", "Shift" }, "w", function (c) c:geometry({x = 2037, y = 41, width = 1920, height = 2101}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "s", function (c) c:geometry({x = 2037, y = 41, width = 1920, height = 1080}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "x", function (c) c:geometry({x = 2037, y = 1136, width = 1920, height = 1006}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "q", function (c) c:geometry({x = 1089, y = 41, width = 933, height = 2101}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "a", function (c) c:geometry({x = 1089, y = 41, width = 933, height = 1041}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "z", function (c) c:geometry({x = 1089, y = 1097, width = 933, height = 1045}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "d", function (c) c:geometry({x = 3972, y = 41, width = 933, height = 1041}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "c", function (c) c:geometry({x = 3972, y = 1097, width = 933, height = 1045}) end,
--         {description = "przesuwaj", group = "client"}),
--      awful.key({ modkey, "Control", "Shift" }, "e", function (c) c:geometry({x = 3972, y = 41, width = 933, height = 2101}) end,
--         {description = "przesuwaj", group = "client"})
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
                  {description = "toggle focused client on tag #" .. i, group = "tag"})
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
    end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

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
--                     screen = awful.screen.preferred,
                     screen = 1,
--                     placement = awful.placement.no_overlap+awful.placement.no_offscreen
                    placement = awful.placement.centered+awful.placement.no_offscreen
     }
    },

    -- Floating clients.
    { rule_any = {
        instance = {
          "DTA",  -- Firefox addon DownThemAll.
          "copyq",  -- Includes session name in class.
          "pinentry",
        },
        class = {
          "Arandr",
          "Blueman-manager",
          "Gpick",
          "Kruler",
          "MessageWin",  -- kalarm.
          "Sxiv",
          "Tor Browser", -- Needs a fixed window size to avoid fingerprinting by screen size.
          "Wpa_gui",
          "veromix",
          "xtightvncviewer"},

        -- Note that the name property shown in xprop might be set slightly after creation of the client
        -- and the name shown there might not match defined rules here.
        name = {
          "Event Tester",  -- xev.
        },
        role = {
          "AlarmWindow",  -- Thunderbird's calendar.
          "ConfigManager",  -- Thunderbird's about:config.
          "pop-up",       -- e.g. Google Chrome's (detached) Developer Tools.
        }
      }, properties = { floating = true }},

    -- Add titlebars to normal clients and dialogs
    { rule_any = {type = { "normal", "dialog" }
      }, properties = { titlebars_enabled = false,
--                        placement = awful.placement.center, 
                        }
    },

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- { rule = { class = "Firefox" },
    --   properties = { screen = 1, tag = "2" } },
    { rule_any = { class = { "FFPWA-01H8C8XZH1X1HBPHWAW5P10GFW", "FFPWA-01H8C5YNJM7E2K5PWYN5HSDVWE", "Caprine" } },
      properties = { screen = 3, tag = "im" } },
 --   { rule = { class = "FFPWA-01H8C5YNJM7E2K5PWYN5HSDVWE" },
 --     properties = { screen = 3, tag = "im" } },
 --   { rule = { class = "Caprine" },
 --     properties = { screen = 3, tag = "im" } },
    { rule = { class = "obs" },
      properties = { screen = 2, tag = "obs" } },   
    { rule = { class = "steam" },
      properties = { screen = 1, tag = "game" } },   
    { rule = { class = "Lutris" },
      properties = { screen = 1, tag = "game" } },
    { rule = { class = "steam_app_*" },

       properties = { 
        new_tag = {
          name     = "fullscreen", -- The tag name.
          layout   = awful.layout.suit.max.fullscreen, -- Set the tag layout.
          volatile = true, -- Remove the tag when the client is closed.
      },
        screen = 1,
        tag = "fullscreen" 
    } 
    }, 
    { rule = { instance = "Mail" },
      properties = { screen = 2, tag = "mail" } },     
    { rule = { instance = "Navigator" },
      properties = { screen = 1, tag = "main", x = 2037, y = 41, width = 1920, height = 2101 } },    
    { rule = { instance = "youtube-music-desktop-app" },
      properties = { screen = 1, tag = "main", x = 3969, y = 1094, width = 933, height = 1045 } },
    { rule = { instance = "albert" },
      properties = { border_width = 0 } },      
     


}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function (c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
 if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Add a titlebar if titlebars_enabled is set to true in the rules.
client.connect_signal("request::titlebars", function(c)
    -- buttons for the titlebar
    local buttons = gears.table.join(
        awful.button({ }, 1, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
            awful.mouse.client.move(c)
        end),
        awful.button({ }, 3, function()
            c:emit_signal("request::activate", "titlebar", {raise = true})
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

-- Rounded Corners

--~ local function set_good_corners(c)
    --~ if c.fullscreen then
      --~ c.shape = gears.shape.rectangle
    --~ else
        --~ c.shape = function(cr, w, h)
            --~ gears.shape.rounded_rect(cr, w, h, 12)
        --~ end
    --~ end
--~ end

--~ client.connect_signal("manage", function (c) set_good_corners(c) end)

--~ client.connect_signal("property::fullscreen", function(c) set_good_corners(c) end)

--~ client.connect_signal("property::maximized", function(c) set_good_corners(c) end)



client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

--~ local geo = screen[1].geometry
--~ local new_width = math.ceil(geo.width/2)
--~ local new_width2 = geo.width - new_width
--~ screen[1]:fake_resize(geo.x, geo.y, new_width, geo.height)
--~ screen.fake_add(geo.x + new_width, geo.y, new_width2, geo.height)

-- Switcher Theme
    --~ switcher.settings.preview_box = true                                 -- display preview-box
    --~ switcher.settings.preview_box_bg = "#333333"                       -- background color
    --~ switcher.settings.preview_box_border = "#FB8C00"                   -- border-color
    --~ switcher.settings.preview_box_fps = 30                               -- refresh framerate
    --~ switcher.settings.preview_box_delay = 150                            -- delay in ms
    --~ switcher.settings.preview_box_title_font = {"sans","italic","normal"}-- the font for cairo
    --~ switcher.settings.preview_box_title_font_size_factor = 1           -- the font sizing factor
    --~ switcher.settings.preview_box_title_color = {10,10,10,50}                -- the font color
    
    --~ switcher.settings.client_opacity = false                             -- opacity for unselected clientsc
    --~ switcher.settings.client_opacity_value = 0.85                         -- alpha-value for any client
    --~ switcher.settings.client_opacity_value_in_focus = 0.85                -- alpha-value for the client currently in focus
    --~ switcher.settings.client_opacity_value_selected = 1                  -- alpha-value for the selected client

    --~ switcher.settings.cycle_raise_client = true                          -- raise clients on cycle
    --~ switcher.settings.cycle_all_clients  = false                          -- cycle through all clients

awesome.set_preferred_icon_size(128)
-- Autorun programs
autorun = true
autorunApps =
{
   "nitrogen --restore",
 --  "picom",
   "blueman-applet",
   "nm-applet",
   "goxlr-daemon",
   "lxsession",
--   "compfy --daemon",
    "sh /home/pawelkuzia/.screenlayout/PLP.sh"
}
if autorun then
   for app = 1, #autorunApps do
       awful.util.spawn(autorunApps[app])
   end
end


