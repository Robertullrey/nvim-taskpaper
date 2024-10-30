# nvim-taskpaper.nvim

A Neovim plugin for working with TaskPaper files. Provides project management, task organization, and tag handling for TaskPaper-formatted documents.

## Features

- Project Management
  - Quick project navigation and focusing
  - Project folding
  - Task movement between projects

- Task Organization
  - Toggle task status (@done, @today, @cancelled)
  - Archive completed tasks
  - Fold task notes and details

- Smart Searching
  - Search by keywords
  - Search by tags
  - Navigate between projects

## Requirements

- Neovim >= 0.5.0
- [lazy.nvim](https://github.com/folke/lazy.nvim) (or your preferred plugin manager)

## Installation

Using [lazy.nvim](https://github.com/folke/lazy.nvim):

```lua
{
    "Robertullrey/nvim-taskpaper",
    ft = "taskpaper",
    config = function()
        require("nvim-taskpaper").setup()
    end
}
```

## Default Mappings

All mappings are prefixed with `<Leader>t` by default.

### Project Navigation
- `<Leader>tg` - Go to project (shows selection UI)
- `<Leader>tj` - Jump to next project
- `<Leader>tk` - Jump to previous project
- `<Leader>tP` - Focus current project (hide others)

### Task Management
- `<Leader>td` - Toggle @done tag with date
- `<Leader>tt` - Toggle @today tag
- `<Leader>tx` - Toggle @cancelled tag
- `<Leader>tD` - Archive done tasks
- `<Leader>tT` - Show today tasks
- `<Leader>tX` - Show cancelled tasks

### Folding
- `<Leader>tp` - Fold projects
- `<Leader>t.` - Fold notes

### Search
- `<Leader>t/` - Search by keyword
- `<Leader>ts` - Search by tag

## Configuration

You can customize the plugin by passing options to the setup function:

```lua
require("nvim-taskpaper").setup({
    -- Default date format for @done(date) tags
    date_format = "%Y-%m-%d",
    
    -- Name of the archive project
    archive_project = "Archive",
    
    -- Whether to follow task when moving it
    follow_move = 1,
    
    -- Whether to hide done tasks in search
    search_hide_done = 0
})
```

## File Format

The plugin expects TaskPaper-formatted files (`.taskpaper` extension). Example:

```
Project Name:
    - Task one @tag
    - Task two @done(2024-10-30)
    - Task three @urgent
        Notes about task three
    - Task four @today

Another Project:
    - Subtask here
    - Another task @done(2024-10-30)
```

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

MIT License - See LICENSE file for details

## Acknowledgments

This plugin is inspired by the original TaskPaper format and various TaskPaper tools for other editors.