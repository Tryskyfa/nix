require("lualine").setup({
  options = {
    icons_enabled = true,
    globalstatus = true,
  },
  sections = {
    lualine_x = {
      {
        require("noice").api.status.mode.get,
        cond = require("noice").api.status.mode.has,
      },
      "encoding",
      "fileformat",
      "filetype",
    },
  },
})
