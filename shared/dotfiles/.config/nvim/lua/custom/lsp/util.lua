local Job_ok, Job = pcall(require, 'plenary.job')

if not Job_ok then
  return nil
end

local M = {}

-- Asynchronously check if a command is actually executable.
-- The main reason for this complexity is due to potential shims
function M.check_executable(command, callback)
  local args = vim.split(command, ' ')
  local cmd = table.remove(args, 1)

  if vim.fn.executable(cmd) == 0 then
    callback(false, command)
    return
  end

  Job:new({
    command = cmd,
    args = args,
    enable_handlers = false,
    on_exit = function(job, code)
      callback(code == 0, command)
    end
  }):start()
end

-- Given a list of commands, return only commands which are actually executable
function M.check_executables(executables, callback)
  local remaining = #executables
  local commands = {}

  local check_cb = function(is_exe, command)
    if is_exe then
      table.insert(commands, command)
    end
    remaining = remaining - 1
    if remaining == 0 then
      callback(commands)
    end
  end

  for _, executable in pairs(executables) do
    M.check_executable(executable, check_cb)
  end
end

return M
