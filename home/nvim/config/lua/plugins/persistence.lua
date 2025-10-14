require("persistence").setup({})
local map = vim.keymap.set
-- load the session for the current directory
map("n", "<leader>qs", function()
  require("persistence").load()
end)
-- select a session to load
map("n", "<leader>qS", function()
  require("persistence").select()
end)
-- load the last session
map("n", "<leader>ql", function()
  require("persistence").load({ last = true })
end)
-- stop Persistence => session won't be saved on exit
map("n", "<leader>qd", function()
  require("persistence").stop()
end)
