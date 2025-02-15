-- lua/config/options.lua
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.termguicolors = true
vim.opt.background = 'dark'

-- / type to search like ctrl f
vim.opt.hlsearch = true

-- spell checker
vim.keymap.set("n", "<C-.>", "z=", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = {"markdown", "text", "python"},
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
  end,
})




