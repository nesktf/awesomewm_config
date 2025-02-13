local plugins = require("plugins")
local mappings = require("mappings")

function main()
  local opt = vim.o
  local editor = vim.g

  -- Indentation
  opt.expandtab = true
  opt.smartindent = true
  opt.tabstop = 2
  opt.softtabstop = 2
  opt.shiftwidth = 2
  opt.fillchars = "eob: "
  opt.ignorecase = true
  opt.smartcase = true
  opt.mouse = "a"
  opt.cino = "g0;N-s;j1" -- cpp indents

  -- For nvim-tree
  editor.loaded_netrw = 1
  editor.loaded_netrwPlugin = 1
  opt.termguicolors = true

  -- For which-key
  opt.timeout = true
  opt.timeoutlen = 300

  -- other
  opt.signcolumn = "yes"
  opt.number = true
  opt.numberwidth = 2
  opt.ruler = false
  opt.colorcolumn = "100"
  editor.mapleader = " "
  editor.maplocalleader = "\\"
  opt.clipboard = "unnamedplus"

  -- Filetypes
  vim.filetype.add{
    extension = {
      etlua = 'etlua'
    }
  }

  plugins.load()
  mappings.apply_general()
  require("project").init()
end
