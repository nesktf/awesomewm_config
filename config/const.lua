local home_dir = os.getenv("HOME")
local config_dir = home_dir.. "/.config/awesome"

local globals = {
  path = {
    awesome_dir = config_dir,
    theme_dir   = config_dir .. "/theme",
    home_dir    = home_dir
  },

  keys = {
    mod = "Mod4",
    alt = "Mod1",
  },
}

return globals
