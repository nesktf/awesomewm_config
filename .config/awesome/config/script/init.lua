local awful     = require('awful')
local beautiful = require('beautiful')

local osd     = require('widget.osd')
local globals = require('config.globals')

local function __run(cmd, callback)
  local path = globals.path.script.."/"..cmd
  awful.spawn.easy_async_with_shell(path, function(stdout, stderr)
    callback(stdout, stderr)
  end)
end

local _M = {}

function _M.toggle_crt()
  local host = globals.env.host
  if (host ~= "compy") then return end
  
  __run("toggle_screen.sh", function(stdout,_)
    osd.text{
      screen = awful.screen.focused(),
      text   = stdout,
      icon   = beautiful.volume_high,
    }
  end)
end

return _M
