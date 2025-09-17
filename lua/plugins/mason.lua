return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        -- C#
        "csharp-language-server",
        "csharpier",
        -- JavaScript/TypeScript
        "vtsls",
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
        "vtsls",
        "eslint",
        "pyright",
      },
      automatic_installation = true,
    },
  },
}
