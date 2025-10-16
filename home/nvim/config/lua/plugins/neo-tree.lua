local events = require("neo-tree.events")
local neotree = require("neo-tree")

-- Define the file move/rename handler
local function on_move(data)
  require("snacks.rename").on_rename_file(data.source, data.destination)
end

-- Setup Neo-tree with your existing config + event handlers
neotree.setup({
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
  event_handlers = {
    { event = events.FILE_MOVED, handler = on_move },
    { event = events.FILE_RENAMED, handler = on_move },
  },
})
