local awful = require('awful')
-- local debug_mode = config.module.auto_start.debug_mode or false

local _M = {}

_M.on_startup = function(autostart)
  for _, cmd in ipairs(autostart) do
    local findme = cmd
    local firstspace = cmd:find(' ')
    if firstspace then
      findme = cmd:sub(0, firstspace - 1)
    end
    -- naughty.notification{
    --   message=string.format('pgrep -x %s &>/dev/null || pgrep -x -f %s >/dev/null || %s', findme, findme, cmd),
    --   timeout = 20,
    -- }
    awful.spawn.easy_async_with_shell(
      string.format('pgrep -x %s &>/dev/null || pgrep -x -f %s >/dev/null || %s', findme, findme, cmd),
      function(_, stderr)
        -- Debugger 
        -- if not stderr or stderr == '' or not debug_mode then
        if not stderr or stderr == '' then return end

        -- naughty.notification({
        --   app_name = 'Start-up Applications',
        --   title = '<b>Oof! Error detected when starting an application!</b>',
        --   message = stderr:gsub('%\n', ''),
        --   timeout = 20,
        --   icon = require('beautiful').awesome_icon
        -- })
      end
    )
  end
end

_M.on_reload = function(autostart)
  for _, cmd in ipairs(autostart) do
    awful.spawn.easy_async_with_shell(cmd)
  end
end

return _M
