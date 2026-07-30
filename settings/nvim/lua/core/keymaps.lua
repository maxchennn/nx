local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Pencere Yönetimi
map("n", "H", "<C-w>h", opts)
map("n", "J", "<C-w>j", opts)
map("n", "K", "<C-w>k", opts)
map("n", "L", "<C-w>l", opts)
map("n", "v", "<C-w>v", opts)
map("n", "s", "<C-w>s", opts)
map("n", "e", "<C-w>=", opts)
map("n", "c", "<C-w>q", opts)

-- Kayıt ve Çıkış
map("n", "W", "<cmd>w<CR>", opts) -- Büyük W (Normal w kelime atlama komutunu bozmamak için)
map("n", "Q", "<cmd>q<CR>", opts) -- Büyük Q

-- Arama temizleme
map("n", "<Esc>", "<cmd>nohlsearch<CR>", opts)

-- File Explorer (NvimTree)
map("n", "f", "<cmd>NvimTreeToggle<CR>", opts)
map("n", "F", "<cmd>NvimTreeFindFile<CR>", opts)
map("n", "gh", function()
  local api = require("nvim-tree.api")
  api.tree.toggle_hidden_filter()
  api.tree.open()
end, opts)

-- Terminal
map("n", "t", "<cmd>term<CR>", opts)
map("t", "<Esc>", "<C-\\><C-n>", opts)

-- Buffer Yönetimi
map("n", "n", ":bnext<CR>", opts)
map("n", "p", ":bprevious<CR>", opts)
map("n", "x", ":bdelete<CR>", opts)

-- Düzenleme
map("n", "Y", "ggVG\"+y", opts) -- Büyük Y
map("n", "d", "dd", opts)
map("n", "D", "d$", opts)
