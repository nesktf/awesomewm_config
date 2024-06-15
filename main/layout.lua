local awful = require('awful')

local _M = {}

_M.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  -- awful.layout.suit.tile.left,
  -- awful.layout.suit.tile.bottom,
  -- awful.layout.suit.tile.top,
  awful.layout.suit.fair,
  -- awful.layout.suit.fair.horizontal,
  awful.layout.suit.spiral,
  -- awful.layout.suit.spiral.dwindle,
  -- awful.layout.suit.max,
  -- awful.layout.suit.max.fullscreen,
  -- awful.layout.suit.magnifier,
  -- awful.layout.suit.corner.nw,
}

_M.setup = function(_, args)
  assert(args.screen ~= nil)
  local screen    = args.screen
  local floating  = args.floating or true
  local tag_count = args.tag_count or 4

  for i = 1, tag_count do
    awful.tag.add(tostring(i), {
      screen   = screen,
      layout   = floating and _M.layouts[1] or _M.layouts[2],
      selected = (i == 1)
    })
  end
end

return _M
