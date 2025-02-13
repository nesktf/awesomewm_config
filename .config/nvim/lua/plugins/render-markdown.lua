local _M = {}

local common_bg = "#3C3836"
local code_bg = "None"
local colors = {
  ['RenderMarkdownH1Bg'] = { bg = common_bg, fg = "#FFFFFF" },
  ['RenderMarkdownH2Bg'] = { bg = common_bg, fg = "#83A598" },
  ['RenderMarkdownH3Bg'] = { bg = common_bg, fg = "#8EC07C"},
  ['RenderMarkdownH4Bg'] = { bg = common_bg, fg = "#FABD2F" },
  ['RenderMarkdownH5Bg'] = { bg = common_bg, fg = "#FE8019" },
  ['RenderMarkdownH6Bg'] = { bg = common_bg, fg = "#FB4934" },
  ['RenderMarkdownH1'] = { bg = common_bg, fg = "#FFFFFF" },
  ['RenderMarkdownH2'] = { bg = common_bg, fg = "#83A598" },
  ['RenderMarkdownH3'] = { bg = common_bg, fg = "#8EC07C"},
  ['RenderMarkdownH4'] = { bg = common_bg, fg = "#FABD2F" },
  ['RenderMarkdownH5'] = { bg = common_bg, fg = "#FE8019" },
  ['RenderMarkdownH6'] = { bg = common_bg, fg = "#FB4934" },
  ['RenderMarkdownCode'] = { bg = code_bg },
  ['RenderMarkdownCodeInline'] = { bg = code_bg }
}

function _M.config()
  for k, v in pairs(colors) do
    vim.api.nvim_set_hl(0, k, v)
  end

  require('render-markdown').setup {
    heading = {
      sign = true,
      width = 'block',
      position = 'inline',
      right_pad = 2,
      left_pad = 1,
    },
    dash = {
      width = 100,
    },
    quote = { repeat_linebreak = true },
    win_options = {
        showbreak = { default = '', rendered = '  ' },
        breakindent = { default = false, rendered = true },
        breakindentopt = { default = '', rendered = '' },
    },
    code = {
      width = 'block',
      border = 'None',
      left_pad = 1,
      language_pad = 0,
    }
  }
end

return _M
