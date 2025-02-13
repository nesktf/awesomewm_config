local awful = require("awful")
local hostname = io.popen("uname -n"):read()
local home_dir = os.getenv("HOME")
local awesome_dir = home_dir.."/.config/awesome"

local function _make_launcher_binds(launchers)
  if (not launchers) then
    return nil
  end

  local function parse_launcher(launcher)
    local cmd = launcher.cmd
    if (not cmd) then
      return nil 
    end

    if (type(cmd) == "string") then
      return function() awful.spawn(cmd) end
    end

    if (type(cmd) == "function") then
      return cmd
    end

    if (type(cmd) == "table") then
      local mt = getmetatable(cmd)
      if (type(mt) == "table" and type(mt.__call) == "function") then
        return function() cmd() end
      end
    end

    return nil
  end

  local out = {}
  for _, launcher in ipairs(launchers) do
    assert(launcher.mod ~= nil and launcher.key ~= nil and launcher.meta ~= nil)
    local cmd_fun = assert(parse_launcher(launcher))

    table.insert(out, awful.key(launcher.mod, launcher.key, cmd_fun, launcher.meta))
  end

  return out
end

local _base_conf = {}

_base_conf.env = {
  path = {
    home     = home_dir,
    awesome  = awesome_dir,
    themes   = awesome_dir.."/themes",
    profiles = awesome_dir.."/profiles",

    config  = awesome_dir.."/config",
    script  = awesome_dir.."/config/script",
  },
  shell = "bash",
  hostname = hostname,
}

_base_conf.keys = {
  mod   = "Mod4", -- Super
  alt   = "Mod1",
  ctrl  = "Control",
  shift = "Shift",
}

_base_conf.launcher = {
  require("config.rofi"),
  require("config.alacritty"),
  require("config.picom"),
  require("config.librewolf"),
  "dolphin",
}

_base_conf.theme = {
  icon_size = 128,
  font = "Cousine Nerd Font 8",
  icon_theme = "Tela black dark",
  wallpaper = "marisa0",
  beautiful = {}, -- ...
}

_base_conf.signals = {
  tag = {},
  client = {},
}

_base_conf.client = {
  rules = {},
}

_base_conf.wm = {
  layouts = {
    awful.layout.suit.floating,
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.corner.nw,
    awful.layout.suit.max,
    awful.layout.suit.max.fullscreen,
    awful.layout.suit.magnifier,
  },
  tags = { "1", "2", "3", "4", "5" },
  launcher = _make_launcher_binds(_base_conf.launcher),
}

_base_conf.autoinit = {
  _base_conf.launcher.comp.cmd(),
  "kdeconnect-indicator",
  "nm-applet",
  "copyq",
  "polkit-dumb-agent",
  "pasystray",
}

_base_conf.autoreload = {
  "setxkbmap es",
}


local _M = {}

function _M.make_config()
  return setmetatable({}, { __index = _base_conf })
end

function _M.validate_config(conf)
  local mt = getmetatable(conf)
  return mt and mt.__index == _base_conf or false
end

function _M.profile_path(path)
  return string.format("%s/%s/%s",
    _base_conf.env.path.profiles,
    hostname,
    path
  )
end

_M.make_launcher_binds = _make_launcher_binds

return _M
