local awful = require('awful')
local gears = require('gears')
local cutil = require("client.util")

local cgkeys = require('config.globals').keys
local mod  = cgkeys.mod

local _M = {}

_M.layouts = {
  awful.layout.suit.floating,
  awful.layout.suit.tile,
  awful.layout.suit.tile.bottom,
  awful.layout.suit.fair,
  awful.layout.suit.spiral,
  awful.layout.suit.max,
  awful.layout.suit.magnifier,
}

_M.tags = {
  { name = "dev",   layout = 2 },
  { name = "web",   layout = 2 },
  { name = "docs",  layout = 2 },
  { name = "gaems", layout = 1 },
  { name = "media", layout = 1 },
}

_M.signals = {
  {
    id = "property::layout",
    callback = function(t)
      local clients = t:clients()
      for _,c in pairs(clients) do
        cutil.update_titlebar(c)
      end
    end,
  },
  {
    id = "property::selected",
    callback = function(t)
      if (not t.screen) then
        return
      end
      if (t.screen.panel) then
        t.screen.panel:set_floating(t.maximized_count == 0)
      end
    end
  },
}

_M.keys = (function()
  local binds = {}
  for i, curr_tag in ipairs(_M.tags) do
    local tag_name = curr_tag.name
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
      -- awful.key({ mod, "Control" }, key_id,
      --   function()
      --     local screen = awful.screen.focused()
      --     local tag = screen.tags[i]
      --     if (tag) then
      --       awful.tag.viewtoggle(tag)
      --     end
      --   end,
      --   {description = 'toggle tag "'..tag_name..'"', group = "tag"}
      -- ),
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
end)()

return _M
