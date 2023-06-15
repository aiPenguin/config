-- Standard awesome library
local awful = require("awful")
-- Declarative object management
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Theme handling library

local menu = require("configuration.menu")
local vars = require("configuration.variable")

-- {{{ Key bindings
-- @DOC_GLOBAL_KEYBINDINGS@

-- General Awesome keys
awful.keyboard.append_global_keybindings({
	awful.key({ vars.modkey }, "s", hotkeys_popup.show_help, { description = "show help", group = "awesome" }),
	awful.key({ vars.modkey }, "w", function()
		menu.mymainmenu:show()
	end, { description = "show main menu", group = "awesome" }),
	awful.key({ vars.modkey, "Control" }, "r", awesome.restart, { description = "reload awesome", group = "awesome" }),
	awful.key({ vars.modkey, "Shift" }, "q", awesome.quit, { description = "quit awesome", group = "awesome" }),
	awful.key({ vars.modkey }, "x", function()
		awful.prompt.run({
			prompt = "Run Lua code: ",
			textbox = awful.screen.focused().mypromptbox.widget,
			exe_callback = awful.util.eval,
			history_path = awful.util.get_cache_dir() .. "/history_eval",
		})
	end, { description = "lua execute prompt", group = "awesome" }),
	awful.key({ vars.modkey }, "Return", function()
		awful.spawn(vars.terminal)
	end, { description = "open a terminal", group = "launcher" }),
	awful.key({ vars.modkey }, "r", function()
		awful.screen.focused().mypromptbox:run()
	end, { description = "run prompt", group = "launcher" }),
	awful.key({ vars.modkey }, "p", function()
		menubar.show()
	end, { description = "show the menubar", group = "launcher" }),
})

-- Tags related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ vars.modkey }, "Left", awful.tag.viewprev, { description = "view previous", group = "tag" }),
	awful.key({ vars.modkey }, "Right", awful.tag.viewnext, { description = "view next", group = "tag" }),
	awful.key({ vars.modkey }, "Escape", awful.tag.history.restore, { description = "go back", group = "tag" }),
})

-- Focus related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ vars.modkey }, "j", function()
		awful.client.focus.byidx(1)
	end, { description = "focus next by index", group = "client" }),
	awful.key({ vars.modkey }, "k", function()
		awful.client.focus.byidx(-1)
	end, { description = "focus previous by index", group = "client" }),
	awful.key({ vars.modkey }, "Tab", function()
		awful.client.focus.history.previous()
		if client.focus then
			client.focus:raise()
		end
	end, { description = "go back", group = "client" }),
	awful.key({ vars.modkey, "Control" }, "j", function()
		awful.screen.focus_relative(1)
	end, { description = "focus the next screen", group = "screen" }),
	awful.key({ vars.modkey, "Control" }, "k", function()
		awful.screen.focus_relative(-1)
	end, { description = "focus the previous screen", group = "screen" }),
	awful.key({ vars.modkey, "Control" }, "n", function()
		local c = awful.client.restore()
		-- Focus restored client
		if c then
			c:activate({ raise = true, context = "key.unminimize" })
		end
	end, { description = "restore minimized", group = "client" }),
})

-- Layout related keybindings
awful.keyboard.append_global_keybindings({
	awful.key({ vars.modkey, "Shift" }, "j", function()
		awful.client.swap.byidx(1)
	end, { description = "swap with next client by index", group = "client" }),
	awful.key({ vars.modkey, "Shift" }, "k", function()
		awful.client.swap.byidx(-1)
	end, { description = "swap with previous client by index", group = "client" }),
	awful.key(
		{ vars.modkey },
		"u",
		awful.client.urgent.jumpto,
		{ description = "jump to urgent client", group = "client" }
	),
	awful.key({ vars.modkey }, "l", function()
		awful.tag.incmwfact(0.05)
	end, { description = "increase master width factor", group = "layout" }),
	awful.key({ vars.modkey }, "h", function()
		awful.tag.incmwfact(-0.05)
	end, { description = "decrease master width factor", group = "layout" }),
	awful.key({ vars.modkey, "Shift" }, "h", function()
		awful.tag.incnmaster(1, nil, true)
	end, { description = "increase the number of master clients", group = "layout" }),
	awful.key({ vars.modkey, "Shift" }, "l", function()
		awful.tag.incnmaster(-1, nil, true)
	end, { description = "decrease the number of master clients", group = "layout" }),
	awful.key({ vars.modkey, "Control" }, "h", function()
		awful.tag.incncol(1, nil, true)
	end, { description = "increase the number of columns", group = "layout" }),
	awful.key({ vars.modkey, "Control" }, "l", function()
		awful.tag.incncol(-1, nil, true)
	end, { description = "decrease the number of columns", group = "layout" }),
	awful.key({ vars.modkey }, "space", function()
		awful.layout.inc(1)
	end, { description = "select next", group = "layout" }),
	awful.key({ vars.modkey, "Shift" }, "space", function()
		awful.layout.inc(-1)
	end, { description = "select previous", group = "layout" }),
})

