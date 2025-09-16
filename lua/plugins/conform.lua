return {
  "stevearc/conform.nvim",
  opts = {
    formatters_by_ft = {
      -- C#
      cs = { "csharpier" },
      -- JavaScript/TypeScript
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { "prettier" },
      typescriptreact = { "prettier" },
      -- Web languages
      html = { "prettier" },
      css = { "prettier" },
      scss = { "prettier" },
      json = { "prettier" },
      jsonc = { "prettier" },
      -- Python
      python = { "ruff_format", "ruff_organize_imports" },
      -- Markdown
      markdown = { "prettier" },
      -- YAML
      yaml = { "prettier" },
    },
    formatters = {
      csharpier = {},
      prettier = {
        command = vim.fn.stdpath("data") .. "/mason/bin/prettier",
        args = { "--stdin-filepath", "$FILENAME" },
      },
      ruff_format = {
        command = vim.fn.stdpath("data") .. "/mason/bin/ruff",
        args = { "format", "--stdin-filename", "$FILENAME", "-" },
      },
      ruff_organize_imports = {
        command = vim.fn.stdpath("data") .. "/mason/bin/ruff",
        args = { "check", "--select", "I", "--fix", "--stdin-filename", "$FILENAME", "-" },
      },
    },
  },
}
