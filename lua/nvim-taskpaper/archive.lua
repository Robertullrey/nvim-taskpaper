-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/archive.lua
local M = {}

-- Helper function to find the archive project or create it
local function ensure_archive_project()
    local archive_name = vim.g.task_paper_archive_project or "Archive"
    local last_line = vim.fn.line('$')
    
    -- Search for archive project
    local archive_line = vim.fn.search('^' .. archive_name .. ':', 'nw')
    
    if archive_line == 0 then
        -- Archive doesn't exist, create it at the end of file
        vim.api.nvim_buf_set_lines(0, last_line, last_line, false, {
            "",  -- Empty line before archive
            archive_name .. ":",
        })
        return last_line + 2
    end
    
    return archive_line + 1
end

function M.archive_done()
    -- Find or create archive section
    local archive_start = ensure_archive_project()
    local lines_to_move = {}
    local lines_to_delete = {}
    
    -- Collect all done tasks
    for i = 1, vim.fn.line('$') do
        local line = vim.fn.getline(i)
        if line:match("@done") and not line:match("^" .. vim.g.task_paper_archive_project .. ":") then
            table.insert(lines_to_move, line)
            table.insert(lines_to_delete, i)
        end
    end
    
    -- Move lines to archive
    if #lines_to_move > 0 then
        -- Insert lines into archive
        vim.api.nvim_buf_set_lines(0, archive_start, archive_start, false, lines_to_move)
        
        -- Delete original lines (in reverse order to maintain line numbers)
        for i = #lines_to_delete, 1, -1 do
            vim.api.nvim_buf_set_lines(0, lines_to_delete[i]-1, lines_to_delete[i], false, {})
        end
        
        print("Archived " .. #lines_to_move .. " completed tasks")
    else
        print("No completed tasks to archive")
    end
end

return M