local awful   = require('awful')
local naughty = require('naughty')

local globals = require('config.globals')

local _M = {}

function _M.cmd()
  local host = globals.env.host
  local config = globals.path.config

  local cmd = "picom -b --config "
  if (host == "compy") then
    return cmd.."\""..config.."/picom/compy.conf\""
  elseif (host == "nobus") then
    return cmd.."\""..config.."/picom/nobus.conf\""
  end
end

function _M.toggle()
  local cmd = "((pgrep -x picom || pgrep -x -f picom) && killall picom) || " .. _M.cmd()
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
