-- File: lua/plugins/jupytext.lua


return {
    "goerz/jupytext.vim",
    lazy = false, -- Load immediately
    config = function()
        vim.g.jupytext_fmt = "py" -- Convert notebooks to Python scripts
        vim.g.jupytext_auto_save = 1 -- Auto-sync to .ipynb on save

        -- Delete the .py file when the buffer is closed
        vim.api.nvim_create_autocmd("BufUnload", {
            pattern = "*.py",
            callback = function()
                local file = vim.fn.expand("<afile>")
                if vim.fn.filereadable(file) == 1 then
                    os.execute("rm " .. vim.fn.shellescape(file))
                end
            end,
        })
    end,
}

