local map = vim.keymap.set


-- leader e to toggle side file
map("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle Explorer" })
-- leader h and l to switch between files and side bar
map("n","<leader>h", "<C-w>h", {desc = "Focus left window"})
map("n","<leader>l", "<C-w>l", {desc = "Focus right window"})

-- split management
map("n", "<leader>sv", "<C-w>v", { desc = "Vertical split" })       -- Split vertically
map("n", "<leader>sc", "<C-w>c", { desc = "Close split" })         -- Close current split

-- resizing splits
map("n", "<C-Left>",  "<cmd>vertical resize -5<CR>", { desc = "Decrease width" })
map("n", "<C-Right>", "<cmd>vertical resize +5<CR>", { desc = "Increase width" })

-- markdown preview
map("n", "<leader>mp", "<cmd>MarkdownPreviewToggle<CR>", { desc = "Markdown Preview" })

-- undo in insert mode
map("i", "<C-z>","<C-o>u", {noremap = true, silent = true})

-- home jumps to first non blank char
vim.keymap.set("i", "<Home>", "<C-o>^", { noremap = true, silent = true })
vim.keymap.set({"n", "v"}, "<Home>", "^", { noremap = true, silent = true })



-- Git status (for fugitive)
map("n", "<leader>gs", ":Git<CR>", { desc = "Git Status" })
-- git do it all
map("n", "<leader>ga", function()
  vim.cmd("Git add .")
  local msg = vim.fn.input("Commit message: ")
  if msg == "" then
    msg = "Update at " .. os.date("%c")
  end
  vim.cmd("Git commit -m " .. vim.fn.shellescape(msg))
  vim.cmd("Git push")
end, { desc = "Add, commit & push all changes" })

-- copy to clipboard	
map("n", "<C-S-c>", '"+yy', { noremap = true, silent = true })
map("v", "<C-S-c>", '"+y', { noremap = true, silent = true })

-- hover information from lsp
map("n", "Kh", vim.lsp.buf.hover, { noremap = true, silent = true })

-- jump to method def
map("n", "Kd", vim.lsp.buf.definition, { noremap = true, silent = true })

-- size of file
-- CTRL + k
--
--
-- fuzzy find
map("n", "<leader>ff", "<cmd>Telescope find_files<CR>", { noremap = true, silent = true })

map("n", "<leader>fg", function()
  require("telescope.builtin").live_grep({
    additional_args = function() return { "--ignore-case" } end
  })
end, { noremap = true, silent = true })


map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { noremap = true, silent = true })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { noremap = true, silent = true })

 -- Delete highlights after search with esc
 vim.keymap.set("n", "<Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })

-- toggle spell check

vim.keymap.set('n', '<leader>pL', ':set spell!<CR>', { noremap = true, silent = true })
 -- turn off lsp

local diagnostics_enabled = true

vim.keymap.set("n", "<leader>pl", function()
  diagnostics_enabled = not diagnostics_enabled
  if diagnostics_enabled then
    vim.diagnostic.enable()
    print("LSP diagnostics enabled")
  else
    vim.diagnostic.enable(false)
    print("LSP diagnostics disabled")
  end
end, { noremap = true, silent = true })

local function open_floating_terminal(cmd)
  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = width,
    height = height,
    row = row,
    col = col,
    border = "rounded",
  }

  -- Create a new buffer and window
  local buf = vim.api.nvim_create_buf(false, true) -- No file, scratch buffer
  local win = vim.api.nvim_open_win(buf, true, opts) -- Open floating window

  -- Open terminal in the buffer running the given command
  vim.api.nvim_cmd({ cmd = "terminal", args = { cmd } }, {})

  -- Close window when the terminal process exits
  vim.api.nvim_create_autocmd("TermClose", {
    buffer = buf,
    callback = function()
      vim.api.nvim_win_close(win, true)
    end,
  })

  -- Enter insert mode so the program is interactive immediately
  vim.cmd("startinsert")
end

vim.keymap.set("n", "<leader>y", function() open_floating_terminal("yazi") end, { desc = "Open Yazi in floating window" })
vim.keymap.set("n", "<leader>gg", function() open_floating_terminal("lazygit") end, { desc = "Open lazygit in floating window" })

