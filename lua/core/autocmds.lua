-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.hl.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

-- Keystroke Prediction Engine Client Snippet
-- Drop this into your init.lua or a separate file in your ~/.config/nvim/lua directory

local history = { '', '', '', '', '' }

-- Namespace for virtual text predictions
local ns_id = vim.api.nvim_create_namespace 'keystroke_predictor'

-- Autocommand to capture keystrokes and log transitions
vim.api.nvim_create_autocmd('InsertCharPre', {
  group = vim.api.nvim_create_augroup('KeystrokeLogger', { clear = true }),
  callback = function()
    local current_key = vim.v.char

    -- Clear previous virtual text on new keystroke
    vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

    local all_filled = true
    for _, v in ipairs(history) do
      if v == '' then
        all_filled = false
        break
      end
    end

    if all_filled then
      -- Fire and forget the update to the FastAPI backend
      local payload =
        string.format('{"context": ["%s", "%s", "%s", "%s", "%s"], "next_key": "%s"}', history[1], history[2], history[3], history[4], history[5], current_key)

      vim.fn.jobstart({
        'curl',
        '-s',
        '-X',
        'POST',
        'http://localhost:8000/api/v1/log',
        '-H',
        'Content-Type: application/json',
        '-d',
        payload,
      }, { detach = true })
    end

    -- Shift the history window (FIFO)
    table.remove(history, 1)
    table.insert(history, current_key)
  end,
})

-- Autocommand to fetch predictions when pausing in Insert mode
vim.api.nvim_create_autocmd('CursorHoldI', {
  group = vim.api.nvim_create_augroup('KeystrokePredictor', { clear = true }),
  callback = function()
    local all_filled = true
    for _, v in ipairs(history) do
      if v == '' then
        all_filled = false
        break
      end
    end

    if all_filled then
      local url = 'http://localhost:8000/api/v1/predict'
      vim.fn.jobstart({
        'curl',
        '-s',
        '-G',
        url,
        '--data-urlencode',
        'c1=' .. history[1],
        '--data-urlencode',
        'c2=' .. history[2],
        '--data-urlencode',
        'c3=' .. history[3],
        '--data-urlencode',
        'c4=' .. history[4],
        '--data-urlencode',
        'c5=' .. history[5],
        '--data-urlencode',
        'limit=1',
      }, {
        stdout_buffered = true,
        on_stdout = function(_, data)
          if not data or #data == 0 or data[1] == '' then
            return
          end
          local ok, decoded = pcall(vim.fn.json_decode, table.concat(data, ''))
          if ok and decoded and decoded.predictions and #decoded.predictions > 0 then
            local best_prediction = decoded.predictions[1].key
            local row, col = unpack(vim.api.nvim_win_get_cursor(0))

            vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)

            pcall(vim.api.nvim_buf_set_extmark, 0, ns_id, row - 1, col, {
              virt_text = { { best_prediction, 'Comment' } },
              virt_text_pos = 'inline',
            })
          end
        end,
      })
    end
  end,
})

-- Optional: Map <C-e> to accept the current prediction
vim.keymap.set('i', '<C-e>', function()
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  local extmarks = vim.api.nvim_buf_get_extmarks(0, ns_id, { row - 1, col }, { row - 1, col }, { details = true })
  if #extmarks > 0 then
    local extmark = extmarks[1]
    if extmark[4] and extmark[4].virt_text and #extmark[4].virt_text > 0 then
      local prediction = extmark[4].virt_text[1][1]
      vim.api.nvim_buf_clear_namespace(0, ns_id, 0, -1)
      -- Return the prediction to be inserted, as we used expr=true
      return prediction
    end
  end
  return ''
end, { expr = true, replace_keycodes = true })
