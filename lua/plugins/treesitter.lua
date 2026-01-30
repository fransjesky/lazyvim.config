return {
  "nvim-treesitter/nvim-treesitter",
  version = false,
  build = ":TSUpdate",
  event = { "LazyFile", "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0,
  init = function(plugin)
    require("lazy.core.loader").add_to_rtp(plugin)
    pcall(require, "nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  opts_extend = { "ensure_installed" },
  opts = {
    highlight = { enable = true },
    indent = { enable = true },
    ensure_installed = {
      "bash",
      "c",
      "c_sharp",
      "css",
      "diff",
      "html",
      "javascript",
      "jsdoc",
      "json",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
      "prisma",
      "python",
      "query",
      "regex",
      "toml",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "xml",
      "yaml",
      "sql",
    },
  },
  config = function(_, opts)
    -- Register custom language mappings
    vim.treesitter.language.register("c_sharp", "cs")
    vim.treesitter.language.register("prisma", "prisma")

    -- Register XAML/AXAML to use XML treesitter parser for syntax highlighting
    vim.treesitter.language.register("xml", "xaml")
    vim.treesitter.language.register("xml", "axaml")

    -- Ensure XAML and AXAML (Avalonia) files are recognized
    vim.filetype.add({
      extension = {
        xaml = "xaml",
        axaml = "axaml",
      },
    })

    -- Enable highlight and indent if configured
    if opts.highlight and opts.highlight.enable then
      vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
          local buf = args.buf
          local ft = vim.bo[buf].filetype
          if ft ~= "" and not ft:match("^snacks_") and not ft:match("^lazy") and not ft:match("^mason") then
            pcall(vim.treesitter.start, buf)
          end
        end,
      })
    end
  end,
}
