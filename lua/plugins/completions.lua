return {
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "hrsh7th/cmp-buffer",
  },
  {
    "L3MON4D3/LuaSnip",
    dependencies = {
      "saadparwaiz1/cmp_luasnip",
      "rafamadriz/friendly-snippets",
    },
  },
  {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      -- Load all friendly-snippets
      require("luasnip.loaders.from_vscode").lazy_load()

      -- Load HTML snippets for React files
      luasnip.filetype_extend("javascriptreact", { "html", "javascript" })
      luasnip.filetype_extend("typescriptreact", { "html", "typescript", "javascript" })

      -- Load JavaScript snippets for TypeScript
      luasnip.filetype_extend("typescript", { "javascript" })

      -- Load additional snippets for C#
      luasnip.filetype_extend("cs", { "csharp" })

      -- Load additional snippets for Python
      luasnip.filetype_extend("python", { "django" })

      -- Add custom C# snippets
      luasnip.add_snippets("cs", {
        luasnip.snippet("class", {
          luasnip.text_node("public class "),
          luasnip.insert_node(1, "ClassName"),
          luasnip.text_node({"", "{", "\t"}),
          luasnip.insert_node(2, "// TODO: Implement"),
          luasnip.text_node({"", "}"}),
        }),
        luasnip.snippet("prop", {
          luasnip.text_node("public "),
          luasnip.insert_node(1, "string"),
          luasnip.text_node(" "),
          luasnip.insert_node(2, "PropertyName"),
          luasnip.text_node(" { get; set; }"),
        }),
        luasnip.snippet("method", {
          luasnip.text_node("public "),
          luasnip.insert_node(1, "void"),
          luasnip.text_node(" "),
          luasnip.insert_node(2, "MethodName"),
          luasnip.text_node("("),
          luasnip.insert_node(3),
          luasnip.text_node({")", "{", "\t"}),
          luasnip.insert_node(4, "// TODO: Implement"),
          luasnip.text_node({"", "}"}),
        }),
      })

      -- Add custom JavaScript/TypeScript snippets
      luasnip.add_snippets("javascript", {
        luasnip.snippet("func", {
          luasnip.text_node("function "),
          luasnip.insert_node(1, "functionName"),
          luasnip.text_node("("),
          luasnip.insert_node(2),
          luasnip.text_node({") {", "\t"}),
          luasnip.insert_node(3, "// TODO: Implement"),
          luasnip.text_node({"", "}"}),
        }),
        luasnip.snippet("arrowf", {
          luasnip.text_node("const "),
          luasnip.insert_node(1, "functionName"),
          luasnip.text_node(" = ("),
          luasnip.insert_node(2),
          luasnip.text_node(") => {"),
          luasnip.text_node({"", "\t"}),
          luasnip.insert_node(3, "// TODO: Implement"),
          luasnip.text_node({"", "}"}),
        }),
        luasnip.snippet("asyncf", {
          luasnip.text_node("const "),
          luasnip.insert_node(1, "functionName"),
          luasnip.text_node(" = async ("),
          luasnip.insert_node(2),
          luasnip.text_node(") => {"),
          luasnip.text_node({"", "\t"}),
          luasnip.insert_node(3, "// TODO: Implement"),
          luasnip.text_node({"", "}"}),
        }),
      })

      -- Add custom React snippets
      luasnip.add_snippets("javascriptreact", {
        luasnip.snippet("rfc", {
          luasnip.text_node("const "),
          luasnip.insert_node(1, "ComponentName"),
          luasnip.text_node({" = () => {", "\treturn (", "\t\t<div>"}),
          luasnip.insert_node(2, "Component content"),
          luasnip.text_node({"</div>", "\t)", "}", "", "export default "}),
          luasnip.dynamic_node(3, function(args)
            return luasnip.snippet_node(nil, {luasnip.text_node(args[1][1])})
          end, {1}),
        }),
        luasnip.snippet("useState", {
          luasnip.text_node("const ["),
          luasnip.insert_node(1, "state"),
          luasnip.text_node(", set"),
          luasnip.function_node(function(args)
            return args[1][1]:gsub("^%l", string.upper)
          end, {1}),
          luasnip.text_node("] = useState("),
          luasnip.insert_node(2, "initialValue"),
          luasnip.text_node(")"),
        }),
        luasnip.snippet("useEffect", {
          luasnip.text_node({"useEffect(() => {", "\t"}),
          luasnip.insert_node(1, "// Effect logic"),
          luasnip.text_node({"", "}, ["}),
          luasnip.insert_node(2),
          luasnip.text_node("])"),
        }),
      })

      -- Add custom TypeScript React snippets
      luasnip.add_snippets("typescriptreact", {
        luasnip.snippet("rfc", {
          luasnip.text_node("interface "),
          luasnip.insert_node(1, "ComponentName"),
          luasnip.text_node({"Props {", "\t"}),
          luasnip.insert_node(2, "// Props interface"),
          luasnip.text_node({"", "}", "", "const "}),
          luasnip.dynamic_node(3, function(args)
            return luasnip.snippet_node(nil, {luasnip.text_node(args[1][1])})
          end, {1}),
          luasnip.text_node(": React.FC<"),
          luasnip.dynamic_node(4, function(args)
            return luasnip.snippet_node(nil, {luasnip.text_node(args[1][1])})
          end, {1}),
          luasnip.text_node({"Props> = () => {", "\treturn (", "\t\t<div>"}),
          luasnip.insert_node(5, "Component content"),
          luasnip.text_node({"</div>", "\t)", "}", "", "export default "}),
          luasnip.dynamic_node(6, function(args)
            return luasnip.snippet_node(nil, {luasnip.text_node(args[1][1])})
          end, {1}),
        }),
      })

      -- Add custom Python snippets
      luasnip.add_snippets("python", {
        luasnip.snippet("def", {
          luasnip.text_node("def "),
          luasnip.insert_node(1, "function_name"),
          luasnip.text_node("("),
          luasnip.insert_node(2),
          luasnip.text_node({"):", "\t"}),
          luasnip.insert_node(3, '"""TODO: Implement"""'),
          luasnip.text_node({"", "\tpass"}),
        }),
        luasnip.snippet("class", {
          luasnip.text_node("class "),
          luasnip.insert_node(1, "ClassName"),
          luasnip.text_node({":", "\tdef __init__(self"}),
          luasnip.insert_node(2),
          luasnip.text_node({"):", "\t\t"}),
          luasnip.insert_node(3, "pass"),
        }),
        luasnip.snippet("ifmain", {
          luasnip.text_node({"if __name__ == '__main__':", "\t"}),
          luasnip.insert_node(1, "main()"),
        }),
      })

      cmp.setup({
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ["<C-b>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.abort(),
          ["<CR>"] = cmp.mapping.confirm({ select = false }),
          ["<Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              if cmp.get_selected_entry() then
                cmp.confirm({ select = true })
              else
                cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
              end
            elseif require("luasnip").expand_or_jumpable() then
              require("luasnip").expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" }, -- For luasnip users.
        }, {
          { name = "buffer" },
        }),
      })

      -- Specific setup for TypeScript/JavaScript React files
      cmp.setup.filetype({ "typescriptreact", "javascriptreact" }, {
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
}
