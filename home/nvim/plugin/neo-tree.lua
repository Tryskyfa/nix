require('neo-tree').setup()
vim.keymap.set('n', 'e', function() require('neo-tree.command').execute({ toggle = true }) end, { desc = "Open neo-tree" })
