return {
  {
    "neovim/nvim-lspconfig",

    opts = {
      -- Disable inlay hints globally.
      inlay_hints = {
        enabled = false,
      },

      servers = {
        -- C#
        csharp_ls = {
          root_markers = {
            "*.sln",
            "*.slnx",
            "*.csproj",
            ".git",
          },

          init_options = {
            AutomaticWorkspaceInit = true,
          },
        },

        -- JavaScript / TypeScript / React
        eslint = {
          settings = {
            codeAction = {
              disableRuleComment = {
                enable = true,
                location = "separateLine",
              },

              showDocumentation = {
                enable = true,
              },
            },

            codeActionOnSave = {
              enable = false,
              mode = "all",
            },

            format = false,

            nodePath = "",

            onIgnoredFiles = "off",

            packageManager = "npm",

            problems = {
              shortenToSingleLine = false,
            },

            quiet = true,

            run = "onSave",

            validate = "on",

            workingDirectory = {
              mode = "location",
            },
          },
        },

        -- Python
        pyright = {
          settings = {
            python = {
              analysis = {
                autoSearchPaths = true,
                diagnosticMode = "workspace",
                useLibraryCodeForTypes = true,
              },
            },
          },
        },

        -- PHP
        intelephense = {
          settings = {
            intelephense = {
              rootDirs = {},
              filetypes = {
                "php",
                "blade",
                "laravel",
              },
            },
          },
        },

        -- SQL
        sqls = {
          settings = {
            sqls = {
              connections = {},
            },
          },
        },
      },
    },
  },
}
