-------------------------------------------------
-- Libraries
-------------------------------------------------
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
local beautiful = require("beautiful")
local naughty = require("naughty")
local wibox = require("wibox")
local menubar = require("menubar")


-------------------------------------------------
-- Theme
-------------------------------------------------
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

beautiful.titlebar_bg_normal = "#1a1a1a"
beautiful.titlebar_bg_focus  = "#0f172a"
beautiful.titlebar_fg_normal = "#707880"
beautiful.titlebar_fg_focus  = "#e5e7eb"
beautiful.titlebar_font      = "JetBrainsMono Nerd Font Bold 10"

beautiful.border_normal = "#1e1e2e"
beautiful.border_focus  = "#fab387"
beautiful.border_width  = 2


-------------------------------------------------
-- Error Handling
-------------------------------------------------
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical, title = "Startup Errors", text = awesome.startup_errors })
end

do
    local in_error = false
    awesome.connect_signal("debug::error", function (err)
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical, title = "Runtime Error", text = tostring(err) })
        in_error = false
    end)
end


-------------------------------------------------
-- User Configuration
-------------------------------------------------
terminal = "kitty"
editor = os.getenv("EDITOR") or "nano"
editor_cmd = terminal .. " -e " .. editor
modkey = "Mod4"


-------------------------------------------------
-- Layouts
-------------------------------------------------
awful.layout.layouts = {
    awful.layout.suit.tile,
}


-------------------------------------------------
-- Screens & Tags
-------------------------------------------------
awful.screen.connect_for_each_screen(function(s)
    awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9", "10" }, s, awful.layout.layouts[1])
end)


-------------------------------------------------
-- Global Keybindings
-------------------------------------------------
globalkeys = gears.table.join(
    awful.key({ modkey,           }, "Return", function () awful.spawn(terminal) end),
    awful.key({ modkey, "Shift"   }, "q",      function () if client.focus then client.focus:kill() end end),
    awful.key({ modkey,           }, "w",      function () awful.spawn("firefox") end),
    awful.key({ modkey, "Shift"   }, "e",      function () awesome.quit() end),
    awful.key({ modkey,          }, "l",     function () awful.spawn("bash ~/.config/awesome/lock.sh") end),
    awful.key({ modkey, "Shift"  }, "r",     function () awesome.restart() end),
    awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn("dolphin") end),
    awful.key({ modkey,           }, "f",      function () if client.focus then client.focus.floating = not client.focus.floating end end),
    awful.key({ modkey,           }, "d",      function () awful.spawn("rofi -show drun") end),
    awful.key({ modkey,           }, "Tab",    function () awful.client.focus.history.previous() end),
    awful.key({ modkey, "Shift"   }, "a",      function () awful.spawn("code") end),
    awful.key({                   }, "Print",  function () awful.spawn("scrot -u -d 1 'screen.png'") end),

    awful.key({ modkey,           }, "left",   function () awful.client.focus.bydirection("left") end),
    awful.key({ modkey,           }, "right",  function () awful.client.focus.bydirection("right") end),
    awful.key({ modkey,           }, "up",     function () awful.client.focus.bydirection("up") end),
    awful.key({ modkey,           }, "down",   function () awful.client.focus.bydirection("down") end),

    awful.key({                   }, "XF86AudioRaiseVolume",  function () awful.spawn("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+") end),
    awful.key({                   }, "XF86AudioLowerVolume",  function () awful.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-") end),
    awful.key({                   }, "XF86AudioMute",         function () awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle") end),
    awful.key({                   }, "XF86AudioMicMute",      function () awful.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle") end),
    awful.key({                   }, "XF86MonBrightnessUp",   function () awful.spawn("brightnessctl -e4 -n2 set 5%+") end),
    awful.key({                   }, "XF86MonBrightnessDown", function () awful.spawn("brightnessctl -e4 -n2 set 5%-") end),
    awful.key({                   }, "XF86AudioNext",         function () awful.spawn("playerctl next") end),
    awful.key({                   }, "XF86AudioPause",        function () awful.spawn("playerctl play-pause") end),
    awful.key({                   }, "XF86AudioPlay",         function () awful.spawn("playerctl play-pause") end),
    awful.key({                   }, "XF86AudioPrev",         function () awful.spawn("playerctl previous") end)
)


-------------------------------------------------
-- Tag Keybindings
-------------------------------------------------
for i = 1, 10 do
    local key = tostring(i % 10)
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, key, function ()
            local screen = awful.screen.focused()
            local tag = screen.tags[i]
            if tag then tag:view_only() end
        end),
        awful.key({ modkey, "Shift" }, key, function ()
            if client.focus then
                local tag = client.focus.screen.tags[i]
                if tag then client.focus:move_to_tag(tag) end
            end
        end)
    )
