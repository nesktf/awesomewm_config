local awful   = require('awful')
local globals = require('config.globals')

local _M = {}

_M.terminal = function() 
  awful.spawn(globals.env.term)
end

_M.files = function()
  awful.spawn("pcmanfm-qt")
end

_M.browser_main = function() 
  awful.spawn("librewolf")
end

_M.browser_work = function()
  local home = globals.path.home
  awful.spawn("librewolf --profile \""..home.."/.librewolf/80zhfr50.work/\"")
end

_M.freetube = function()
  awful.spawn("freetube")
end

_M.rofi_drun = function()
  local config = globals.path.config
  local cmd = "rofi -config \""..config.."/rofi/config.rasi\" -show drun"
  awful.spawn(cmd)
end

_M.lutris = function()
  awful.spawn("flatpak run net.lutris.Lutris")
end

return _M
