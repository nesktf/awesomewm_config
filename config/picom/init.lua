local awful   = require('awful')
local naughty = require('naughty')

local picom = require('main.globals').cmd.picom

local _M = {}

_M.toggle_picom = function()
  local cmd = "((pgrep -x picom || pgrep -x -f picom) && killall picom) || " .. picom
  awful.spawn.easy_async_with_shell(cmd, function(stdin, _)
    local msg
    if (stdin == "") then
      msg = "Composition enabled"
    else
      msg = "Composition disabled"
    end
    naughty.notify({
      title = "picom",
      text = msg,
      timeout = 2,
    })
  end)
end

return _M
