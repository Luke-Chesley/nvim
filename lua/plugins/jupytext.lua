-- File: lua/plugins/jupytext.lua

return {
    "goerz/jupytext.vim",
    lazy = false, -- Load immediately
    config = function()
        vim.g.jupytext_fmt = "py" -- Convert notebooks to Python scripts
        vim.g.jupytext_auto_save = 1 -- Auto-sync to .ipynb on save
        vim.api.nvim_create_autocmd("BufWritePost", {
            pattern = "*.py",
            callback = function()
                os.execute("rm " .. vim.fn.expand("%")) -- Delete the .py file after saving
            end,
        })
    end,
}

