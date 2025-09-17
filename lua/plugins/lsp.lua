return {
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "mason-org/mason.nvim",
      "mason-org/mason-lspconfig.nvim",
    },
    opts = {
      inlay_hints = { enabled = false },
    },
    config = function()
      local lspconfig = require("lspconfig")
      local mason_lspconfig = require("mason-lspconfig")

      -- Common LSP on_attach function
      local on_attach = function(client, bufnr)
        -- Enable completion triggered by <c-x><c-o>
        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

        -- Mappings
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
        vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
        vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
        vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
        vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
        vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
        vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
        vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
        vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
        vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
      end

      -- Setup mason-lspconfig handlers
      mason_lspconfig.setup_handlers({
        -- Default handler
        function(server_name)
          lspconfig[server_name].setup({
            on_attach = on_attach,
          })
        end,

        -- C# specific configuration
        ["csharp_ls"] = function()
          lspconfig.csharp_ls.setup({
            root_dir = lspconfig.util.root_pattern("*.sln", "*.csproj", ".git"),
            init_options = {
              AutomaticWorkspaceInit = true,
            },
            on_attach = on_attach,
          })
        end,

        -- TypeScript/JavaScript configuration
        ["vtsls"] = function()
          lspconfig.vtsls.setup({
            on_attach = on_attach,
            settings = {
              complete_function_calls = true,
              vtsls = {
                enableMoveToFileCodeAction = true,
                autoUseWorkspaceTsdk = true,
                experimental = {
                  completion = {
                    enableServerSideFuzzyMatch = true,
                  },
                },
              },
              typescript = {
                updateImportsOnFileMove = { enabled = "always" },
                suggest = {
                  completeFunctionCalls = true,
                },
                inlayHints = {
                  enumMemberValues = { enabled = true },
                  functionLikeReturnTypes = { enabled = true },
                  parameterNames = { enabled = "literals" },
                  parameterTypes = { enabled = true },
                  propertyDeclarationTypes = { enabled = true },
                  variableTypes = { enabled = false },
                },
              },
            },
          })
        end,

        -- ESLint configuration
        ["eslint"] = function()
          lspconfig.eslint.setup({
            on_attach = on_attach,
            settings = {
              codeAction = {
                disableRuleComment = {
                  enable = true,
                  location = "separateLine"
                },
                showDocumentation = {
                  enable = true
                }
              },
              codeActionOnSave = {
                enable = false,
                mode = "all"
              },
              experimental = {
                useFlatConfig = false
              },
              format = true,
              nodePath = "",
              onIgnoredFiles = "off",
              packageManager = "npm",
              problems = {
                shortenToSingleLine = false
              },
              quiet = false,
              rulesCustomizations = {},
              run = "onType",
              useESLintClass = false,
              validate = "on",
              workingDirectory = {
                mode = "location"
              }
            },
          })
        end,

        -- Python configuration
        ["pyright"] = function()
          lspconfig.pyright.setup({
            on_attach = on_attach,
            settings = {
              python = {
                analysis = {
                  autoSearchPaths = true,
                  diagnosticMode = "workspace",
                  useLibraryCodeForTypes = true,
                },
              },
            },
          })
        end,
      })
    end,
  },
}
