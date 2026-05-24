local M = {}

function M.setup()
    local opts = {
        -- Directory to install parsers and queries to (prepended to `runtimepath` to have priority)
        install_dir = vim.fn.stdpath("data") .. "/site",
        sync_install = false,
        auto_install = true,
        ensure_installed = {
            "lua",
            "vim",
            "vimdoc",
            "query",
            "javascript",
            "typescript",
            "dockerfile",
            "regex",
            -- "dap_repl",
        },
        highlight = {
            enable = true,
            additional_vim_regex_highlighting = false,
        },
        -- autotag = {
        --     enable = true,
        -- },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-space>",
                node_incremental = "<C-space>",
                scope_incremental = false,
                node_decremental = "<bs>",
            },
        },
    }

    -- Manually adding site runtime path
    -- vim.opt.runtimepath:append(vim.fn.stdpath("data") .. "/site")

    vim.api.nvim_create_autocmd("FileType", {
        callback = function(args)
            local lang = vim.treesitter.language.get_lang(vim.bo[args.buf].filetype)
            if lang and pcall(vim.treesitter.start, args.buf) then
                -- started successfully
            end
        end,
    })

    require("nvim-treesitter").setup(opts)
    require("nvim-ts-autotag").setup()
    M.configure_textobjects()
    -- require("nvim-dap-repl-highlights").setup()

    -- local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
    --
    -- -- vim way: ; goes to the direction you were moving.
    -- vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move)
    -- vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_opposite)
    --
    -- -- Optionally, make builtin f, F, t, T also repeatable with ; and ,
    -- vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
    -- vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
    -- vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
    -- vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
end

function M.configure_textobjects()
    local select = require("nvim-treesitter-textobjects.select")
    -- local swap = require("nvim-treesitter-textobjects.swap")
    -- local move = require("nvim-treesitter-textobjects.move")

    require("nvim-treesitter-textobjects").setup({
        select = {
            -- Automatically jump forward to textobj, similar to targets.vim
            lookahead = true,

            -- Optional:
            -- selection_modes = {
            --     ["@function.outer"] = "V",
            --     ["@class.outer"] = "V",
            -- },

            -- Optional:
            -- include_surrounding_whitespace = false,
        },

        -- Only needed if you enable move mappings below
        move = {
            set_jumps = true,
        },
    })

    local function map_select(lhs, query, desc)
        vim.keymap.set({ "x", "o" }, lhs, function()
            select.select_textobject(query, "textobjects")
        end, { desc = desc })
    end

    -- assignments
    map_select("a=", "@assignment.outer", "Select outer part of an assignment")
    map_select("i=", "@assignment.inner", "Select inner part of an assignment")
    -- map_select("l=", "@assignment.lhs", "Select left hand side of an assignment")
    map_select("r=", "@assignment.rhs", "Select right hand side of an assignment")

    -- works for javascript/typescript files
    -- custom capture in after/queries/ecma/textobjects.scm
    map_select("a:", "@property.outer", "Select outer part of an object property")
    map_select("i:", "@property.inner", "Select inner part of an object property")
    -- map_select("l:", "@property.lhs", "Select left part of an object property")
    map_select("r:", "@property.rhs", "Select right part of an object property")

    -- parameters / arguments
    map_select("aa", "@parameter.outer", "Select outer part of a parameter/argument")
    map_select("ia", "@parameter.inner", "Select inner part of a parameter/argument")

    -- conditionals
    map_select("ai", "@conditional.outer", "Select outer part of a conditional")
    map_select("ii", "@conditional.inner", "Select inner part of a conditional")

    -- loops
    map_select("al", "@loop.outer", "Select outer part of a loop")
    map_select("il", "@loop.inner", "Select inner part of a loop")

    -- function calls
    map_select("af", "@call.outer", "Select outer part of a function call")
    map_select("if", "@call.inner", "Select inner part of a function call")

    -- function / method definitions
    map_select("am", "@function.outer", "Select outer part of a method/function definition")
    map_select("im", "@function.inner", "Select inner part of a method/function definition")

    -- classes
    map_select("ac", "@class.outer", "Select outer part of a class")
    map_select("ic", "@class.inner", "Select inner part of a class")

    -- swap mappings
    -- vim.keymap.set("n", "<leader>na", function()
    --     swap.swap_next("@parameter.inner")
    -- end, { desc = "Swap parameter/argument with next" })
    --
    -- vim.keymap.set("n", "<leader>n:", function()
    --     swap.swap_next("@property.outer")
    -- end, { desc = "Swap object property with next" })
    --
    -- vim.keymap.set("n", "<leader>nm", function()
    --     swap.swap_next("@function.outer")
    -- end, { desc = "Swap function with next" })
    --
    -- vim.keymap.set("n", "<leader>pa", function()
    --     swap.swap_previous("@parameter.inner")
    -- end, { desc = "Swap parameter/argument with previous" })
    --
    -- vim.keymap.set("n", "<leader>p:", function()
    --     swap.swap_previous("@property.outer")
    -- end, { desc = "Swap object property with previous" })
    --
    -- vim.keymap.set("n", "<leader>pm", function()
    --     swap.swap_previous("@function.outer")
    -- end, { desc = "Swap function with previous" })

    -- move mappings
    -- local function map_move(lhs, fn, query, query_group, desc)
    --     vim.keymap.set({ "n", "x", "o" }, lhs, function()
    --         fn(query, query_group or "textobjects")
    --     end, { desc = desc })
    -- end
    --
    -- map_move("]f", move.goto_next_start, "@call.outer", nil, "Next function call start")
    -- map_move("]m", move.goto_next_start, "@function.outer", nil, "Next method/function def start")
    -- map_move("]c", move.goto_next_start, "@class.outer", nil, "Next class start")
    -- map_move("]i", move.goto_next_start, "@conditional.outer", nil, "Next conditional start")
    -- map_move("]l", move.goto_next_start, "@loop.outer", nil, "Next loop start")
    -- map_move("]s", move.goto_next_start, "@scope", "locals", "Next scope")
    -- map_move("]z", move.goto_next_start, "@fold", "folds", "Next fold")
    --
    -- map_move("]F", move.goto_next_end, "@call.outer", nil, "Next function call end")
    -- map_move("]M", move.goto_next_end, "@function.outer", nil, "Next method/function def end")
    -- map_move("]C", move.goto_next_end, "@class.outer", nil, "Next class end")
    -- map_move("]I", move.goto_next_end, "@conditional.outer", nil, "Next conditional end")
    -- map_move("]L", move.goto_next_end, "@loop.outer", nil, "Next loop end")
    --
    -- map_move("[f", move.goto_previous_start, "@call.outer", nil, "Prev function call start")
    -- map_move("[m", move.goto_previous_start, "@function.outer", nil, "Prev method/function def start")
    -- map_move("[c", move.goto_previous_start, "@class.outer", nil, "Prev class start")
    -- map_move("[i", move.goto_previous_start, "@conditional.outer", nil, "Prev conditional start")
    -- map_move("[l", move.goto_previous_start, "@loop.outer", nil, "Prev loop start")
    --
    -- map_move("[F", move.goto_previous_end, "@call.outer", nil, "Prev function call end")
    -- map_move("[M", move.goto_previous_end, "@function.outer", nil, "Prev method/function def end")
    -- map_move("[C", move.goto_previous_end, "@class.outer", nil, "Prev class end")
    -- map_move("[I", move.goto_previous_end, "@conditional.outer", nil, "Prev conditional end")
    -- map_move("[L", move.goto_previous_end, "@loop.outer", nil, "Prev loop end")
end

return M
