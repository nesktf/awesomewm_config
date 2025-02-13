local awful   = require('awful')
local globals = require('config.globals')
local alacritty = require('config.alacritty')
local rofi = require('config.rofi')

local _M = {}

function _M.terminal()
  awful.spawn(alacritty.cmd())
end

function _M.files()
  awful.spawn("dolphin")
end

function _M.browser_main() 
  awful.spawn("librewolf")
end

function _M.browser_work()
  awful.spawn("librewolf --profile \""..globals.path.home.."/.librewolf/80zhfr50.work/\"")
end

function _M.freetube()
  awful.spawn("freetube")
end

function _M.rofi_drun()
  awful.spawn(rofi.drun_cmd())
end

function _M.lutris()
  awful.spawn("flatpak run net.lutris.Lutris")
end

return _M
