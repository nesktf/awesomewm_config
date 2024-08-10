local globals = require('config.globals')

local _M = {}

function _M.get_cmd()
  local config = globals.path.config
  local cmd = "alacritty --config-file "

  return cmd.."\""..config.."/alacritty/alacritty.yml\""
end

return _M
