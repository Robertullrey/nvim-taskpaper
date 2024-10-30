-- File: ~/.config/nvim/lua/plugins/taskpaper.lua (your Lazy plugin spec)
return {
    "your-username/nvim-taskpaper",
    ft = "taskpaper",
    config = function()
        require("taskpaper").setup()
    end
}

-- File: lua/taskpaper/init.lua (main plugin file)
local M = {}

function M.setup(opts)
    opts = opts or {}
    
    -- Define default settings
    vim.g.task_paper_date_format = opts.date_format or "%Y-%m-%d"
    vim.g.task_paper_archive_project = opts.archive_project or "Archive"
    vim.g.task_paper_follow_move = opts.follow_move or 1
    vim.g.task_paper_search_hide_done = opts.search_hide_done or 0
    
    -- Set up autocmd for filetype detection
    vim.api.nvim_create_autocmd({"BufRead", "BufNewFile"}, {
        pattern = {"*.taskpaper"},
        callback = function(ev)
            if vim.b[ev.buf].did_ftplugin then
                return
            end
            vim.b[ev.buf].did_ftplugin = 1
            
            -- Set buffer options
            local buf = ev.buf
            vim.bo[buf].iskeyword = vim.bo[buf].iskeyword .. ",@-@"
            vim.bo[buf].expandtab = false
            vim.bo[buf].comments = "b:-"
            vim.bo[buf].formatoptions = vim.bo[buf].formatoptions:gsub("c", "") .. "rol"
            vim.bo[buf].autoindent = true
            vim.bo[buf].filetype = 'taskpaper'
            
            -- Set up syntax highlighting
            require("taskpaper.highlights").setup()
            
            -- Set up mappings
            require("taskpaper.mappings").setup(buf)
        end
    })
end

-- Include your plugin functions
function M.fold_projects()
    -- Implementation
end

function M.search(pattern)
    -- Implementation
end

-- ... other functions ...

return M