end

root.keys(globalkeys)


-------------------------------------------------
-- Mouse Bindings
-------------------------------------------------
clientbuttons = gears.table.join(
    awful.button({}, 1, function (c) c:emit_signal("request::activate", "mouse_click", { raise = true }) end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", { raise = true })
        awful.mouse.client.resize(c)
    end)
)


-------------------------------------------------
-- Window Rules
-------------------------------------------------
awful.rules.rules = {
    { 
        rule = { }, 
        properties = { 
            border_width = 2, 
            border_color = "#1e1e2e", 
            focus = awful.client.focus.filter, 
            raise = true, 
            screen = awful.screen.preferred, 
            floating = false,
            titlebars_enabled = true,
            buttons = clientbuttons
        } 
    },
    {
        rule = { floating = true },
        properties = {
            placement = awful.placement.no_overlap + awful.placement.no_offscreen
        }
    },
    {
        rule_any = { class = { "firefox", "Firefox" } },
        properties = {
            titlebars_enabled = false
        }
    },
    {
    rule = { class = "spectacle" },
    properties = { 
            floating = true,
            maximized = false,
	    fullscreen = false,
            above = true,
            honor_padding = true,
            honor_workarea = true
    }
    },
    {
        rule = { class = "Polybar" },
        properties = {
            focusable = false,
            dockable = true,
            below = true,
            ontop = false,
            sticky = true,
            titlebars_enabled = false
        }
    }
}


-------------------------------------------------
-- Client Signals
-------------------------------------------------
client.connect_signal("request::titlebars", function(c)
    local buttons = gears.table.join(
        awful.button({}, 1, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.move(c)
        end),
        awful.button({}, 3, function()
            c:emit_signal("request::activate", "titlebar", { raise = true })
            awful.mouse.client.resize(c)
        end)
    )

    local close_btn = wibox.widget {
        text   = "󰅖",
        font   = "JetBrainsMono Nerd Font 12",
        align  = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }
    close_btn.markup = "<span foreground='#707880'>󰅖</span>"

    close_btn:connect_signal("mouse::enter", function()
        close_btn.markup = "<span foreground='#ef4444'>󰅖</span>"
    end)
    close_btn:connect_signal("mouse::leave", function()
        close_btn.markup = "<span foreground='#707880'>󰅖</span>"
    end)
    close_btn:buttons(gears.table.join(
        awful.button({}, 1, function() c:kill() end)
    ))

    -- Sadece uygulama adını (class) göstermek için widget
    local app_name_widget = wibox.widget {
        text   = c.class or "Uygulama",
        font   = "JetBrainsMono Nerd Font Bold 10",
        align  = "center",
        valign = "center",
        widget = wibox.widget.textbox
    }

    local update_title = function()
        app_name_widget.text = c.class or "Uygulama"
    end
    c:connect_signal("property::class", update_title)

    awful.titlebar(c, { size = 26 }) : setup {
        {
            {
                widget = wibox.widget.textbox
            },
            left   = 8,
            widget = wibox.container.margin
        },
        {
            {
                app_name_widget,
                widget = wibox.container.margin
            },
            buttons = buttons,
            layout  = wibox.layout.flex.horizontal
        },
        {
            {
                close_btn,
                left = 8,
                right = 8,
                widget = wibox.container.margin
            },
            layout = wibox.layout.fixed.horizontal()
        },
        layout = wibox.layout.align.horizontal
    }
end)

client.connect_signal("focus", function(c) c.border_color = "#fab387" end)
client.connect_signal("unfocus", function(c) c.border_color = "#1e1e2e" end)

client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", { raise = false })
end)

client.connect_signal("manage", function(c)
    local class = c.class or ""
    if class:lower() == "polybar" then
        c.floating = true
        c.below = true
        c.ontop = false
        c.above = false
        c.sticky = true
        c.focusable = false
        c.skip_taskbar = true
        c:lower()
    end
end)


-------------------------------------------------
-- Autostart
-------------------------------------------------
awful.spawn.with_shell("kdeconnect-cli &")
awful.spawn.with_shell("nm-applet &")
awful.spawn.with_shell("feh --bg-fill ~/Pictures/alice/6.png &")
awful.spawn.with_shell("mako &")
awful.spawn.with_shell("picom &")
awful.spawn.with_shell("blueman-applet &")
awful.spawn.once("polybar -c ~/.config/polybar/config.ini main")
