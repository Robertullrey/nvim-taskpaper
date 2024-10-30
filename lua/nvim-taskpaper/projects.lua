-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/projects.lua
local M = {}

function M.get_project_info()
    local projects = {}
    local project_info = {}
    local current_project = nil
    local last_project_line = 0
    local task_count = 0
    
    for i = 1, vim.fn.line('$') do
        local line = vim.fn.getline(i)
        
        if line:match("^%s*-%s") then
            task_count = task_count + 1
        end
        
        if line:match("^[^%s%-].*:$") then
            if current_project then
                project_info[current_project].task_count = task_count
            end
            
            local project_name = line:gsub(":$", "")
            current_project = project_name
            table.insert(projects, project_name)
            
            project_info[project_name] = {
                line = i,
                task_count = 0,
                done_count = 0,
                has_urgent = false,
                has_today = false
            }
            
            task_count = 0
            last_project_line = i
        end
        
        if current_project then
            if line:match("@done") then
                project_info[current_project].done_count = project_info[current_project].done_count + 1
            end
            if line:match("@urgent") then
                project_info[current_project].has_urgent = true
            end
            if line:match("@today") then
                project_info[current_project].has_today = true
            end
        end
    end
    
    if current_project then
        project_info[current_project].task_count = task_count
    end
    
    return projects, project_info
end

-- File: /Users/rullrey/Documents/GitHub/nvim-taskpaper.nvim/lua/nvim-taskpaper/projects.lua
function M.go_to_project()
    local projects, project_info = M.get_project_info()
    
    -- Check if we have any projects
    if #projects == 0 then
        print("No projects found in file")
        return
    end

    local formatted_projects = {}
    -- Store the original project names to look up later
    local project_lookup = {}
    
    for i, project in ipairs(projects) do
        local info = project_info[project]
        local status = ""
        
        if info.has_urgent then 
            status = status .. "!"
        end
        if info.has_today then 
            status = status .. "⌚"
        end
        
        formatted_projects[i] = string.format(
            "%-30s %s[%d/%d tasks]%s",
            project,
            status,
            info.done_count,
            info.task_count,
            status ~= "" and " " .. status or ""
        )
        -- Store the original project name
        project_lookup[formatted_projects[i]] = project
    end
    
    vim.ui.select(formatted_projects, {
        prompt = "Go to project:",
        format_item = function(item)
            return item
        end
    }, function(choice)
        if choice then
            -- Look up the original project name
            local project_name = project_lookup[choice]
            if not project_name or not project_info[project_name] then
                print("Invalid project selection")
                return
            end

            local line_number = project_info[project_name].line
            
            -- Verify line number
            if line_number > 0 and line_number <= vim.fn.line('$') then
                vim.api.nvim_win_set_cursor(0, {line_number, 0})
                vim.cmd('normal! zz')
                
                local info = project_info[project_name]
                print(string.format(
                    "Jumped to '%s' (%d/%d tasks completed%s%s)",
                    project_name,
                    info.done_count,
                    info.task_count,
                    info.has_urgent and ", has urgent tasks" or "",
                    info.has_today and ", has today tasks" or ""
                ))
            else
                print("Could not locate project position")
            end
        end
    end)
end

function M.next_project()
    vim.fn.search("^[^%s%-].*:$", "W")
end

function M.previous_project()
    vim.fn.search("^[^%s%-].*:$", "bW")
end

function M.focus_project()
    local current_line = vim.fn.line('.')
    local project_line = vim.fn.search('^[^%s%-].*:$', 'bcnW')
    
    if project_line == 0 then
        print("No project found")
        return
    end
    
    local next_project = vim.fn.search('^[^%s%-].*:$', 'nW')
    if next_project == 0 then
        next_project = vim.fn.line('$')
    else
        next_project = next_project - 1
    end
    
    vim.cmd('setlocal foldmethod=manual')
    vim.cmd('normal! zE')
    vim.cmd('1,' .. (project_line-1) .. 'fold')
    if next_project < vim.fn.line('$') then
        vim.cmd((next_project+1) .. ',$fold')
    end
    
    vim.cmd(project_line .. 'normal! zO')
end

return M