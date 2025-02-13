local kset = vim.keymap.set

local function cmd(str)
  return string.format("<cmd>%s<CR>", str)
end

local function cmdesc(str)
  return string.format('<ESC><cmd>%s<CR>', str)
end

local function apply_general()
  kset('n', '<leader>wk',
    cmd("WhichKey"),
    {noremap=true, silent=true, desc="WhichKey"})

  kset('n', '<tab>',
    cmd("BufferLineCycleNext"), 
    {noremap=true, silent=true, desc="Next buffer"})
  kset('n', '<s-tab>',
    cmd("BufferLineCyclePrev"),
    {noremap=true, silent=true, desc="Previous buffer"})
  kset('n', '<leader>x',
    cmd('bd'),
    {noremap=true, silent=true, desc="Close buffer"})

  kset('n', '<leader>l',
    cmd('tabnext'),
    {noremap=true, silent=true, desc="Next tab"})
  kset('n', '<leader>h',
    cmd('tabprev'),
    {noremap=true, silent=true, desc="Previous tab"})

  kset('n', '<C-n>',
    cmd("NvimTreeToggle"),
    {noremap=true, silent=true, desc="Toggle NvimTree"})

  kset('n', '<leader>/', function()
    require("Comment.api").toggle.linewise.current()
  end, {noremap=true, silent=true, desc="Toggle comment"})
  kset('v', '<leader>/',
    cmdesc("lua require('Comment.api').toggle.linewise(vim.fn.visualmode())"),
    {noremap=true, silent=true,})

  kset('n', '<leader>ff', function()
    require("telescope.builtin").find_files()
  end, {noremap=true, silent=true, desc="Telescope find files"})
  kset('n', '<leader>fg', function()
    require("telescope.builtin").live_grep()
  end, {noremap=true, silent=true, desc="Telescope live grep"})
  kset('n', '<leader>fb', function()
    require("telescope.builtin").buffers()
  end, {noremap=true, silent=true, desc="Telescope find buffer"})
  kset('n', '<leader>fh', function()
    require("telescope.builtin").help_tags()
  end, {noremap=true, silent=true, desc="Telescope help tags"})

  kset('n', '<ESC>',
    cmd("noh"),
    {noremap=true, silent=true, desc="Clear highlights"})

  kset('n', '<C-h>',
    "<C-w>h",
    {noremap=true, silent=true, desc="Left window"})
  kset('n', '<C-l>',
    "<C-w>l",
    {noremap=true, silent=true, desc="Right window"})
  kset('n', '<C-k>',
    "<C-w>k",
    {noremap=true, silent=true, desc="Upper window"})
  kset('n', '<C-j>',
    "<C-w>j",
    {noremap=true, silent=true, desc="Bottom window"})

  kset('i', '<C-h>',
    '<Left>',
    {noremap=true, silent=true, desc="Left"})
  kset('i', '<C-l>',
    '<Right>',
    {noremap=true, silent=true, desc="Right"})
  kset('i', '<C-k>',
    '<Up>',
    {noremap=true, silent=true, desc="Up"})
  kset('i', '<C-j>',
    '<Down>',
    {noremap=true, silent=true, desc="Down"})

  kset('v', '<',
    '<gv',
    {noremap=true, silent=true, desc="Indent left"})
  kset('v', '>',
    '>gv',
    {noremap=true, silent=true, desc="Indent right"})

  kset('t', '<Esc>',
    '<C-\\><C-n>',
    {noremap=true, silent=true, desc="Exit terminal mode"})

  kset('n', '<leader>tf',
    cmd("ToggleTerm direction=float"),
    {noremap=true, silent=true, desc="Toggle floating terminal"})
  kset('n', '<leader>th',
    cmd("ToggleTerm direction=horizontal"),
    {noremap=true, silent=true, desc="Toggle horizontal terminal"})
  kset('n', '<leader>tv',
    cmd("ToggleTerm direction=vertical"),
    {noremap=true, silent=true, desc="Toggle vertical terminal"})
  kset('n', '<leader>ts', function()
    local trim_spaces = true
    require("toggleterm").send_lines_to_terminal("single_line", trim_spaces, {args= vim.v.count})
  end, {noremap=true, silent=true, desc="Send line to terminal"})
end

local function apply_lsp(bufnr, client)
  kset('n', 'gD',
    vim.lsp.buf.declaration,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Go to declaration"})
  kset('n', 'gd',
    vim.lsp.buf.definition,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Go to definition"})
  kset('n', 'gi',
    vim.lsp.buf.implementation,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Go to implementation"})
  kset('n', 'gr',
    vim.lsp.buf.references,
    {noremap=true, silent=true, desc="LSP: Go to reference"})

  kset('n', '<leader>k',
    vim.lsp.buf.signature_help,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Signature help"})
  kset('n', '<leader>K',
    vim.lsp.buf.hover,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Hover"})

  kset('n', '<leader>wa',
    vim.lsp.buf.add_workspace_folder,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Add workspace folder"})
  kset('n', '<leader>wr',
    vim.lsp.buf.remove_workspace_folder,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Remove workspace folder"})
  kset('n', '<leader>wl', function()
    print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
  end, {buffer=bufnr, noremap=true, silent=true, desc="LSP: List workspace folders"})

  kset('n', '<leader>D',
    vim.lsp.buf.type_definition,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Type definition"})
  -- kset('n', '<leader>ra',
  --   vim.lsp.buf.type_definition,
  --   {buffer=bufnr, noremap=true, silent=true, desc="LSP: Rename"})
  kset('n', '<leader>ra', function()
    require("renamer").rename()
  end, {noremap=true, silent=true, desc="LSP: Rename"})

  kset('n', '<leader>et',
    vim.diagnostic.open_float,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Diagnostings this"})
  kset('n', '<leader>el',
    vim.diagnostic.goto_next,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Diagnostings next"})
  kset('n', '<leader>eh',
    vim.diagnostic.goto_next,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Diagnostings prev"})
  kset('n', '<leader>em',
    vim.diagnostic.goto_next,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Diagnostings move to"})

  kset('n', '<leader>ca',
    vim.diagnostic.goto_next,
    {buffer=bufnr, noremap=true, silent=true, desc="LSP: Code action"})

  if (client.name == "clangd") then
    kset('n', '<leader>cd',
      cmd("TSCppDefineClassFunc"),
      {buffer=bufnr, noremap=true, silent=true, desc="CPP definition"})
    kset('v', '<leader>cd',
      "<cmd>'<,'>TSCppDefineClassFunc<CR><ESC>",
      {buffer=bufnr, noremap=true, silent=true, desc="CPP definition"})
    kset('n', '<leader>ch',
      cmd("ClangdSwitchSourceHeader"),
      {buffer=bufnr, noremap=true, silent=true, desc="Clang switch header/source"})
    -- kset('n', '<leader>cc', function()
    --   require("toggleterm").exec("cmake -B build")
    -- end, {noremap=true, silent=true, desc="CMake build"})
  end
end

local function apply_project()
  kset('n', '<leader>pb',
    cmd("ProjBuild"),
    {noremap=true, silent=true, desc="Build project"})
  kset('n', '<leader>pr',
    cmd("ProjRun"),
    {noremap=true, silent=true, desc="Run project"})
  kset('n', '<leader>pp',
    cmd("ProjBuildRun"),
    {noremap=true, silent=true, desc="Build and run project"})
  kset('n', '<leader>pc',
    cmd("ProjClean"),
    {noremap=true, silent=true, desc="Clean project"})
end

return {
  apply_general = apply_general,
  apply_lsp = apply_lsp,
  apply_project = apply_project,
}
