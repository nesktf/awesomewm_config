local util = require("util")
local default_profile = require("profiles.__default__")

local config = util.require_opt("profiles.%s"..io.popen("uname -n"):read())
if (not config or not default_profile.validate_config(config)) then
  config = default_profile.make_config()
end

local _M = {
  get = function() return config end,
  mt = { __index = config }
}

return setmetatable(_M, _M.mt)
