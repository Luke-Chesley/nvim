-- ./lua/plugins/lsp.lua
return {
  -- 1) Mason + Mason-lspconfig
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "lua_ls",
          "pyright",
          "clangd",
          "cmake", -- Added CMake
        },
      })
    end,
  },

  -- 2) nvim-lspconfig (single config block for all LSPs)
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp", -- for LSP completions
    },
    config = function()
      local lspconfig = require("lspconfig")
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      local util = require("lspconfig.util")

      -- Lua LSP
      lspconfig.lua_ls.setup({
        capabilities = capabilities,
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- Python LSP
      lspconfig.pyright.setup({
        root_dir = util.root_pattern("pyrightconfig.json", "pyproject.toml", "setup.py", "requirements.txt", ".git"),
        capabilities = capabilities,
        settings = {
          python = {
            venvPath = vim.fn.getcwd(),
            venv = ".venv",
            analysis = {
              typeCheckingMode = "off",
              diagnosticMode = "openFilesOnly",
              reportUnusedImports = "none",
              reportUnusedClass = "none",
              reportUnusedFunction = "none",
              reportUnusedVariable = "none",
              reportAttributeAccessIssue = "none",
              reportReturnType = "none",
              reportUnusedSymbol = "none",
              useLibraryCodeForTypes = true,
              extraPaths = { vim.fn.getcwd() .. "/.venv/lib/python3.x/site-packages" },
              inlayHints = {
                  variableTypes = true,
                  functionReturnTypes = true,
                  callArgumentNames = true,
                  pytestParameters = true,
              }
            },
          },
        },
       on_attach = function(client, bufnr)
    if client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint(bufnr, true)
    end
  end,      })

      -- C/C++ LSP
    lspconfig.clangd.setup({
      cmd = {
        "clangd",
        "--background-index",  -- Index project for better navigation
        "--completion-style=detailed", -- Detailed completion suggestions
        "--header-insertion=never", -- Don't auto-insert headers
        "--pch-storage=memory", -- Store precompiled headers in memory (faster)
        "--log=error", -- Reduce logging spam
        "--limit-results=50", -- Increase results limit
        "--fallback-style=Google", -- Code style fallback
        "--all-scopes-completion=false", -- Avoid irrelevant completions
        "--clang-tidy", -- Enable Clang-Tidy
        "--clang-tidy-checks=-*,performance-*,bugprone-*,-modernize-use-using,-misc-unused-using-decls", -- Clang-Tidy checks
        "--compile-commands-dir=.", -- Look for compile_commands.json
        "--suggest-missing-includes", -- Suggest missing includes
        "--completion-parse=auto", -- Auto parse for completions
        "--malloc-trim", -- Reduce memory fragmentation
        "--header-insertion-decorators=false", -- Disable header insertion decorators
        "--function-arg-placeholders=false", -- No fake arg placeholders
        "--inlay-hints", -- Enable inlay hints
      },
      filetypes = { "c", "cpp", "objc", "objcpp", "cuda" },
      root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".git"),
      capabilities = require("cmp_nvim_lsp").default_capabilities(), -- Enable LSP autocompletion
      on_attach = function(client, bufnr)
        local opts = { noremap = true, silent = true, buffer = bufnr }

        -- Keymaps for better LSP navigation
        vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
        vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
        vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
        vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

  end,
})

      -- CMake LSP (Fixed placement)
      lspconfig.cmake.setup({
        capabilities = capabilities,
        root_dir = util.root_pattern("CMakeLists.txt", "build"),
        filetypes = { "cmake" },
      })
    end,
  },

  -- 3) Autocompletion (nvim-cmp + luasnip + autopairs)
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",        -- snippet engine
      "saadparwaiz1/cmp_luasnip" -- snippet completions
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = true }), -- Accept completion
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function()
      local npairs = require("nvim-autopairs")
      npairs.setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      -- Automatically insert matching brackets/parentheses on confirm
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
}

