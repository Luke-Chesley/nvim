return {
  "Pocco81/auto-save.nvim",
  lazy = false, -- load on startup
  config = function()
    require("auto-save").setup({
      enabled = true,
      execution_message = {
        message = function() return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")) end,
      },
      -- see docs for more config
    })
  end,
}
