return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        blade = { "blade-formatter" },
        php = { "php_cs_fixer" },
      },
      default_format_opts = {
        lsp_format = "never",
      },
    },
  },
}
