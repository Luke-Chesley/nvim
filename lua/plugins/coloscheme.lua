-- lua/plugins/colorscheme.lua
return {
  'dracula/vim',
  name = 'dracula',
  lazy = false, -- load immediately
  priority = 1000, -- load before other plugins
  config = function()
    vim.cmd.colorscheme 'dracula'
  end
}
