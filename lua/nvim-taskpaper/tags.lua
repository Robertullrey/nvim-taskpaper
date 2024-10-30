-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/tags.lua
local M = {}

function M.toggle_tag(tag, with_date)
    -- Get current line
    local line = vim.api.nvim_get_current_line()
    local tag_pattern = "@" .. tag
    if with_date then
        tag_pattern = tag_pattern .. "%(%d%d%d%d%-%d%d%-%d%d%)"
    end
    
    if line:match(tag_pattern) then
        -- Remove tag
        line = line:gsub("%s*" .. tag_pattern, "")
    else
        -- Add tag
        if with_date then
            local date = os.date(vim.g.task_paper_date_format)
            line = line .. " @" .. tag .. "(" .. date .. ")"
        else
            line = line .. " @" .. tag
        end
    end
    -- Set the line
    vim.api.nvim_set_current_line(line)
end

function M.toggle_done()
    M.toggle_tag("done", true)
end

function M.toggle_today()
    M.toggle_tag("today", false)
end

function M.toggle_cancelled()
    M.toggle_tag("cancelled", true)
end

function M.show_tag(tag)
    vim.cmd("normal! /@" .. tag .. "\\c\\<CR>")
end

function M.show_today()
    M.show_tag("today")
end

function M.show_cancelled()
    M.show_tag("cancelled")
end

return M