-- note that none-ls is a fork of null-ls, but the api is not changed from null-ls
local null_ls = require("null-ls")

null_ls.setup {
    sources = {
        null_ls.builtins.formatting.nixfmt,
    }
}
