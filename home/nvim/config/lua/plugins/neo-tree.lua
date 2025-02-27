require("neo-tree").setup({
  filesystem = {
    bind_to_cwd = false,
    follow_current_file = { enabled = true },
    window = {
      mappings = {
        ["<space>"] = "none",
        ["l"] = "open",
        ["h"] = "close_node",
      },
    },
  },
})
