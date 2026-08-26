-- React/JSX filetype detection for syntax highlighting
vim.filetype.add({
  extension = {
    ["jsx"] = "javascriptreact",
    ["tsx"] = "typescriptreact",
  },
})

-- Register Treesitter parsers for React filetypes
vim.treesitter.language.register("jsx", "javascriptreact")
vim.treesitter.language.register("typescript", "typescriptreact")
