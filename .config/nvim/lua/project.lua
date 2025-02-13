local toml = require("toml")
local mappings = require("mappings")
local inspect = require("inspect")

-- Sample file:
--
-- [_PROJECT]
-- run=""
-- clean="rm -rf ./build"
-- build="make -C build -j4"
-- config="cmake -B build"
-- target="demo_hello_cirno"
-- target_config="debug"
--
-- [demo_hello_cirno]
-- run="./build/demos/hello_cirno"
--
-- [demo_hello_cirno.configs]
-- debug=["-DCMAKE_BUILD_TYPE=Debug", "-DSHOGLE_ENABLE_IMGUI=1", "-DSHOGLE_BUILD_DEMOS=1"]
-- release=["-DCMAKE_BUILD_TYPE=Release", "-DSHOGLE_ENABLE_IMGUI=1", "-DSHOGLE_BUILD_DEMOS=1"]

local function first_key(table)
  for k,_ in pairs(table) do
    return k
  end
end

local function read_file(path)
  local f = io.open(path, "rb")
  if (not f) then
    return nil, "Can't open file"
  end
  local content = f:read("*all")
  f:close()
  return content
end

local function parse_project(path)
  local file_content, err = read_file(path)
  if (not file_content) then
    return nil, err
  end

  local succ, toml_content = pcall(toml.decode, file_content)
  if (not succ) then
    return nil, toml_content.reason
  end

  local proj = toml_content._PROJECT
  if (not proj) then
    return nil, "Root config not defined"
  end

  local run_cmd = proj.run or ""

  local function gen_target_commands(target)
    local cmds = {}
    if (not target.run) then
      return nil
    end
    cmds.run = run_cmd ~= "" and string.format("%s %s", run_cmd, target.run) or target.run
    if (proj.config and target.configs ~= nil) then
      cmds.configs = {}
      for k, v in pairs(target.configs) do
        local str = ""
        local i = 0
        for _, arg in ipairs(v) do
          if (i == 0) then
            str = str..arg
          else
            str = str.." "..arg
          end
          i = i + 1
        end

        cmds.configs[k] = string.format("%s %s", proj.config, str)
      end
    end

    return cmds
  end

  local targets = {}
  local empty = true
  for k, v in pairs(toml_content) do
    if (k ~= "_PROJECT") then
      local cmd = gen_target_commands(v)
      if (targets) then
        targets[k] = cmd
        empty = false
      end
    end
  end

  if (empty) then
    return nil, "No targets defined"
  end

  return {
    target = proj.target,
    config = proj.target_config,
    targets = targets,
    build = proj.build,
    clean = proj.clean
  }
end

local state = {
  dir = "horizontal",
}

local function init()
  local proj = parse_project("./.project.toml")
  if (not proj) then
    return
  end

  state.targets = proj.targets
  state.clean = proj.clean
  state.build = proj.build

  if (proj.target and proj.targets[proj.target]) then
    state.target = proj.target
  else
    state.target = first_key(proj.targets)
  end

  if (proj.config and state.targets[state.target].configs[proj.config]) then
    state.config = proj.config
  else
    state.config = first_key(state.target.configs)
  end

  vim.api.nvim_create_user_command("ProjState", function()
    print(inspect(state))
  end, { desc = "List project state"})

  vim.api.nvim_create_user_command("ProjTarget", function(arg)
    if (#arg.fargs == 0) then
      return
    end

    local name = arg.fargs[1]:gsub('"','')
    if (state.targets[name]) then
      state.target = name
      if (not state.targets[name].configs[state.config]) then
        state.config = first_key(state.target.configs)
      end
      print(string.format("Target changed to \"%s\"", name))
    else
      print(string.format("Target not found: \"%s\"", name))
    end
  end, { desc = "Set project target"})
  vim.api.nvim_create_user_command("ProjTargetList", function()
    local names = {}
    for k,_ in pairs(state.targets) do
      table.insert(names, k)
    end
    print(inspect(names))
  end, { desc = "List project targets"})

  vim.api.nvim_create_user_command("ProjConf", function(arg)
    if (#arg.fargs == 0) then
      return
    end

    local name = arg.fargs[1]:gsub('"','')
    local target = state.targets[state.target]
    if (target.configs[name]) then
      state.config = name
      print(string.format("Target config changed to \"%s\"", name))
    else
      print(string.format("Target config not found \"%s\"", name))
    end
  end, { desc = "Set project config"})
  vim.api.nvim_create_user_command("ProjConfList", function()
    local target = state.targets[state.target]
    local names = {}
    for k,_ in pairs(target.configs) do
      table.insert(names, k)
    end
    print(inspect(names))
  end, { desc = "List target configs"})

  vim.api.nvim_create_user_command("ProjBuild", function()
    local target = state.targets[state.target]
    local conf = target.configs[state.config]
    local cmd = string.format("%s && %s", conf, state.build)
    vim.cmd(string.format("TermExec cmd='%s' direction=%s", cmd, state.dir))
  end, { desc = "Build Project"})
  vim.api.nvim_create_user_command("ProjRun", function()
    local target = state.targets[state.target]
    vim.cmd(string.format("TermExec cmd='%s' direction=%s", target.run, state.dir))
  end, { desc = "Run project"})
  vim.api.nvim_create_user_command("ProjBuildRun", function()
    local target = state.targets[state.target]
    local conf = target.configs[state.config]
    local cmd = string.format("%s && %s", conf, state.build)
    vim.cmd(string.format("TermExec cmd='%s && %s' direction=%s", cmd, target.run, state.dir))
  end, { desc = "Run project"})
  vim.api.nvim_create_user_command("ProjClean", function()
    vim.cmd(string.format("TermExec cmd='%s' direction=%s", state.clean, state.dir))
  end, { desc = "Run project"})

  vim.api.nvim_create_user_command("ProjTerm", function(arg)
    local valid_dirs = {
      ["horizontal"] = 1,
      ["vertical"] = 1,
      ["float"] = 1,
    }
    if (#arg.fargs == 0) then
      return
    end

    local name = arg.fargs[1]:gsub('"','')
    if (valid_dirs[name] == nil) then
      print(string.format("Invalid terminal mode: \"%s\"", name))
    else
      state.dir = name
      print(string.format("Terminal mode set to \"%s\"", name))
    end
  end, { desc = "Set project terminal mode"})

  mappings.apply_project()
end

return {
  init = init,
}
