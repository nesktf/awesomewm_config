local awful   = require('awful')
local gears   = require('gears')

local modkey  = require('main.globals').keys.mod

local layout_bindings = gears.table.join(
  -- Layout manipulation
  awful.key({ modkey, }, "r",
    function ()
      awful.layout.inc(1)
    end,
    {description = "select next layout", group = "layout"}
  ),
  awful.key({ modkey, "Shift"}, "r",
    function ()
      awful.layout.inc(-1)
    end,
    {description = "select previous layout", group = "layout"}
  ),
  awful.key({ modkey, "Control" }, "l",
    function ()
      awful.tag.incmwfact(-0.025)
    end,
    {description = "decrease mater window width factor", group = "layout"}
  ),
  awful.key({ modkey, "Control" }, "h",
    function ()
      awful.tag.incmwfact(0.025)
    end,
    {description = "increase master window width factor", group = "layout"}
  ),
  awful.key({ modkey, "Control" }, "k", 
    function()
      awful.client.incwfact(-0.05)
    end,
    {description = "decrease master window height factor", group = "layout"}
  ),
  awful.key({ modkey, "Control" }, "j", 
    function()
      awful.client.incwfact(0.05)
    end,
    {description = "increase master window height factor", group = "layout"}
  ),

  awful.key({ modkey, "Control" }, "m",
    function ()
      local c = awful.client.restore()
      if c then
        c:emit_signal(
          "request::activate", "key.unminimize", {rause = true}
        )
      end
    end,
    {description = "restore minimized", group = "client"}
  ),

  -- Window focus
  awful.key({ modkey }, "l",
    function ()
      awful.client.focus.bydirection("right", client.focused)
    end,
    {description = "focus the right window", group = "client"}
  ),
  awful.key({ modkey }, "h",
    function ()
      awful.client.focus.bydirection("left", client.focused)
    end,
    {description = "focus the left window", group = "client"}
  ),
  awful.key({ modkey }, "k",
    function ()
      awful.client.focus.bydirection("up", client.focused)
    end,
    {description = "focus the upper window", group = "client" }
  ),
  awful.key({ modkey }, "j",
    function ()
      awful.client.focus.bydirection("down", client.focused)
    end,
    {description = "focus the bottom window", group = "client"}
  ),
  -- Window swap
  awful.key({ modkey, "Shift" }, "l",
    function ()
      awful.client.swap.bydirection("right", client.focus)
    end,
    {description = "swap with the right window", group = "client"}
  ),
  awful.key({ modkey, "Shift" }, "h",
    function ()
      awful.client.swap.bydirection("left", client.focus)
    end,
    {description = "swap with the left window", group = "client"}
  ),
  awful.key({ modkey, "Shift" }, "j",
    function ()
      awful.client.swap.bydirection("down", client.focus)
    end,
    {description = "swap with the bottom window", group = "client"}
  ),
  awful.key({ modkey, "Shift" }, "k",
    function ()
      awful.client.swap.bydirection("up", client.focus)
    end,
    {description = "swap with the upper window", group = "client"}
  ),
  -- Screen manipulation
  awful.key({ modkey }, "Tab", awful.tag.viewnext,
    {description = "change to next screen", group = "tag"}
  ),
  awful.key({ modkey, "Control" }, "Tab", awful.tag.viewprev,
    {description = "change to previous screen", group = "tag"}
  )
)

return layout_bindings
