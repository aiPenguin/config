-- Standard awesome library
local awful = require("awful")
-- Declarative object management
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Theme handling library
local beautiful = require("beautiful")

local vars = require("configuration.variable")

-- {{{ Menu
-- @DOC_MENU@
-- Create a launcher widget and a main menu
local myawesomemenu = {
	{
		"hotkeys",
		function()
			hotkeys_popup.show_help(nil, awful.screen.focused())
		end,
	},
	{ "manual", vars.terminal .. " -e man awesome" },
	{ "edit config", vars.editor_cmd .. " " .. awesome.conffile },
	{ "restart", awesome.restart },
	{
		"quit",
		function()
			awesome.quit()
		end,
	},
}

-- Menubar configuration
menubar.utils.terminal = vars.terminal -- Set the terminal for applications that require it

local _M = {
	mymainmenu = awful.menu({
		items = {
			{ "awesome", myawesomemenu, beautiful.awesome_icon },
			{ "open terminal", vars.terminal },
		},
	}),
}
_M.mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = _M.mymainmenu })

-- }}}

return _M
