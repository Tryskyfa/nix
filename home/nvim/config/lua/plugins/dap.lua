local dap = require("dap")
local ui = require("dapui")

require("dapui").setup({})

require("nvim-dap-virtual-text").setup({
  -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
  display_callback = function(variable)
    if #variable.value > 15 then
      return " " .. string.sub(variable.value, 1, 15) .. "... "
    end

    return " " .. variable.value
  end,
})

vim.keymap.set("n", "<space>cb", dap.toggle_breakpoint, { desc = "Toggle Breakpoint" })
vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })

-- Eval var under cursor
vim.keymap.set("n", "<space>?", function()
  require("dapui").eval(nil, { enter = true })
end)

vim.keymap.set("n", "<F1>", dap.continue, { desc = "Dap continue" })
vim.keymap.set("n", "<F2>", dap.step_into, { desc = "Dap step into" })
vim.keymap.set("n", "<F3>", dap.step_over, { desc = "Dap step over" })
vim.keymap.set("n", "<F4>", dap.step_out, { desc = "Dap step out" })
vim.keymap.set("n", "<F5>", dap.step_back, { desc = "Dap step back" })
vim.keymap.set("n", "<F11>", dap.restart, { desc = "Dap restart" })
vim.keymap.set("n", "<F12>", dap.terminate, { desc = "Dap terminate" })

dap.listeners.before.attach.dapui_config = function()
  ui.open()
end
dap.listeners.before.launch.dapui_config = function()
  ui.open()
end
dap.listeners.before.event_terminated.dapui_config = function()
  ui.close()
end
dap.listeners.before.event_exited.dapui_config = function()
  ui.close()
end

require("dap-python").setup("python3")
