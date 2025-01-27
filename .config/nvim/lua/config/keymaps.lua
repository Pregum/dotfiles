-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
if vim.g.vscode == 1 then
	vim.mapleader = "<Space>"
	vim.keymap.set("i", "jj", "<Esc>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-j>", "<Down>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-k>", "<Up>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-h>", "<Left>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-l>", "<Right>", { silent = true, noremap = true })
	vim.keymap.set("n", "<C-n>", ":NeoTreeShowToggle<Return>", { noremap = true, silent = true })
	vim.keymap.set("v", "s", "xi")
	vim.keymap.set("", "<Leader>h", "0", { silent = true })
	vim.keymap.set("", "<Leader>l", "$", { silent = true })
	vim.keymap.set("", "<Leader>k", "<C-u>", { silent = true })
	vim.keymap.set("", "<Leader>j", "<C-d>", { silent = true })
else
	vim.mapleader = "<Space>"
	vim.keymap.set("i", "jj", "<Esc>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-j>", "<Down>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-k>", "<Up>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-h>", "<Left>", { silent = true, noremap = true })
	vim.keymap.set("i", "<C-l>", "<Right>", { silent = true, noremap = true })
	vim.keymap.set("n", "<C-n>", ":NeoTreeShowToggle<Return>", { noremap = true, silent = true })
	vim.keymap.set("", "<Leader>h", "0", { silent = true })
	vim.keymap.set("", "<Leader>l", "$", { silent = true })
	vim.keymap.set("", "<Leader>k", "<C-u>", { silent = true })
	vim.keymap.set("", "<Leader>j", "<C-d>", { silent = true })
end
