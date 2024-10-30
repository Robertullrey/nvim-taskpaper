-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/init.lua

-- Import all modules
local projects = require('nvim-taskpaper.projects')
local tags = require('nvim-taskpaper.tags')
local search = require('nvim-taskpaper.search')
local folding = require('nvim-taskpaper.folding')
local archive = require('nvim-taskpaper.archive')

local M = {}

-- Core setup function
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
            
            print("Setting up TaskPaper for buffer: " .. buf)
            
            -- Set up syntax highlighting
            require("nvim-taskpaper.highlights").setup()
            
            -- Set up mappings
            require("nvim-taskpaper.mappings").setup(buf)
        end
    })
end

-- Delegate project-related functions
M.go_to_project = projects.go_to_project
M.next_project = projects.next_project
M.previous_project = projects.previous_project
M.focus_project = projects.focus_project

-- Delegate tag-related functions
M.toggle_done = tags.toggle_done
M.toggle_today = tags.toggle_today
M.toggle_cancelled = tags.toggle_cancelled
M.show_today = tags.show_today
M.show_cancelled = tags.show_cancelled

-- Delegate search functions
M.search = search.search
M.search_keyword = search.search_keyword
M.search_tag = search.search_tag

-- Delegate folding functions
M.fold_projects = folding.fold_projects
M.fold_notes = folding.fold_notes

-- Delegate archive functions
M.archive_done = archive.archive_done

return M