return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  
  config = function()
    require("nvim-treesitter.configs").setup({
      ensure_installed = { "c","python","cpp","cuda","dockerfile","cmake","json", "lua", "vim", "vimdoc", "query", "markdown", "markdown_inline",},
      highlight = { enable = true },
      auto_install = true,
      -- ...
    })
  end,
}

