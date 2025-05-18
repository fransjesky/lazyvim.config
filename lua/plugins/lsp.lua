return {
  -- Mason
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup()
    end,
  },

  -- Mason LSP Config
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "lua_ls", "pyright", "ts_ls" },
      })
    end,
  },

  -- Native LSP Config
  {
    "neovim/nvim-lspconfig",
    config = function()
      -- General Setup (Keymapping)
      vim.keymap.set("n", "K", vim.lsp.buf.hover, {})
      vim.keymap.set("n", "gd", vim.lsp.buf.definition, {})
      vim.keymap.set({ "n" }, "<leader>ca", vim.lsp.buf.code_action, {})

      -- Setup for Lua
      vim.lsp.enable("lua_ls")
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            diagnostics = {
              globals = { "vim" },
            },
          },
        },
      })

      -- Setup for Python
      vim.lsp.enable("pyright")

      -- Setup for TypeScript
      vim.lsp.enable("ts_ls")
    end,
  },
}
