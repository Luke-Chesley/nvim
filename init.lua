require("config.lazy")
require("config.options")
require("config.keymaps")

--vim.api.nvim_set_option("clipboard", "unnamed")
vim.opt.clipboard = "unnamedplus"
if os.getenv("KITTY_WINDOW_ID") then
  vim.fn.system("kitty @ decrease-font-size")
  vim.fn.system("kitty @ decrease-font-size")
end


-- Predefine so it's never undefined
vim.g.python3_host_prog = ""

local function auto_activate_venv()
  local cwd = vim.fn.getcwd()
  local candidates = { cwd .. "/.venv", cwd .. "/venv" }
  for _, path in ipairs(candidates) do
    if vim.fn.isdirectory(path) == 1 then
      local py_path = path .. "/bin/python"
      if vim.fn.filereadable(py_path) == 1 then
        vim.g.python3_host_prog = py_path
        print("Activated venv: " .. py_path)
        return
      end
    end
  end
  print("No venv found in " .. cwd)
end

-- Check on startup
vim.api.nvim_create_autocmd("VimEnter", {
  callback = auto_activate_venv,
})

-- Always run on directory change
vim.api.nvim_create_autocmd("DirChanged", {
  callback = auto_activate_venv,
})

vim.api.nvim_create_user_command("Pwdd", function()
  local cwd = vim.fn.getcwd()
  vim.fn.setreg("+", cwd)
  print("Copied " .. cwd .. " to clipboard.")
end, {})

-- Reload config command
vim.api.nvim_create_user_command("ReloadConfig", function()
  for name,_ in pairs(package.loaded) do
    if name:match("^config") or name:match("^plugins") then
      package.loaded[name] = nil
    end
  end
  dofile(vim.fn.stdpath("config") .. "/init.lua")
  print("Reloaded nvim config!")
end, {})



-- turn off pyright hints
vim.diagnostic.config({
  virtual_text = {
    -- Only show diagnostics at Info level (3) or higher.
    severity = { min = vim.diagnostic.severity.INFO },
  },
  signs = {
    -- Only show gutter signs at Info level or higher.
    severity = { min = vim.diagnostic.severity.INFO },
  },
  underline = {
    -- Don’t underline hints either.
    severity = { min = vim.diagnostic.severity.INFO },
  },
  float = {
    severity_sort = true,
  },
})



-- pdf 
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = {"*.pdf"},
  callback = function()
    local filepath = vim.fn.expand("%:p")
    vim.fn.jobstart({ "zathura", filepath }, { detach = true })
    vim.cmd("bd!")  -- close the buffer so you don't see binary data
  end,
})

