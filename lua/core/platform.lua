-- lua/core/platform.lua
local M = {}

M.is_windows = vim.fn.has 'win32' == 1
M.is_mac = jit.os == 'OSX'
M.is_linux = jit.os == 'Linux'

M.setup = function()
  if M.is_windows then
    -- This only runs on Windows
    vim.opt.shell = 'powershell'
    vim.opt.shellcmdflag =
      '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = ''
  end

  if M.is_mac then
    local extra_paths = {
      '/opt/homebrew/bin',
      '/opt/homebrew/sbin',
      '/usr/local/bin',
      '/usr/local/sbin',
    }
    for _, p in ipairs(extra_paths) do
      if vim.fn.isdirectory(p) == 1 and not string.find(vim.env.PATH, p, 1, true) then
        vim.env.PATH = p .. ':' .. vim.env.PATH
      end
    end
  end
end

return M
