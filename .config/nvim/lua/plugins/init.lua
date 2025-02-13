local lspconfig = require("plugins.lspconfig")
local gruvbox = require("plugins.gruvbox")
local luasnip = require("plugins.luasnip")
local nvim_autopairs = require("plugins.nvim-autopairs")
local nvim_cmp = require("plugins.nvim-cmp")
local nvim_treesitter = require("plugins.nvim-treesitter")
local telescope = require("plugins.telescope")
local render_markdown = require("plugins.render-markdown")
local toggleterm = require('plugins.toggleterm')

local plugins = {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    opts = {
      terminal_colors = false,
      transparent_mode = true,
      bold = false,
      overrides = gruvbox.overrides,
    },
    init = function()
      vim.cmd [[colorscheme gruvbox]]
    end,
  },

  {
    "neovim/nvim-lspconfig",
    lazy = false,
    event = "User FilePost",
    config = lspconfig.config,
  },

  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    cmd = { "NvimTreeToggle", "NvimTreeFocus" },
    opts = {
      view = {
        signcolumn = "no",
      },
      git = {
        enable = true,
      },
      renderer = {
        highlight_git = true,
        icons = {
          show = {
            git = true,
          },
        },
        root_folder_label = false,
      },
      filters = {
        enable = true,
        git_ignored = true,
        dotfiles = true,
        custom = { "^.git$" },
      },
    },
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = { 
      {
        "L3MON4D3/LuaSnip",
        dependencies = { "rafamadriz/friendly-snippets" },
        opts = {
          history = true,
          updateevents = "TextChanged,TextChangedI"
        },
        config = luasnip.config,
      },
      {
        "windwp/nvim-autopairs",
        opts = {
          fast_wrap = {},
          disable_filetype = { "TelescopePrompt", "vim" },
        },
        config = nvim_autopairs.config,
      },
      {
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        "hrsh7th/cmp-nvim-lua",
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-cmdline",
      },
    },
    config = nvim_cmp.config,
  },

  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    tag = "0.1.8",
    config = telescope.config,
  },

  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      options = {
        theme = "gruvbox",
        globalstatus = true,
      },
    }
  },

  {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {},
  },

  -- {
  --   "NvChad/nvterm",
  --   opts = {},
  -- },

  {
    "akinsho/toggleterm.nvim",
    config = toggleterm.config,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    config = nvim_treesitter.config,
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
    cmd = "WhichKey",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    keys = {
      { "gcc", mode = "n", desc = "Comment toggle current line" },
      { "gc", mode = { "n", "o" }, desc = "Comment toggle linewise" },
      { "gc", mode = "x", desc = "Comment toggle linewise (visual)" },
      { "gbc", mode = "n", desc = "Comment toggle current block" },
      { "gb", mode = { "n", "o" }, desc = "Comment toggle blockwise" },
      { "gb", mode = "x", desc = "Comment toggle blockwise (visual)" },
    },
    opts = {},
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    version = "2.20.7",
    opts = {
      indentLine_enabled = 1,
      filetype_exclude = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "nvdash",
        "nvcheatsheet",
        "",
      },
      buftype_exclude = { "terminal" },
      show_trailing_blankline_indent = true,
      show_first_indent_level = false,
      show_current_context = true,
      show_current_context_start = true,
    },
  },

  {
    "lewis6991/gitsigns.nvim",
    opts = {
      signs = {
        add = { text = "│" },
        change = { text = "│" },
        delete = { text = "󰍵" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "│" },
      },
    },
  },

  {
    "filipdutescu/renamer.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  {
    "norcalli/nvim-colorizer.lua",
    opts = {},
  },

  {
    "iamcco/markdown-preview.nvim",
    lazy = false,
    build = "cd app & npm install",
    ft = { "markdown" },
    config = function()
      vim.g.mkd_filetypes = { "markdown" }
      vim.g.mkdp_browser = "librewolf"
      vim.g.mkdp_page_title = "markdown-preview"
      vim.g.mkdp_auto_close = 0
    end,
  },

  {
    "andweeb/presence.nvim",
    lazy = false,
    opts = {
      auto_update = true,
      show_time = true,
    }
  },

  {
    "tpope/vim-fugitive",
  },

  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' },
    config = render_markdown.config,
    -- opts = {},
  },
  {
    "Badhi/nvim-treesitter-cpp-tools",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = function()
      local options = {
        preview = {
          quit = "q", -- optional keymapping for quit preview
          accept = "<tab>", -- optional keymapping for accept preview
        },
        header_extension = "h", -- optional
        source_extension = "cpp", -- optional
        custom_define_class_function_commands = { -- optional
          TSCppImplWrite = {
            output_handle = require("nt-cpp-tools.output_handlers").get_add_to_cpp(),
          },
          --[[
          <your impl function custom command name> = {
              output_handle = function (str, context) 
                  -- string contains the class implementation
                  -- do whatever you want to do with it
              end
          }
          ]]
        },
      }
      return options
    end,
    config = true,
  },
}

return {
  load = function()
    local lazy_path = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
    if not (vim.uv or vim.loop).fs_stat(lazy_path) then
      local lazy_repo = "https://github.com/folke/lazy.nvim.git"
      vim.fn.system{"git", "clone", "--filter=blob:none", "--branch=stable", lazy_repo, lazy_path}
    end
    vim.opt.rtp:prepend(lazy_path)

    require("lazy").setup(plugins, {
      checker = {
        enabled = false
      },
    })
  end
}

