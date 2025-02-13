local mappings = require("mappings")

local function config()
  local lsp = require("lspconfig")
  local capabilities = vim.lsp.protocol.make_client_capabilities()

  vim.lsp.set_log_level('off')
  require('vim.lsp.log').set_format_func(vim.inspect)

  vim.diagnostic.config {
    signs = true,
    underline = true,
    update_in_insert = false,
  }

  capabilities.textDocument.completion.CompletionItem = {
    documentationFormat = { "markdown", "plaintext" },
    snippetSupport = true,
    preselectSupport = true,
    insertReplaceSupport = true,
    deprecatedSupport = true,
    comitCharactersSupport = true,
    tagSupport = { valuseSet = { 1 } },
    resolveSuport = {
      properties = {
        "documentation",
        "detail",
        "additionalTextEdits",
      }
    }
  }

  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  capabilities.offsetEncoding = { "utf-16" }

  local function on_attach(client, bufnr)
    -- client.server_capabilities.semanticTokensProvider = nil
    vim.api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
    mappings.apply_lsp(bufnr, client)
  end

  lsp["clangd"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = {
      "/usr/bin/clangd",
      "--background-index=false",
      "--completion-style=detailed",
      -- "--clang-tidy",
    },
    filetypes = { "c", "h", "cpp", "hpp", "inl", "tpp" },
  }

  lsp["lua_ls"].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    cmd = { "/sdr/software/_root/bin/lua-language-server" },
    on_init = function(client)
      if (client.workspace_folders == nil) then
        return
      end
      local workspace = client.workspace_folders[1]
      if (workspace.name and vim.loop.fs_stat(workspace.name.."/.luarc.json")) then
        return
      end
    end,
  }
end

return {
  config = config
}
