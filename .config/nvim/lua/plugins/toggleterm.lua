local _M = {}

function _M.config()
  require("toggleterm").setup {
    size = function(term)
      if (term.direction == "horizontal") then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.5
      end
    end,
    hide_numbers = true,
    autochdir = true,
  }
end

return _M
