return {
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("nvim-tree").setup({
        sort = { sorter = "case_sensitive" },
        view = { width = 30 },
        renderer = { group_empty = true },
        filters = { dotfiles = true },
        git = { ignore = false },
      })

      local c = require("veil.palette.julia")
      vim.api.nvim_set_hl(0, "NvimTreeFolderIcon", { fg = c.blue })
      vim.api.nvim_set_hl(0, "NvimTreeFileIcon", { fg = c.white })
      vim.api.nvim_set_hl(0, "NvimTreeFolderName", { fg = c.blue })
      vim.api.nvim_set_hl(0, "NvimTreeOpenedFolderName", { fg = c.blue })
      vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = c.blue })
      vim.api.nvim_set_hl(0, "NvimTreeGitDirty", { fg = c.yellow })
      vim.api.nvim_set_hl(0, "NvimTreeGitStaged", { fg = c.green })
      vim.api.nvim_set_hl(0, "NvimTreeGitNew", { fg = c.green })

      vim.keymap.set("n", "<leader>h", function()
        require("nvim-tree.api").tree.toggle_hidden_filter()
      end, opts)
    end,
  },
}

