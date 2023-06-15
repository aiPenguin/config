-- Theme handling library
local beautiful = require("beautiful")

-- {{{ Error handling
require("configuration.error_handling")
-- }}}

-- {{{ Varialble definitions
local vars = require("configuration.variable")
-- }}}

-- {{{ Theme
beautiful.init(vars.theme_path)
-- }}}

-- {{{ Menu
require("configuration.menu")
-- }}}

-- {{{ Tag layout
require("configuration.tag_layout")
-- }}}

-- {{{ Wallpaper
require("configuration.wallpaper")
-- }}}

-- {{{ Wibar
require("configuration.wibar")
-- }}}
--
-- {{{ Mouse bindings
require("configuration.mouse_bindings")
-- }}}
--
-- {{{ Key bindings
require("configuration.key_bindings")
-- }}}
--
-- {{{ Rules
require("configuration.rules")
-- }}}
--
-- {{{ Titlebars
require("configuration.titlebars")
-- }}}
--
-- {{{ Notifications
require("configuration.notifications")
-- }}}
