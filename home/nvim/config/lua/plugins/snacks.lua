require("snacks").setup({
  indent = {
    enabled = true,
    animate = { enabled = false },
  },
  dashboard = {
    enabled = true,
    width = 70,
    preset = {
      keys = {
        { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
        { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
        { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
        {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
        },
        { icon = " ", key = "i", desc = "Nix Config", action = ":cd ~/nix/ | lua Snacks.dashboard.pick('files')" },
        { icon = " ", key = "s", desc = "Restore Session", action = ":lua require('persistence').load()" },
        { icon = " ", key = "q", desc = "Quit", action = ":qa" },
      },
      header = "                                                                   \n"
        .. "      ████ ██████           █████      ██                    \n"
        .. "     ███████████             █████                            \n"
        .. "     █████████ ███████████████████ ███   ███████████  \n"
        .. "    █████████  ███    █████████████ █████ ██████████████  \n"
        .. "   █████████ ██████████ █████████ █████ █████ ████ █████  \n"
        .. " ███████████ ███    ███ █████████ █████ █████ ████ █████ \n"
        .. "██████  █████████████████████ ████ █████ █████ ████ ██████\n",
    },
    formats = {
      key = { "" },
    },
    sections = {
      { section = "header" },
      { section = "keys", gap = 1, padding = 1 },
      { section = "recent_files", icon = " ", title = "Recent Files", pane = 1, indent = 2, padding = 1 },
      { section = "projects", icon = " ", title = "Projects", pane = 1, indent = 2, padding = 1 },
    },
  },
  bigfile = {
    enabled = true,
  },
  input = {
    enabled = true,
  },
  notifier = {
    enabled = true,
  },
  statuscolumn = {
    enabled = true,
    folds = {
      open = true,
    },
  },
})

vim.keymap.set("n", "<leader>gb", require("snacks").git.blame_line, { desc = "blame", remap = true })
vim.keymap.set("n", "<leader>go", require("snacks").gitbrowse.open, { desc = "open in browser", remap = true })
vim.keymap.set(
  "n",
  "<leader>n",
  require("snacks").notifier.show_history,
  { desc = "show notification history", remap = true }
)
