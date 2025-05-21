return {
  -- Mason
  {
    "mason-org/mason.nvim",
    opts = {},
  },

  -- Mason LSP Config
  {
    "mason-org/mason-lspconfig.nvim",
    dependencies = {
      { "mason-org/mason.nvim", opts = {} },
      "neovim/nvim-lspconfig",
    },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "eslint",
          "jsonls",
          "lua_ls",
          "marksman",
          "pyright",
          "ruff",
          "tailwindcss",
          "ts_ls",
          "vtsls",
        },
      })
    end,
  },

  -- Native LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- Configure global diagnostics behavior
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        update_in_insert = false,
        severity_sort = true,
      })

      -- Diagnostic float on cursor hold
      vim.o.updatetime = 250
      vim.api.nvim_create_autocmd("CursorHold", {
        callback = function()
          vim.diagnostic.open_float(nil, {
            focusable = false,
            border = "rounded",
            source = "always",
            scope = "cursor",
          })
        end,
      })

      -- Keymaps for LSP
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, {})

      -- Lua LS config
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Python LS config
      vim.lsp.config("pyright", {})
      vim.lsp.config("ruff", {})

      -- TypeScript LS config
      vim.lsp.config("ts_ls", {})

      -- Enable LSPs
      vim.lsp.enable("lua_ls")
      vim.lsp.enable("pyright") -- To handle Python type checking
      vim.lsp.enable("ruff") -- To handle Python linting
      vim.lsp.enable("ts_ls")
    end,
  },
}
