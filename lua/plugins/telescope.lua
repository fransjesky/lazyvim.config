return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      file_ignore_patterns = {},
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden", -- show hidden files
        "--glob=!**/.git/*", -- still ignore .git
      },
    },
    pickers = {
      find_files = {
        hidden = true,
        no_ignore = true,
      },
    },
  },
}
