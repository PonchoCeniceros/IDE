# AGENTS.md - Neovim Configuration Guide

## Overview

This is a LazyVim-based Neovim configuration. The codebase consists of Lua plugin configurations, autocmds, keymaps, and options.

## Build/Lint/Test Commands

This is a Neovim configuration, not a typical software project. There are no traditional build commands.

### Running Neovim

```bash
nvim              # Start Neovim with default theme (carbonfox)
NVIM_THEME=carbonfox nvim
NVIM_THEME=catppuccin nvim
```

### Lua Formatting (StyLua)

```bash
stylua --check lua/        # Check formatting without modifying
stylua lua/                # Format all Lua files
stylua --stdin-filepath <file> < <file>  # Format single file
```

### Lua LSP Diagnostics

```bash
# Run from within Neovim
:LspStart              # Start LSP servers
:LspLog                # View LSP logs
:LspInfo               # Show LSP status
:Mason                 # Manage LSP servers
```

### Testing Changes

To test configuration changes:
1. Open Neovim: `nvim`
2. Source the config: `:source $MYINIT.lua` or restart Neovim
3. Check for errors: `:lua vim.cmd("quit")` after testing

### Theme Management

```bash
./utils/theme-selector.sh              # Show current theme
./utils/theme-selector.sh carbonfox   # Set default theme
```

---

## Code Style Guidelines

### File Organization

```
lua/
├── config/          # Core Neovim configuration
│   ├── lazy.lua     # Plugin manager bootstrap
│   ├── options.lua  # Global options
│   ├── keymaps.lua  # Keybindings
│   └── autocmds.lua # Autocommands
└── plugins/        # Plugin configurations (one file per feature)
    ├── ai.*.lua
    ├── editor.*.lua
    ├── ui.*.lua
    └── tools.*.lua
```

### Lua Conventions

#### Indentation & Formatting
- **2 spaces** for indentation (no tabs)
- **120 characters** max line length
- Use **StyLua** for formatting (configured in `stylua.toml`)
- Trailing commas in tables are allowed

#### Naming Conventions
- **Files**: snake_case.lua (e.g., `ui.colorscheme.lua`)
- **Variables**: snake_case (e.g., `local chosen_colorscheme`)
- **Plugin names**: Use original GitHub names (e.g., `"catppuccin/nvim"`)
- **Lazy keys**: Use descriptive `desc` field for every keymap

#### Plugin Specification Pattern

```lua
return {
  "owner/repo.nvim",
  -- Optional: custom name for lazy loading
  name = "shortname",
  -- Optional: lazy-load only when needed
  lazy = true,
  -- Optional: load after event
  event = "VeryLazy",
  -- Optional: dependencies
  dependencies = {
    { "other/plugin.nvim" },
  },
  -- Configuration via opts table or function
  opts = {
    -- default options
  },
  -- Or function-based config
  config = function()
    require("plugin").setup({})
  end,
  -- Keymaps
  keys = {
    {
      "<leader>xx",
      function()
        require("plugin").action()
      end,
      desc = "Description of action",
    },
  },
}
```

#### Keymaps

```lua
-- Use vim.keymap.set() with descriptive desc
vim.keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Find files" })

-- Use <cmd> for Neovim commands
-- Use vim.cmd() or require() for Lua calls

-- Delete default keymaps before setting custom ones
vim.keymap.del("n", "<C-h>")
```

#### Options & Settings

```lua
-- Use vim.opt for options
vim.opt.number = true
vim.opt.relativenumber = true

-- Use vim.g for global variables
vim.g.mapleader = " "

-- Use vim.o for other settings
vim.o.autoread = true
```

#### Lazy Loading

- **Lazy load by event**: `event = "VeryLazy"` for startup config
- **Lazy load by keys**: `keys = { ... }` pattern loads plugin on first keypress
- **Lazy load by cmd**: `cmd = { "MyCommand" }` loads when command is used

#### Dependencies

- Use `dependencies` table in plugin spec for plugin dependencies
- For Neovim builtins, use `opts` to extend them (e.g., conform.nvim, telescope)

#### Error Handling

- Wrap `config` functions in pcall when they might fail:
  ```lua
  config = function()
    local ok, module = pcall(require, "module")
    if not ok then return end
    module.setup({})
  end
  ```

---

## Common Patterns

### Extending Builtin Plugins

```lua
return {
  "conform.nvim",
  opts = function(_, opts)
    opts.formatters_by_ft = opts.formatters_by_ft or {}
    opts.formatters_by_ft.json = { "prettier" }
  end,
}
```

### Theme Configuration

```lua
return {
  "EdenEast/nightfox.nvim",
  name = "nightfox",
  lazy = false,
  priority = 1000,
  config = function()
    require("nightfox").setup({
      options = {
        transparent = false,
      },
    })
  end,
}
```

### Environment-Based Configuration

```lua
local chosen_theme = os.getenv("NVIM_THEME")
if chosen_theme == "catppuccin" then
  -- config
end
```

---

## External Resources

- [LazyVim Documentation](https://lazyvim.github.io/)
- [Neovim Lua Guide](https://neovim.io/doc/user/lua.html)
- [StyLua Configuration](https://github.com/JohnnyMorganz/StyLua)
- [Lazy.nvim Plugin Spec](https://lazy.folke.io/spec)
