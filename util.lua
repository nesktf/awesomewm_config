local awful     = require('awful')
local gears     = require("gears")
local beautiful = require("beautiful")

local _M = {}

function _M.require_opt(module)
  local succ, m = pcall(require, module)
  return succ and m or nil
end

function _M.call_cmd(cmd, callback)
  awful.spawn.easy_async_with_shell(cmd, function(stdout, stderr) callback(stdout, stderr) end)
end

function _M.apply_pape(screen)
  assert(screen ~= nil)

  local wallpaper = beautiful.wallpaper
  if (wallpaper) then
    if (type(wallpaper) == "function") then
      wallpaper = wallpaper(screen)
    end
    gears.wallpaper.maximized(wallpaper, screen, false)
  end
end

function _M.make_launcher(params)
  local mod = assert(params.mod)
  local key = assert(params.key)
  local launch = params.cmd

  local cmd
  if (type(launch) == "function") then
    cmd = function() awful.spawn(launch) end
  elseif (type(launch) == "function") then
    cmd = launch
  elseif (type(launch) == "table") then
    local mt = getmetatable(launch)
    if (mt.__call and type(mt.__call) == "function") then
      cmd = function() launch() end
    end
  end

  local meta = {
    description = params.description or "no description",
    group = params.group or "ungrouped",
  }
  return awful.key(mod, key, cmd, meta)
end

return _M
