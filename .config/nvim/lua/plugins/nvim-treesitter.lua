local _M = {}

function _M.config()
 require("nvim-treesitter.configs").setup {
    ensure_installed = { "lua", "vim", "vimdoc", "c", "cpp", "bash", "fish", "python", "glsl" },
    highlight = {
      enable = true,
      use_languagetree = true,
    },
    indent = { enable = true },
  } 
end

return _M
