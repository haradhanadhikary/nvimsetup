return {
  "nvim-tree/nvim-tree.lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    local nvimtree = require("nvim-tree")

    -- recommended settings from nvim-tree documentation
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1

    -- change color for arrows in tree to light blue
    vim.cmd([[ highlight NvimTreeFolderArrowClosed guifg=#3FC5FF ]])
    vim.cmd([[ highlight NvimTreeFolderArrowOpen guifg=#3FC5FF ]])

    -- configure nvim-tree
    nvimtree.setup({
      view = {
        width = 35,
        relativenumber = true,
      },
      -- change folder arrow icons
      renderer = {
        indent_markers = {
          enable = true,
        },
        icons = {
          glyphs = {
            folder = {
              arrow_closed = "", -- arrow when folder is closed
              arrow_open = "", -- arrow when folder is open
            },
          },
        },
      },
      -- disable window_picker for
      -- explorer to work well with
      -- window splits
      actions = {
        open_file = {
          window_picker = {
            enable = false,
          },
        },
      },
      filters = {
        custom = { ".DS_Store" },
      },
      git = {
        ignore = false,
      },
    })

    -- set keymaps

    vim.g.mapleader = " "
    local keymap = vim.keymap -- for conciseness


    -- clear search highlights
    keymap.set("n", "<leader>nh", ":nohl<CR>")

    -- delete single character without copying into register
    keymap.set("n", "x", '"_x')

    -- increment/decrement numbers
    keymap.set("n", "<leader>+", "<C-a>") -- increment
    keymap.set("n", "<leader>-", "<C-x>") -- decrement

    -- window management
    keymap.set("n", "<leader>sv", "<C-w>v") -- split window vertically
    keymap.set("n", "<leader>sh", "<C-w>s") -- split window horizontally
    keymap.set("n", "<leader>se", "<C-w>=") -- make split windows equal width & height
    keymap.set("n", "<leader>sx", ":close<CR>") -- close current split window

    keymap.set("n", "<leader>to", ":tabnew<CR>") -- open new tab
    keymap.set("n", "<leader>tx", ":tabclose<CR>") -- close current tab
    keymap.set("n", "<leader>tn", ":tabn<CR>") --  go to next tab
    keymap.set("n", "<leader>tp", ":tabp<CR>") --  go to previous tab

    keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" }) -- toggle file explorer
    keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFileToggle<CR>", { desc = "Toggle file explorer on current file" }) -- toggle file explorer on current file
    keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Collapse file explorer" }) -- collapse file explorer
    keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Refresh file explorer" }) -- refresh file explorer
  end,
}
