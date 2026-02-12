vim.api.nvim_create_user_command("Bikecost", function()
  local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)

  local new_lines = {}
  local category_sum = 0
  local grand_total = 0

  local function extract_price(line)
    local price = line:match("([0-9]+%.[0-9]+)€")
    if price then
      return tonumber(price)
    end
    return nil
  end

  for _, line in ipairs(lines) do
    -- new category starts
    if line:match("^# ") then
      category_sum = 0
      table.insert(new_lines, line)

    -- expense line
    elseif line:match("^%- ") then
      local price = extract_price(line)
      if price then
        category_sum = category_sum + price
        grand_total = grand_total + price
      end
      table.insert(new_lines, line)

    -- category total line -> replace
    elseif line:match("^Total:") then
      table.insert(new_lines, string.format("Total: %.2f€", category_sum))

    -- grand total line
    elseif line:match("^## Total") then
      table.insert(new_lines, string.format("## Total %.2f€", grand_total))
    else
      table.insert(new_lines, line)
    end
  end

  vim.api.nvim_buf_set_lines(0, 0, -1, false, new_lines)
end, {})
