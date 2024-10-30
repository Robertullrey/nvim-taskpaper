-- File: plugin/taskpaper.lua

-- Prevent loading file twice
if vim.g.loaded_taskpaper then
    return
end
vim.g.loaded_taskpaper = true

-----------------------------------------------------------
-- Default Settings
-----------------------------------------------------------

-- Set up default global variables if they don't exist
vim.g.task_paper_date_format = vim.g.task_paper_date_format or "%Y-%m-%d"
vim.g.task_paper_archive_project = vim.g.task_paper_archive_project or "Archive"
vim.g.task_paper_follow_move = vim.g.task_paper_follow_move or 1
vim.g.task_paper_search_hide_done = vim.g.task_paper_search_hide_done or 0

-----------------------------------------------------------
-- Global Commands
-----------------------------------------------------------

-- Archive completed tasks
vim.api.nvim_create_user_command(
    'TaskPaperArchive',
    function()
        require('nvim-taskpaper').archive_done()
    end,
    {}
)

-- Show tasks marked with @today
vim.api.nvim_create_user_command(
    'TaskPaperToday',
    function()
        require('nvim-taskpaper').show_today()
    end,
    {}
)

-- Open project selection menu
vim.api.nvim_create_user_command(
    'TaskPaperProjects',
    function()
        require('nvim-taskpaper').go_to_project()
    end,
    {}
)