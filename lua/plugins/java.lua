return {
  {
    "mfussenegger/nvim-jdtls",
    ft = "java",
    dependencies = { "mason-org/mason.nvim" },
    config = function()
      local jdtls = require("jdtls")
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"

      local function start_jdtls()
        local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
        local workspace_dir = vim.fn.stdpath("data") .. "/jdtls/workspace/" .. project_name

        local capabilities = require("cmp_nvim_lsp").default_capabilities()

        local config = {
          cmd = { mason_bin .. "/jdtls", "-data", workspace_dir },
          root_dir = jdtls.setup.find_root({ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts" }),
          capabilities = capabilities,
          settings = {
            java = {
              eclipse = { downloadSources = true },
              configuration = { updateBuildConfiguration = "interactive" },
              maven = { downloadSources = true },
              implementationsCodeLens = { enabled = true },
              referencesCodeLens = { enabled = true },
              references = { includeDecompiledSources = true },
              format = { enabled = false },
            },
          },
          init_options = {
            bundles = {},
          },
          on_attach = function(client, bufnr)
            local bufopts = { noremap = true, silent = true, buffer = bufnr }
            vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
            vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
            vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
            vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
            vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
            vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)
            vim.keymap.set("n", "<leader>ji", jdtls.organize_imports, bufopts)
            vim.keymap.set("n", "<leader>jev", jdtls.extract_variable, bufopts)
            vim.keymap.set("v", "<leader>jev", "<Esc><Cmd>lua require('jdtls').extract_variable(true)<CR>", bufopts)
            vim.keymap.set("v", "<leader>jem", "<Esc><Cmd>lua require('jdtls').extract_method(true)<CR>", bufopts)
          end,
        }

        jdtls.start_or_attach(config)
      end

      vim.api.nvim_create_autocmd("FileType", {
        pattern = "java",
        callback = start_jdtls,
      })

      if vim.bo.filetype == "java" then
        start_jdtls()
      end
    end,
  },
}
