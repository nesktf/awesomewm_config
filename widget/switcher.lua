local awful = require("awful")
local gears = require("gears")
local naughty = require("naughty")
local beautiful = require('beautiful')
local wibox = require("wibox")
local client = client

local alt_mod = require('config.globals').keys.alt

local function same_client_table(t1, t2)
  local function table_len(t)
    local c = 0
    for _ in pairs(t) do c = c + 1 end
    return c
  end

  local len1 = table_len(t1)
  if (len1 ~= table_len(t2)) then
    return false
  end

  for i = 1, len1 do
    if (t1[i].name ~= t2[i].name) then
      return false
    end
  end

  return true
end

local function get_clients(screen, stag) 
  local clients = {}

  local function in_table(element, t)
    for _, obj in ipairs(t) do
      if (element == obj) then
        return true
      end
    end
    return false
  end

  --get focused clients
  local i = 0
  local last_focused = awful.client.focus.history.get(screen, i)
  while (last_focused ~= nil) do
    table.insert(clients, last_focused)
    i = i + 1
    last_focused = awful.client.focus.history.get(screen, i)
  end

  -- get minimized clients
  for _, c in ipairs (client.get(screen)) do
    if (in_table(stag, c:tags()) and not in_table(c, clients)) then
      table.insert(clients, c)
    end
  end

  return clients
end

local preview = {
  wibox = wibox{
    ontop = true,
    visible = false,
    bg = beautiful.titlebar_bg_focus
  },
  client_table = {},
  focused_index = 1,
}

function preview:focused_client()
  return self.client_table[self.focused_index]
end

function preview:hide()
  self.wibox.visible = false
end

function preview:show()
  local geom = awful.screen.focused().geometry
  self.wibox:geometry {
    x = geom.x,
    y = geom.y,
    width = geom.width*0.25,
    height = geom.width*0.25,
  }
  self.wibox.visible = true
  local focused = self:focused_client()
  local content = wibox.widget {
    layout = wibox.layout.fixed.horizontal,
    {
      widget = wibox.widget.textbox,
      text = focused.name,
    }
  }
  self.wibox:set_widget(content)
end

function preview:cycle(dir)
  local ccount = #self.client_table
  local new_index = self.focused_index + dir
  self.focused_index = 
    new_index > ccount and 1 
    or new_index < 1 and ccount 
    or new_index

  self:show()
end

function preview:populate(screen)
  local stag = screen.selected_tag
  self.client_table = get_clients(screen, stag)
end

local _M = {}

function _M.switch(dir)
  local screen = awful.screen.focused()
  preview:populate(screen)

  if (#preview.client_table == 0) then
    return
  end

  awful.keygrabber.run(function(modifiers, key, event)
    if (not gears.table.hasitem(modifiers, alt_mod)) then
      return
    end

    local alt_key = "Alt_L" -- key instead of modifier
    if (key == alt_key and event == "release") then
      preview:hide()

      local focused = preview:focused_client()
      focused.minimized = false
      focused:raise()
      focused:jump_to()
      client.focus = focused

      awful.keygrabber.stop()
    elseif (key == "Tab" and event == "press") then
      if (gears.table.hasitem(modifiers, "Shift")) then
        preview:cycle(-1)
      else
        preview:cycle(1)
      end
    end
  end)

  preview:cycle(dir)
end

return _M
