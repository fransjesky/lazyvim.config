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
      -- Prisma
      prisma = { "prisma" },
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
      prisma = {
        command = function(self, ctx)
          -- Find node_modules/.bin/prisma relative to the file
          local util = require("conform.util")
          local root = util.root_file({ "package.json" })(self, ctx)
          if root then
            local local_prisma = root .. "/node_modules/.bin/prisma"
            if vim.fn.executable(local_prisma) == 1 then
              return local_prisma
            end
          end
          return "npx"
        end,
        args = function(self, ctx)
          local util = require("conform.util")
          local root = util.root_file({ "package.json" })(self, ctx)
          if root and vim.fn.executable(root .. "/node_modules/.bin/prisma") == 1 then
            return { "format", "--schema", "$FILENAME" }
          end
          return { "prisma", "format", "--schema", "$FILENAME" }
        end,
        stdin = false,
        cwd = require("conform.util").root_file({ "package.json" }),
        require_cwd = true,
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
