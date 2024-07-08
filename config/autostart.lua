local awful = require('awful')
local picom = require('config.picom')

local _M = {}

local _on_init = {
  picom.get_cmd(),
  "nm-applet",
  "kdeconnect-indicator",
  "copyq",
  "polkit-dumb-agent"
}

local _on_reload = {
  'setxkbmap es',
  'xinput set-prop "USB OPTICAL MOUSE " "libinput Accel Profile Enabled" 0 1'
}

_M.on_startup = function()
  for _, cmd in ipairs(_on_init) do
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    -- naughty.notification{
    --   message=string.format('pgrep -x %s &>/dev/null || pgrep -x -f %s >/dev/null || %s', findme, findme, cmd),
    --   timeout = 20,
    -- }
    awful.spawn.easy_async_with_shell(
      string.format('pgrep -x %s &>/dev/null || pgrep -x -f %s >/dev/null || %s', findme, findme, cmd),
      function(_, stderr)
        -- Debugger if not stderr or stderr == '' or not debug_mode then
        if not stderr or stderr == '' then return end

        -- naughty.notification({
        --   app_name = 'Start-up Applications',
        --   title = '<b>Oof! Error detected when starting an application!</b>',
        --   message = stderr:gsub('%\n', ''),
        --   timeout = 20,
        --   icon = require('beautiful').awesome_icon
        -- })
      end
    )
  end
end

_M.on_reload = function()
  for _, cmd in ipairs(_on_reload) do
    awful.spawn.easy_async_with_shell(cmd)
  end
end

return _M
