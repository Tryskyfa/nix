local map = vim.keymap.set

-- Move to window using the <ctrl> hjkl keys
-- Fallback because vim-tmux-navigator should do this
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true })
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true })
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true })
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
map("n", "<A-j>", "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
map("n", "<A-k>", "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
map("i", "<A-j>", "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Add undo break-points
map("i", ",", ",<c-g>u")
map("i", ".", ".<c-g>u")
map("i", ";", ";<c-g>u")
map("i", "<space>", "<space><c-g>u")
map("i", "<cr>", "<cr><c-g>u")

-- save file
map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save File" })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- windows
map("n", "<leader>-", "<C-W>s", { desc = "Split Window Below", remap = true })
map("n", "<leader>|", "<C-W>v", { desc = "Split Window Right", remap = true })
map("n", "<leader>wd", "<C-W>c", { desc = "Delete Window", remap = true })

-- clear search
map("n", "<esc>", "<cmd>noh<cr>", { desc = "clear search", remap = true })

-- neo-tree
map("n", "<leader>e", function()
  require("neo-tree.command").execute({ toggle = true })
end, { desc = "Open neo-tree", remap = true })

-- buffers / bufferline
map("n", "H", "<Cmd>BufferLineCyclePrev<CR>", { desc = "Prev Buffer", remap = true })
map("n", "L", "<Cmd>BufferLineCycleNext<CR>", { desc = "Next Buffer", remap = true })
map("n", "<leader>bl", "<Cmd>BufferLineCloseLeft<CR>", { desc = "Delete Buffers to the Left", remap = true })
map("n", "<leader>br", "<Cmd>BufferLineCloseRight<CR>", { desc = "Delete Buffers to the Right", remap = true })
map("n", "<leader>bd", function()
  require("snacks").bufdelete()
end, { desc = "Delete current buffer", remap = true })

-- telescope
map("n", "<leader><space>", function()
  require("telescope.builtin").git_files()
end, { desc = "Find git files", remap = true })
map("n", "<leader>ff", function()
  require("telescope.builtin").find_files({ hidden = true, no_ignore = true, no_ignore_parent = true })
end, { desc = "Find files", remap = true })
map("n", "<leader>/", function()
  require("telescope.builtin").live_grep()
end, { desc = "Grep files", remap = true })

-- lazygit
map("n", "<leader>gg", function()
  Snacks.lazygit()
end, { desc = "Open lazygit", remap = true })

-- mini.surround disable default "s" behavior
map({ "n", "x" }, "s", "<Nop>")
