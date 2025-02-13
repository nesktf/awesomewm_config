local _M = {}

function _M.config()
  local luasnip = require("luasnip")
  local cmp = require("cmp")

  local function tab_map(fallback)
    if (cmp.visible()) then
      cmp.select_next_item()
    elseif (luasnip.expand_or_jumpable()) then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-expand-or-jump", true, true, true), "")
    else
      fallback()
    end
  end

  local function tab_map_alt(fallback)
    if (cmp.visible()) then
      cmp.select_prev_item()
    elseif (luasnip.jumpable(-1)) then
      vim.fn.feedkeys(vim.api.nvim_replace_termcodes("<Plug>luasnip-jump-prev", true, true, true), "")
    else
      fallback()
    end
  end

  local function lsp_expand(args)
    luasnip.lsp_expand(args.body) 
  end

  vim.opt.completeopt = { "menu", "menuone", "noselect" }

  cmp.setup {
    sources = cmp.config.sources {
      { name = "nvim_lsp" },
      { name = "nvim_lua" },
      { name = "buffer" },
      { name = "luasnip" },
      { name = "path" },
    },
    snippet = { expand = lsp_expand },
    mapping = {
      ["<C-p>"] = cmp.mapping.select_prev_item(),
      ["<C-n>"] = cmp.mapping.select_prev_item(),
      ["<C-d>"] = cmp.mapping.scroll_docs(-4),
      ["<C-f>"] = cmp.mapping.scroll_docs(4),
      ["<C-Space>"] = cmp.mapping.complete(),
      ["<C-e>"] = cmp.mapping.close(),
      ["<CR>"] = cmp.mapping.confirm {
        -- behavior = cmp.ConfirmBehavior.Insert,
        -- select = true,
      },
      ["<Tab>"] = cmp.mapping(tab_map, { "i", "s" }),
      ["<S-Tab>"] = cmp.mapping(tab_map_alt, { "i", "s" }),
    },
  }

  cmp.setup.cmdline(":", {
    mapping = cmp.mapping.preset.cmdline(),
    sources = cmp.config.sources {
      { name = "buffer" },
      { name = "path" },
      { name = "cmdline" },
    }
  })
end

return _M
