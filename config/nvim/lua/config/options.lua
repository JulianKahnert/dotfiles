-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true

-- Cursor visibility
vim.opt.cursorline = true -- Highlight the current line

-- Make cursor more visible with thicker block cursor
vim.opt.guicursor = {
  "n-v-c:block-Cursor/lCursor", -- Normal, visual, command: block cursor
  "i-ci-ve:ver25-Cursor/lCursor", -- Insert: vertical bar at 25% width
  "r-cr:hor20-Cursor/lCursor", -- Replace: horizontal bar at 20% height
  "o:hor50-Cursor/lCursor", -- Operator-pending: horizontal bar at 50%
  "a:blinkwait700-blinkoff400-blinkon250", -- All modes: cursor blink settings
}
