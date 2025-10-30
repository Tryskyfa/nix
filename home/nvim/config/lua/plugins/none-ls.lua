local conform = require("conform")

conform.setup({
  formatters_by_ft = {
    lua = { "stylua" },
    nix = { "nixfmt" },
    tex = { "tex-fmt" },
  },
  format_on_save = {
    lsp_format = "fallback",
    timeout_ms = 500,
  },
})
