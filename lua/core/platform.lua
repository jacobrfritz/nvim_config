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
    vim.env.PATH = '/opt/homebrew/bin:' .. vim.env.PATH
  end
end

return M
