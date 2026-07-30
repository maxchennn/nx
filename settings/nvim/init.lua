-- =========================
-- INIT 
-- =========================

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true

opt.shiftwidth = 4
opt.tabstop = 4
opt.expandtab = true
opt.smartindent = true
opt.wrap = false

opt.clipboard = "unnamedplus"
opt.swapfile = false
opt.backup = false
opt.writebackup = false

vim.g.mapleader = " "

-- =========================
-- LAZY BOOTSTRAP
-- =========================
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- =========================
-- SETUP
-- =========================
require("lazy").setup({
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({})
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter",
    event = "VeryLazy",
    build = ":TSUpdate",
    config = function()
      -- Modülün varlığını güvenli şekilde kontrol ediyoruz
      local status_ok, configs = pcall(require, "nvim-treesitter.configs")
      if not status_ok then return end
      
      configs.setup({
        ensure_installed = { "lua", "vim", "vimdoc", "query" },
        highlight = { enable = true },
        indent = { enable = true },
      })
    end,
  },
})

-- =========================
-- KEYBINDS
-- =========================

local map = vim.keymap.set

map("n", "f", ":NvimTreeToggle<CR>")
map("n", "i", "i")
map("n", "s", ":nohlsearch<CR>")

map("n", "z", "k")
map("n", "a", "h")
map("n", "d", "l")
map("n", "x", "j")

map("n", "<leader>w", ":w<CR>")
map("n", "<leader>q", ":q<CR>")

vim.cmd("colorscheme default")
