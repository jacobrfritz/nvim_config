return {
  { -- Highlight, edit, and navigate code
    'nvim-treesitter/nvim-treesitter',
    build = ':TSUpdate',
    config = function()
      local status, treesitter = pcall(require, 'nvim-treesitter.configs')
      if not status then
        treesitter = require 'nvim-treesitter'
      end

      treesitter.setup {
        ensure_installed = {
          'bash',
          'c',
          'diff',
          'html',
          'lua',
          'luadoc',
          'latex',
          'yaml',
          'markdown',
          'markdown_inline',
          'query',
          'vim',
          'vimdoc',
          'python',
          'javascript',
          'json',
          'toml',
          'regex',
        },
        auto_install = true,
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = { 'ruby' },
        },
        indent = { enable = true, disable = { 'ruby' } },
      }
    end,
  },

  { -- Show code context (sticky function/class headers)
    'nvim-treesitter/nvim-treesitter-context',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      max_lines = 3,
      trim_scope = 'outer',
    },
  },
}
