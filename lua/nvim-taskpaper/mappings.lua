-- File: lua/nvim-taskpaper/mappings.lua
local M = {}

local function buf_map(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        options = vim.tbl_extend("force", options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.setup(bufnr)
    if vim.g.no_plugin_maps or vim.g.no_taskpaper_maps then
        return
    end

    -- Register which-key descriptions
    local ok, wk = pcall(require, "which-key")
    if ok then
        wk.register({
            ["<leader>t"] = {
                name = "TaskPaper",
                ["."] = { "Fold Notes" },
                ["P"] = { "Focus Project" },
                ["j"] = { "Next Project" },
                ["k"] = { "Previous Project" },
                ["g"] = { "Go to Project" },
                ["/"] = { "Search Keyword" },
                ["s"] = { "Search Tag" },
                ["d"] = { "Toggle Done" },
                ["t"] = { "Toggle Today" },
                ["x"] = { "Toggle Cancelled" },
                ["D"] = { "Archive Done" },
                ["T"] = { "Show Today" },
                ["X"] = { "Show Cancelled" },
            }
        })
    end

    local cmd_prefix = "<cmd>lua require('nvim-taskpaper')"
    
    -- Project navigation and folding
    buf_map(bufnr, "n", "<Leader>t.", cmd_prefix .. ".fold_notes()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tP", cmd_prefix .. ".focus_project()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tj", cmd_prefix .. ".next_project()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tk", cmd_prefix .. ".previous_project()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tg", cmd_prefix .. ".go_to_project()<CR>", {})

    -- Search functionality
    buf_map(bufnr, "n", "<Leader>t/", cmd_prefix .. ".search_keyword()<CR>", {})
    buf_map(bufnr, "n", "<Leader>ts", cmd_prefix .. ".search_tag()<CR>", {})

    -- Task status toggling
    buf_map(bufnr, "n", "<Leader>td", cmd_prefix .. ".toggle_done()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tt", cmd_prefix .. ".toggle_today()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tx", cmd_prefix .. ".toggle_cancelled()<CR>", {})

    -- Project/task management
    buf_map(bufnr, "n", "<Leader>tD", cmd_prefix .. ".archive_done()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tT", cmd_prefix .. ".show_today()<CR>", {})
    buf_map(bufnr, "n", "<Leader>tX", cmd_prefix .. ".show_cancelled()<CR>", {})
end

return M