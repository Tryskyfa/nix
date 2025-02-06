local on_attach = function(_, bufnr)
  local bufmap = function(keys, func)
    vim.keymap.set("n", keys, func, { buffer = bufnr })
  end

  bufmap("<leader>cr", vim.lsp.buf.rename)
  bufmap("<leader>ca", vim.lsp.buf.code_action)

  bufmap("gd", vim.lsp.buf.definition)
  bufmap("gD", vim.lsp.buf.declaration)
  bufmap("gI", vim.lsp.buf.implementation)
  bufmap("<leader>D", vim.lsp.buf.type_definition)

  bufmap("gr", require("telescope.builtin").lsp_references)
  bufmap("<leader>s", require("telescope.builtin").lsp_document_symbols)
  bufmap("<leader>S", require("telescope.builtin").lsp_dynamic_workspace_symbols)

  bufmap("K", vim.lsp.buf.hover)

  vim.api.nvim_buf_create_user_command(bufnr, "Format", function(_)
    vim.lsp.buf.format()
  end, {})
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
local create_format_autocommand = function(client, bufnr, name)
  if client.supports_method("textDocument/formatting") then
    vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
    vim.api.nvim_create_autocmd("BufWritePre", {
      group = augroup,
      buffer = bufnr,
      callback = function()
        vim.lsp.buf.format({
          async = false,
          bufnr = bufnr,
          filter = function(client_filter)
            return client_filter.name == name
          end,
        })
      end,
    })
  end
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
    create_format_autocommand(client, bufnr, "clangd")
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
