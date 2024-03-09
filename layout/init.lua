local awful = require('awful')

local panel = require('layout.panel')


-- Enabled Layouts
tag.connect_signal("request::default_layouts",
  function()
    awful.layout.append_default_layouts({
    awful.layout.suit.tile.left,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.tile.top,
    awful.layout.suit.floating,
    awful.layout.suit.fair,
    awful.layout.suit.fair.horizontal,
    awful.layout.suit.spiral,
    awful.layout.suit.spiral.dwindle,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
    awful.layout.suit.corner.nw,
    })
  end
)

screen.connect_signal("request::desktop_decoration",
  function(s)
    s.panel = panel(s)
  end
)

