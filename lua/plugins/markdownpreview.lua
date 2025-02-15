return {
  'iamcco/markdown-preview.nvim',
  build = function()
    vim.fn['mkdp#util#install']()
  end,
  ft = 'markdown',
  init = function()
    vim.g.mkdp_browser = 'google-chrome' -- or 'google-chrome'
    vim.g.mkdp_echo_preview_url = 1 -- Show URL when opening
    vim.g.mkdp_port = '8080' -- Explicit port
  end
}
