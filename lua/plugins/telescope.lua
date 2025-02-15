return {
  "nvim-telescope/telescope.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  cmd = "Telescope",
  config = function()
    -- Set keybindings correctly inside function
    -- Load Telescope setup
    require("telescope").setup({})
  end,
}

