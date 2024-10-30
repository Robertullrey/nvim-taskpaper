-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/folding.lua
local M = {}

-- Helper function to get indent level
local function get_indent_level(line)
    return #(line:match("^%s*") or "")
end

function M.fold_projects()
    -- Implementation for basic folding of projects
    local current_line = vim.fn.line('.')
    local last_line = vim.fn.line('$')
    
    -- Find the next project line using proper pattern matching
    local next_project = vim.fn.search('^[^%s%-].*:$', 'nW')
    if next_project == 0 then
        next_project = last_line + 1
    end
    
    -- Create fold from current line to next project
    vim.cmd(current_line .. ',' .. (next_project-1) .. 'fold')
end

function M.fold_notes()
    -- Get current line and its indent level
    local current_line = vim.fn.line('.')
    local current_indent = get_indent_level(vim.fn.getline(current_line))
    local last_line = vim.fn.line('$')
    
    -- Find the next line with same or less indent
    local fold_end = current_line
    for i = current_line + 1, last_line do
        local line = vim.fn.getline(i)
        if get_indent_level(line) <= current_indent and line:match("^%s*[^%s%-]") then
            fold_end = i - 1
            break
        elseif i == last_line then
            fold_end = last_line
        end
    end
    
    -- Create fold if there are lines to fold
    if fold_end > current_line then
        vim.cmd(current_line .. ',' .. fold_end .. 'fold')
    end
end

return M