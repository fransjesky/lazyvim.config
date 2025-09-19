return {
  "nvim-treesitter/nvim-treesitter",
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "LazyFile", "VeryLazy" },
  lazy = vim.fn.argc(-1) == 0, -- load treesitter early when opening a file from the cmdline
  init = function(plugin)
    -- PERF: add nvim-treesitter queries to the rtp and it's custom query predicates early
    require("lazy.core.loader").add_to_rtp(plugin)
    pcall(require, "nvim-treesitter.query_predicates")
  end,
  cmd = { "TSUpdateSync", "TSUpdate", "TSInstall" },
  keys = {
    { "<c-space>", desc = "Increment Selection" },
    { "<bs>", desc = "Decrement Selection", mode = "x" },
  },
  opts = {
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
      "jsonc",
      "lua",
      "luadoc",
      "luap",
      "markdown",
      "markdown_inline",
      "printf",
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
    },
  },
  config = function(_, opts)
    -- Modern treesitter setup without configs module
    local ok, ts_config = pcall(require, "nvim-treesitter.config")
    if ok then
      -- Use the new API
      vim.treesitter.language.register("c_sharp", "cs")

      -- Enable highlighting only for supported filetypes
      vim.api.nvim_create_autocmd({ "BufEnter", "BufRead", "BufNewFile" }, {
        callback = function()
          local buf = vim.api.nvim_get_current_buf()
          local ft = vim.bo[buf].filetype

          -- Skip special/plugin filetypes and only enable for supported languages
          if ft ~= "" and not ft:match("^snacks_") and not ft:match("^lazy") and not ft:match("^mason") then
            -- Check if treesitter has a parser for this filetype
            local lang = vim.treesitter.language.get_lang(ft)
            if lang and pcall(vim.treesitter.language.add, lang) then
              vim.schedule(function()
                if vim.api.nvim_buf_is_valid(buf) then
                  pcall(vim.treesitter.start, buf)
                end
              end)
            end
          end
        end,
      })
    end

    -- Ensure parsers are installed
    if opts.ensure_installed then
      for _, lang in ipairs(opts.ensure_installed) do
        pcall(vim.treesitter.language.add, lang)
      end
    end
  end,
}
