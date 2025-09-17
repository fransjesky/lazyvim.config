return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- C#
        "csharp-language-server",
        "csharpier",
        -- JavaScript/TypeScript
        "typescript-language-server",
        "eslint-lsp",
        "prettier",
        -- Python
        "pyright",
        "ruff",
        "black",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "csharp_ls",
        "ts_ls",
        "eslint",
        "pyright",
      },
      automatic_installation = true,
    },
  },
}
