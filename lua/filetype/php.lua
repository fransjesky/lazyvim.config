-- PHP and Laravel filetype detection for better syntax highlighting
vim.filetype.add({
  extension = {
    php = "php",
    phtml = "php",
    phar = "php",
  },
  pattern = {
    [".*/config/.*\\.php$"] = "php",
    [".*/routes/.*\\.php$"] = "laravel",
    [".*/app/.*\\.php$"] = "php",
    [".*/public/.*\\.php$"] = "php",
  },
})

-- Register Treesitter parsers for PHP filetypes
vim.treesitter.language.register("php", "php")
