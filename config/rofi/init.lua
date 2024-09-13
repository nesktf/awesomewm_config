local globals = require('config.globals')

local _M = {}

function _M.drun_cmd()
  local config = globals.path.config
  return "rofi -config \""..config.."/rofi/config.rasi\" -show drun"
end

return _M
