-- lua/plugins/colorscheme.lua
-- return {
--   'dracula/vim',
--   name = 'dracula',
--   lazy = false, -- load immediately
--   priority = 1000, -- load before other plugins
--   config = function()
--     vim.cmd.colorscheme 'dracula'
--
--     vim.api.nvim_set_hl(0, "Comment", { fg = "#bfbfbf", italic = true }) -- Set comment color
--
--   end
-- }
--

-- return {
--   "folke/tokyonight.nvim",
--   lazy = false, -- load immediately
--   priority = 1000, -- load before other plugins
--   config = function()
--     require("tokyonight").setup({
--       style = "storm", -- Options: "storm", "night", "moon", "day"
--       transparent = false, -- Set to true if you want a transparent background
--       on_colors = function(colors)
--         -- Optional: Customize colors if needed
--       end,
--       on_highlights = function(highlights, colors)
--         -- Optional: Customize specific highlights
--         highlights.Comment = { fg = colors.comment, italic = true } -- Example tweak
--       end,
--     })
--     vim.cmd.colorscheme("tokyonight")
--   end,
--}
-- Catppuccin (commented out)
return {
    "catppuccin/nvim",
    name = "catppuccin",
    lazy = false,
    priority = 1000,
    config = function()
      require("catppuccin").setup({
        flavour = "frappe", -- Options: "latte", "frappe", "macchiato", "mocha"
        transparent_background = false,
        term_colors = true,
        integrations = {
          treesitter = true,
          lsp_trouble = false,
          which_key = false,
        },
        custom_highlights = function(colors)
          return {
            Comment = { fg = colors.text, italic = true },
            -- Example: Make Python keywords stand out
            ["@keyword.python"] = { fg = colors.pink, bold = true }, -- For 'if', 'return', etc.
            ["@keyword.function.python"] = { fg = colors.pink, bold = true }, -- For 'def'
            ["@keyword.type.python"] = { fg = colors.pink, bold = true }, -- For 'class'
            ["@keyword.import.python"] = { fg = colors.pink, bold = true },
            ["@function.python"] = { fg = colors.yellow, italic = true },
          }
        end,
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  }
