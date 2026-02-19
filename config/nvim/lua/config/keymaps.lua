-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- Disable macro recording (q is never used intentionally)
vim.keymap.set("n", "q", "<nop>", { desc = "Disable macro recording" })
