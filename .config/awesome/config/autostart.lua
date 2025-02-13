local awful = require('awful')
local picom = require('config.picom')

local __on_init = {
  picom.cmd(),
  "kdeconnect-indicator",
  "nm-applet",
  "copyq",
  "polkit-dumb-agent",
  "pasystray"
}

local __on_reload = {
  'setxkbmap es',
  'xinput set-prop "USB OPTICAL MOUSE " "libinput Accel Profile Enabled" 0 1'
}

local _M = {}

function _M.trigger()
  for _, cmd in ipairs(__on_init) do
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

  for _, cmd in ipairs(__on_reload) do
    awful.spawn.easy_async_with_shell(cmd)
  end
end

return _M
