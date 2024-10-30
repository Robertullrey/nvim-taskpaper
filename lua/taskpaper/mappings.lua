-- File: lua/taskpaper/mappings.lua
local M = {}

-- Key mapping helper function
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

    -- Normal mode mappings
    buf_map(bufnr, "n", "<Leader>tp", ":lua require('taskpaper').fold_projects()<CR>", {})
    buf_map(bufnr, "n", "<Leader>t.", ":lua require('taskpaper').search('\\v^(\\s*\\|\\t+-\\s+.*\\|.+:)$')<CR>", {})
    -- ... other mappings ...
end

return M
