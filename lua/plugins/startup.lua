return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    -- Function to read a random line from a file
    local function get_random_line(file_path)
      -- Expand ~ to the home directory
      local full_path = vim.fn.expand(file_path)
      local lines = {}

      -- Open the file and read lines into a table
      local file = io.open(full_path, "r")
      if not file then
        return "Could not open file: " .. full_path -- Fallback if file doesn't exist
      end

      for line in file:lines() do
        if line ~= "" then -- Skip empty lines
          table.insert(lines, line)
        end
      end
      file:close()

      -- If no lines were found, return a default message
      if #lines == 0 then
        return "No quotes found in file"
      end

      -- Seed the random number generator (optional, improves randomness)
      math.randomseed(os.time())
      -- Pick a random line
      local random_index = math.random(1, #lines)
      return lines[random_index]
    end

    -- Setup dashboard with random footer
    require("dashboard").setup({
      theme = "hyper",  -- using the hyper theme
      config = {
        week_header = { enable = true },
        header = {                       -- Optional custom header
          "",
          "Welcome to Neovim!",
          "",
        },
        footer = {
          "",                          -- Spacing
          "",                          -- Spacing
          get_random_line("/home/luke/.config/nvim/utils/footer_quotes.txt"), -- Random line from file
        },
        shortcut = {
          { desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
          {
            icon = " ",
            icon_hl = "@variable",
            desc = "Files",
            group = "Label",
            action = "Telescope find_files",
            key = "f",
          },
          { desc = " Apps", group = "DiagnosticHint", action = "Telescope app", key = "a" },
          {
            desc = " dotfiles",
            group = "Number",
            key = "d",
            action = function()
              require("telescope.builtin").find_files({ cwd = "~/.config" })
            end,
          },
        },
        project = {
          enable = true,
          limit = 8,
          icon = " ",
          label = "Projects:",
          action = function(path)
            require("telescope.builtin").find_files({ cwd = path })
          end,
          projects = {
            { name = "Winter25", path = "/home/luke/Drexel/Winter-25" },
            { name = "Inf",  path = "/home/luke/Desktop/inf" },
          },
        },
      },
    })
  end,
}

