local opt = vim.opt

-- UI
opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.signcolumn = "yes"
opt.cursorline = true

-- Editing
opt.mouse = "a"
opt.clipboard = "unnamedplus"
opt.undofile = true

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true

-- Indentation (safe defaults)
opt.expandtab = true
opt.shiftwidth = 2
opt.tabstop = 2
opt.smartindent = true

-- UX
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.updatetime = 250
opt.timeoutlen = 400

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance / clean UI
opt.backup = false
opt.writebackup = false
opt.swapfile = false
opt.hlsearch = true
opt.inccommand = "split"
