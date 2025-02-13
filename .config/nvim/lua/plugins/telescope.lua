local _M = {}

function _M:config()
  require('telescope').setup{

  }
end

function _M.show_garbage()
  local pickers = require("telescope.pickers")
  local finders = require("telescope.finders")
  local conf = require("telescope.config").values

  opts = opts or {}
  pickers.new(opts, {
    prompt_title = "test",
    finder = finders.new_table {
      results = { "A", "M", "OGUS" },
    },
    sorter = conf.generic_sorter(opts),
  }):find()
end

return _M
