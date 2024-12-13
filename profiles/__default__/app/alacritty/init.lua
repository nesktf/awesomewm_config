local globals = require('config.globals')

local _M = {}

function _M.cmd()
  local config = globals.path.config
  return "alacritty --config-file ".."\""..config.."/alacritty/alacritty.yml\""
end

return _M
