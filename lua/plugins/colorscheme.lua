-- lua/plugins/colorscheme.lua
return {
  'dracula/vim',
  name = 'dracula',
  lazy = false, -- load immediately
  priority = 1000, -- load before other plugins
  config = function()
    vim.cmd.colorscheme 'dracula'

    vim.api.nvim_set_hl(0, "Comment", { fg = "#bfbfbf", italic = true }) -- Set comment color

  end
}
