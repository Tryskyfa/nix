require("which-key").setup({
  preset = "helix",
  spec = {
    {
      mode = { "n", "v" },
      { "<leader>c", group = "code" },
      { "<leader>f", group = "file/find" },
      { "<leader>g", group = "git" },
      { "<leader>q", group = "session" },
      { "<leader>b", group = "buffer" },
      { "<leader>w", group = "windows" },
    },
  },
})

-- Optional: register extra keybindings for showing which-key menus
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Keymaps (which-key)" })
