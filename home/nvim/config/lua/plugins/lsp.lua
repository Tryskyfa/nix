local on_attach = function(_, bufnr)
  local bufmap = function(keys, func, desc)
    vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc, remap = true })
  end

  bufmap("<leader>cr", vim.lsp.buf.rename, "rename")
  bufmap("<leader>ca", vim.lsp.buf.code_action, "code_action")
  bufmap("<leader>cd", vim.diagnostic.open_float, "code diagnostic")

  bufmap("gd", require("telescope.builtin").lsp_definitions, "go definition")
  bufmap("gD", vim.lsp.buf.declaration, "go declaration")
  bufmap("gI", vim.lsp.buf.implementation, "go implementation")
  bufmap("<leader>D", vim.lsp.buf.type_definition, "go type definition")

  bufmap("gr", require("telescope.builtin").lsp_references, "list lsp references")
  bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols, "list lsp document symbols")
  bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols, "list lsp dynamic workspace symbols")

  bufmap("K", vim.lsp.buf.hover, "show info")

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, {})
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

require("lspconfig").lua_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function()
    return vim.loop.cwd()
  end,
  cmd = { "lua-language-server" },
  settings = {
    Lua = {
      workspace = { checkThirdParty = false },
      telemetry = { enable = false },
    },
  },
})
require("lazydev").setup({
  library = {
    { path = "luvit-meta/library", words = { "vim%.uv" } },
  },
})

require("lspconfig").nil_ls.setup({
  on_attach = on_attach,
  capabilities = capabilities,
})

require("lspconfig").clangd.setup({
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>", { buffer = bufnr })
  end,
  capabilities = capabilities,
  cmd = {
    "clangd",
    "--background-index",
    "--clang-tidy",
    "--header-insertion=iwyu",
    "--completion-style=detailed",
    "--function-arg-placeholders",
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
    clangdFileStatus = true,
  },
})

vim.lsp.enable("pyright")
vim.lsp.config("pyright", {
  on_attach = on_attach,
})

vim.lsp.enable("ruff")
vim.lsp.config("ruff", {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
})

vim.lsp.enable("tinymist")
vim.lsp.config("tinymist", {
  settings = {
    formatterMode = "typstyle",
    exportPdf = "onType",
    semanticTokens = "disable",
  },
  on_attach = function(client, bufnr)
    -- force-enable format autocommand for Tinymist
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          bufnr = bufnr,
          filter = function(client_filter)
            return client_filter.name == "tinymist"
          end,
        })
      end,
    })
  end,
  capabilities = capabilities,
})

vim.lsp.enable("hls")
vim.lsp.config("hls", {
  filetypes = { "haskell", "lhaskell", "cabal" },
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
})

vim.lsp.enable("sqls")
vim.lsp.config("sqls", {
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
  end,
})
