return {
  "lukas-reineke/indent-blankline.nvim",
  main = "ibl",
  opts = {
    indent = {
      char = "│",
      -- Uncomment below to use multiple colors for indents:
      -- highlight = {
      --   "RainbowRed",
      --   "RainbowYellow",
      --   "RainbowBlue",
      --   "RainbowOrange",
      --   "RainbowGreen",
      --   "RainbowViolet",
      --   "RainbowCyan",
      -- },
    },
    scope = {
      enabled = false,
    },
    whitespace = {
      remove_blankline_trail = false,
    },
    exclude = {
      filetypes = { "dashboard" },
      -- buftypes = { "terminal" },
    },
  },
}