-- @DOC_NUMBER_KEYBINDINGS@

awful.keyboard.append_global_keybindings({
	awful.key({
		modifiers = { vars.modkey },
		keygroup = "numrow",
		description = "only view tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				tag:view_only()
			end
		end,
	}),
	awful.key({
		modifiers = { vars.modkey, "Control" },
		keygroup = "numrow",
		description = "toggle tag",
		group = "tag",
		on_press = function(index)
			local screen = awful.screen.focused()
			local tag = screen.tags[index]
			if tag then
				awful.tag.viewtoggle(tag)
			end
		end,
	}),
	awful.key({
		modifiers = { vars.modkey, "Shift" },
		keygroup = "numrow",
		description = "move focused client to tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:move_to_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { vars.modkey, "Control", "Shift" },
		keygroup = "numrow",
		description = "toggle focused client on tag",
		group = "tag",
		on_press = function(index)
			if client.focus then
				local tag = client.focus.screen.tags[index]
				if tag then
					client.focus:toggle_tag(tag)
				end
			end
		end,
	}),
	awful.key({
		modifiers = { vars.modkey },
		keygroup = "numpad",
		description = "select layout directly",
		group = "layout",
		on_press = function(index)
			local t = awful.screen.focused().selected_tag
			if t then
				t.layout = t.layouts[index] or t.layout
			end
		end,
	}),
})

-- @DOC_CLIENT_BUTTONS@
client.connect_signal("request::default_mousebindings", function()
	awful.mouse.append_client_mousebindings({
		awful.button({}, 1, function(c)
			c:activate({ context = "mouse_click" })
		end),
		awful.button({ vars.modkey }, 1, function(c)
			c:activate({ context = "mouse_click", action = "mouse_move" })
		end),
		awful.button({ vars.modkey }, 3, function(c)
			c:activate({ context = "mouse_click", action = "mouse_resize" })
		end),
	})
end)

-- @DOC_CLIENT_KEYBINDINGS@
client.connect_signal("request::default_keybindings", function()
	awful.keyboard.append_client_keybindings({
		awful.key({ vars.modkey }, "f", function(c)
			c.fullscreen = not c.fullscreen
			c:raise()
		end, { description = "toggle fullscreen", group = "client" }),
		awful.key({ vars.modkey, "Shift" }, "c", function(c)
			c:kill()
		end, { description = "close", group = "client" }),
		awful.key(
			{ vars.modkey, "Control" },
			"space",
			awful.client.floating.toggle,
			{ description = "toggle floating", group = "client" }
		),
		awful.key({ vars.modkey, "Control" }, "Return", function(c)
			c:swap(awful.client.getmaster())
		end, { description = "move to master", group = "client" }),
		awful.key({ vars.modkey }, "o", function(c)
			c:move_to_screen()
		end, { description = "move to screen", group = "client" }),
		awful.key({ vars.modkey }, "t", function(c)
			c.ontop = not c.ontop
		end, { description = "toggle keep on top", group = "client" }),
		awful.key({ vars.modkey }, "n", function(c)
			-- The client currently has the input focus, so it cannot be
			-- minimized, since minimized clients can't have the focus.
			c.minimized = true
		end, { description = "minimize", group = "client" }),
		awful.key({ vars.modkey }, "m", function(c)
			c.maximized = not c.maximized
			c:raise()
		end, { description = "(un)maximize", group = "client" }),
		awful.key({ vars.modkey, "Control" }, "m", function(c)
			c.maximized_vertical = not c.maximized_vertical
			c:raise()
		end, { description = "(un)maximize vertically", group = "client" }),
		awful.key({ vars.modkey, "Shift" }, "m", function(c)
			c.maximized_horizontal = not c.maximized_horizontal
			c:raise()
		end, { description = "(un)maximize horizontally", group = "client" }),
	})
end)

-- user added

awful.keyboard.append_global_keybindings({
	awful.key({ vars.modkey }, "d", function()
    awful.spawn("rofi -show-icons -show drun")
	end, { description = "run rofi", group = "launcher" }),
})
-- }}}
