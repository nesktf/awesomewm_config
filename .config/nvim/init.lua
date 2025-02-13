pcall(require, "luarocks.loader")
local main = require("main")

if (_G.main ~= nil and type(_G.main) == "function") then
  _G.main()
elseif (main and type(main) == "function") then
  main()
end
