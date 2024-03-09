local awful = require('awful')

local awesome_dir = "~/.config/awesome"
local script_dir = awesome_dir .. "/util"

awful.spawn.with_shell(script_dir .. "/autorun.sh")
