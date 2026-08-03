local M = {}

function M.setup()
    local theme = require("lualine.themes.nightfly")

    for _, mode in pairs(theme) do
        for section_name, section in pairs(mode) do
            if section_name ~= "a" then
                section.bg = "NONE"
            end
        end
    end

    require("lualine").setup({
        options = {
            theme = theme,
        },
    })
end

-- function M.setup()
--     local colors = {
--         red = "#ca1243",
--         grey = "#a0a1a7",
--         black = "#383a42",
--         white = "#f3f3f3",
--         light_green = "#83a598",
--         orange = "#fe8019",
--         green = "#8ec07c",
--     }

--     local theme = {
--         normal = {
--             a = { fg = colors.white, bg = colors.black },
--             b = { fg = colors.white, bg = colors.grey },
--             c = { fg = colors.black, bg = colors.white },
--             z = { fg = colors.white, bg = colors.black },
--         },
--         insert = { a = { fg = colors.black, bg = colors.light_green } },
--         visual = { a = { fg = colors.black, bg = colors.orange } },
--         replace = { a = { fg = colors.black, bg = colors.green } },
--     }

--     local empty = require("lualine.component"):extend()
--     function empty:draw(default_highlight)
--         self.status = ""
--         self.applied_separator = ""
--         self:apply_highlights(default_highlight)
--         self:apply_section_separators()
--         return self.status
--     end

--     -- Put proper separators and gaps between components in sections
--     local function process_sections(sections)
--         for name, section in pairs(sections) do
--             local left = name:sub(9, 10) < "x"
--             for pos = 1, name ~= "lualine_z" and #section or #section - 1 do
--                 table.insert(section, pos * 2, { empty, color = { fg = colors.white, bg = colors.white } })
--             end
--             for id, comp in ipairs(section) do
--                 if type(comp) ~= "table" then
--                     comp = { comp }
--                     section[id] = comp
--                 end
--                 comp.separator = left and { right = "" } or { left = "" }
--             end
--         end
--         return sections
--     end

--     local function search_result()
--         if vim.v.hlsearch == 0 then
--             return ""
--         end
--         local last_search = vim.fn.getreg("/")
--         if not last_search or last_search == "" then
--             return ""
--         end
--         local searchcount = vim.fn.searchcount({ maxcount = 9999 })
--         return last_search .. "(" .. searchcount.current .. "/" .. searchcount.total .. ")"
--     end

--     local function modified()
--         if vim.bo.modified then
--             return "+"
--         elseif vim.bo.modifiable == false or vim.bo.readonly == true then
--             return "-"
--         end
--         return ""
--     end

--     -- require("lualine").setup({
--     --     options = {
--     --         theme = "auto",
--     --         component_separators = "",
--     --     },
--     -- })
-- end

return M
