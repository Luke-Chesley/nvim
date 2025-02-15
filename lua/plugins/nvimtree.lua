return {
  "nvim-tree/nvim-tree.lua",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  config = function()
    require("nvim-tree").setup({
      git = { ignore = false },
      filters = {
	      dotfiles = false
      },
      update_focused_file = { enable = false },
      on_attach = function(bufnr)
        local api = require("nvim-tree.api")
        api.config.mappings.default_on_attach(bufnr)

        -- map "C" to change cwd
        vim.keymap.set("n", "C", api.tree.change_root_to_node, {
          buffer = bufnr,
          desc = "CD to selected dir",
        })

        -- override "c" to copy file path to system clipboard
        vim.keymap.set("n", "c", function()
          local node = api.tree.get_node_under_cursor()
          if node and node.absolute_path then
            vim.fn.setreg("+", node.absolute_path)
            print("Copied " .. node.absolute_path .. " to clipboard.")
          else
            print("No node found")
          end
        end, { buffer = bufnr, desc = "Copy file path to clipboard" })
      end,
    })

    vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { silent = true, noremap = true })
  end,
}

