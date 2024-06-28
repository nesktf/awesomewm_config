local home_dir    = os.getenv("HOME")
local hostname    = io.popen("uname -n"):read()
local awesome_dir = home_dir.. "/.config/awesome"

local _M = {}

_M.path = {
  awesome = awesome_dir,
  themes  = awesome_dir .. "/themes",
  config  = awesome_dir .. "/config",
  home    = home_dir,
}

_M.env = {
  host  = hostname,
  shell = "bash",
  term  = hostname == "compy" and "konsole" or "alacritty",
}

_M.keys = {
  mod = "Mod4",
  alt = "Mod1",
}

return _M
