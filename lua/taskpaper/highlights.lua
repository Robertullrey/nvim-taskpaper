-- File: lua/taskpaper/highlights.lua
local M = {}

function M.setup()
    -- Syntax Highlighting
    vim.api.nvim_set_hl(0, 'TaskPaperProject', { fg = '#87afff', bold = true })
    vim.api.nvim_set_hl(0, 'TaskPaperListItem', { fg = '#5f87af' })
    vim.api.nvim_set_hl(0, 'TaskPaperTag', { fg = '#d75f5f', italic = true })
    vim.api.nvim_set_hl(0, 'TaskPaperDone', { fg = '#5f8787', strikethrough = true })
    vim.api.nvim_set_hl(0, 'TaskPaperUrgent', { fg = '#ff5f5f', bold = true })
    vim.api.nvim_set_hl(0, 'TaskPaperToday', { fg = '#ffaf00', bold = true })

    -- Syntax Matching
    vim.fn.matchadd("TaskPaperProject", "^.+:$")
    vim.fn.matchadd("TaskPaperListItem", "^%s*%- ")
    vim.fn.matchadd("TaskPaperTag", "@%w+")
    vim.fn.matchadd("TaskPaperDone", "@done")
    vim.fn.matchadd("TaskPaperUrgent", "@urgent")
    vim.fn.matchadd("TaskPaperToday", "@today")
end

return M
