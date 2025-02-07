local M = {}

function M.extract_highlight_colors(color_group, scope)
  local color = require('lualine.highlight').get_lualine_hl(color_group)
  if not color then
    if vim.fn.hlexists(color_group) == 0 then
      return nil
    end
    color = vim.api.nvim_get_hl_by_name(color_group, true)
    if color.background ~= nil then
      color.bg = string.format('#%06x', color.background)
      color.background = nil
    end
    if color.foreground ~= nil then
      color.fg = string.format('#%06x', color.foreground)
      color.foreground = nil
    end
    if color.special ~= nil then
      color.sp = string.format('#%06x', color.special)
      color.special = nil
    end
  end
  if scope then
    return color[scope]
  end
  return color
end

return M
