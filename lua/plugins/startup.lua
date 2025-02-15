return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("dashboard").setup({
      theme = "hyper",  -- using the hyper theme
      config = {
        week_header = { enable = true },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          { desc = " Apps", group = "DiagnosticHint", action = "Telescope app", key = "a" },
          {
            desc = " dotfiles",
            group = "Number",
            key = "d",
            action = function()
              -- Change "~/dotfiles" to your actual dotfiles directory if needed
              require("telescope.builtin").find_files({ cwd = "~/.config" })
            end,
          },
        },
        project = {
          enable = true,
          limit = 8,
          icon = " ",
          label = "Projects:",
          action = function(path)
            require("telescope.builtin").find_files({ cwd = path })
          end,
          projects = {
            { name = "Winter25", path = "/home/luke/Drexel/Winter-25" },
            { name = "Inf",  path = "/home/luke/Desktop/inf" },
          },
        },
      },
    })
  end,
}

