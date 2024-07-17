local awful = require('awful')
local gears = require('gears')
local client = client

local mod = require('config.globals').keys.mod

local _M = {
  tags    = nil,
  layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.corner.nw,
  }
}

function _M:init(tags)
  self.tags = tags
  awful.layout.layouts = self.layouts
end

function _M:create_bindings()
  assert(self.tags ~= nil)
  local binds = {}

  for i, tag_name in ipairs(self.tags) do
    local key_id = "#"..i+9

    binds = gears.table.join(binds,
      -- View tag only.
      awful.key({ mod }, key_id,
        function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if (tag) then
            tag:view_only()
          end
        end,
        {description = 'view tag "'..tag_name..'"', group = "tag"}
      ),
      -- Toggle tag display.
      awful.key({ mod, "Control" }, key_id,
        function()
          local screen = awful.screen.focused()
          local tag = screen.tags[i]
          if (tag) then
            awful.tag.viewtoggle(tag)
          end
        end,
        {description = 'toggle tag "'..tag_name..'"', group = "tag"}
      ),
      -- Move client to tag.
      awful.key({ mod, "Shift" }, key_id,
        function()
          if (client.focus) then
            local tag = client.focus.screen.tags[i]
            if (tag) then
              client.focus:move_to_tag(tag)
            end
          end
        end,
        {description = 'move focused client to tag "'..tag_name..'"', group = "tag"}
      ),
      -- Toggle tag on focused client.
      awful.key({ mod, "Control", "Shift" }, key_id,
        function()
          if (client.focus) then
            local tag = client.focus.screen.tags[i]
            if (tag) then
              client.focus:toggle_tag(tag)
            end
          end
        end,
        {description = 'toggle focused client on tag "'..tag_name..'"', group = "tag"}
      )
    )
  end

  return binds
end

function _M:setup_for_screen(args)
  assert(self.tags ~= nil)
  assert(args.screen ~= nil)

  local screen   = args.screen
  local floating = args.floating or false
  local selected = args.selected or 1

  for i, tag_name in ipairs(self.tags) do
    awful.tag.add(tag_name, {
      screen   = screen,
      layout   = floating and self.layouts[1] or self.layouts[2],
      selected = (i == selected)
    })
  end
end

return _M
