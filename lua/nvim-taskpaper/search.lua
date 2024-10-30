-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/search.lua
local M = {}

function M.search(pattern)
    print("search called with pattern: " .. pattern)
    local search_command = '/' .. pattern
    vim.cmd(search_command)
end

function M.search_keyword()
    -- Prompt for keyword search
    local keyword = vim.fn.input("Search keyword: ")
    if keyword ~= "" then
        vim.cmd("normal! /" .. keyword .. "\\c\\<CR>")
    end
end

function M.search_tag()
    -- Prompt for tag search
    local tag = vim.fn.input("Search tag: ")
    if tag ~= "" then
        if not tag:match("^@") then
            tag = "@" .. tag
        end
        vim.cmd("normal! /" .. tag .. "\\c\\<CR>")
    end
end

return M