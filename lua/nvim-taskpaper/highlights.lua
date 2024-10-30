-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/highlights.lua
local M = {}

function M.setup()
    -- Syntax Highlighting Groups
    vim.api.nvim_set_hl(0, 'TaskPaperProject', { fg = '#87afff', bold = true })
    vim.api.nvim_set_hl(0, 'TaskPaperListItem', { fg = '#5f87af' })
    vim.api.nvim_set_hl(0, 'TaskPaperTag', { fg = '#d75f5f', italic = true })
    vim.api.nvim_set_hl(0, 'TaskPaperDone', { fg = '#5f8787', strikethrough = true })
    vim.api.nvim_set_hl(0, 'TaskPaperCancelled', { fg = '#5f8787', strikethrough = true })
    vim.api.nvim_set_hl(0, 'TaskPaperUrgent', { fg = '#ff5f5f', bold = true })
    vim.api.nvim_set_hl(0, 'TaskPaperToday', { fg = '#ffaf00', bold = true })
    vim.api.nvim_set_hl(0, 'TaskPaperDate', { fg = '#87af87' })

    -- Clear existing matches (in case of reloading)
    vim.fn.clearmatches()

    -- Syntax Matching with improved patterns
    -- Projects (both standalone and with @project tag)
    vim.fn.matchadd("TaskPaperProject", [[\v^[^\t\- ].*:$]])  -- Project ending with colon
    vim.fn.matchadd("TaskPaperProject", [[@project\([^)]*\)]])  -- @project tag with optional date

    -- List items
    vim.fn.matchadd("TaskPaperListItem", [[^\s*\- ]])

    -- Basic tags (like @tag or @tag(value))
    vim.fn.matchadd("TaskPaperTag", [[@\w\+\(([^)]*)\)\?]])

    -- Special tags with their specific highlights
    vim.fn.matchadd("TaskPaperDone", [[@done\(([^)]*)\)\?]])
    vim.fn.matchadd("TaskPaperCancelled", [[@cancelled\(([^)]*)\)\?]])
    vim.fn.matchadd("TaskPaperUrgent", [[@urgent\(([^)]*)\)\?]])
    vim.fn.matchadd("TaskPaperToday", [[@today\(([^)]*)\)\?]])

    -- Dates in tags (e.g., @done(2024-01-01))
    vim.fn.matchadd("TaskPaperDate", [[\d\{4\}-\d\{2\}-\d\{2\}]])

    -- Debug print
    print("TaskPaper syntax highlighting setup complete")
end

return M