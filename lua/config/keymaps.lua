-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Function to toggle focus between terminal and last active editor
local function toggle_terminal_focus()
  local term_win = nil

  -- Find the terminal window if it exists
  for _, w in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
    local buf = vim.api.nvim_win_get_buf(w)
    local buftype = vim.bo[buf].buftype -- updated from deprecated API
    if buftype == "terminal" then
      term_win = w
      break
    end
  end

  local current_win = vim.api.nvim_get_current_win()

  if term_win then
    if current_win == term_win then
      -- We are in terminal, go to previous window (editor)
      vim.cmd("wincmd p")
    else
      -- Go to terminal window
      vim.api.nvim_set_current_win(term_win)
      vim.cmd("startinsert") -- enter terminal mode automatically
    end
  end
end

-- Map Ctrl+' in normal and terminal mode
vim.keymap.set("n", "<C-'>", toggle_terminal_focus, { noremap = true, silent = true })
vim.keymap.set("t", "<C-'>", toggle_terminal_focus, { noremap = true, silent = true })
