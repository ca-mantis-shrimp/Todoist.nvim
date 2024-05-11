# Todoist.nvim
Plugin for managing Todoist through Neovim using a more vim-like syntax

My future intention is to create something where the average user can do their entire workflow completely from Neovim while having access to all Todoist features (excluding teams-related features)

We do this by introducing a new filteype of `projects` and `tasks` and making views that users can interact with, similar to the layout of something like oil.nvim where users can utilize standard vim methods to interact with both Task and Project data, while still having the feeling of a normal buffer

## Installation
The only things this plugins needs is plenary, nvim-treesitter, and your Todoist API key

```lua
{
  "ca-mantis-shrimp/Todoist.nvim",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-treesitter/nvim-treesitter" }
  config = {
    api_key = vim.getenv("TODOIST_API_KEY")
  }
}
```
As you can see, im using an environment variable to store the API key, you can do this by adding the following line to your init.vim or init.lua

 Ofcourse, best practice is to pipe the result of a query to your password manager of choice (for me, that's 1password, but this is all personal preference)

For right now, we are also trying to support local treesitter parsers so after the plugin config you need to put this somewhere in your config:
```lua
local parser_config = require "nvim-treesitter.parsers".get_parser_configs()

parser_config.projects = {
  install_info = {
    url = "~/Products/tree-sitter-projects",
    files = {"src/parser.c"}, 
    generate_requires_npm = false, -- if stand-alone parser without npm dependencies
    requires_generate_from_grammar = false, -- if folder contains pre-generated src/parser.c
  },
  filetype = "projects"
}

vim.treesitter.language.register('projects', 'projects') 
```
- This will add the custom parsers to your treesitter config 
  - Notice in my example i have this within the "Products" folder but this should be updated to wherever you end up placing this file
- and register the filetype `projects` to the parser

# Usage
Currently the primary interface is surfaced through the new `TodoistGetProjects` command which will get all of the users projects as a new floating window

# Roadmap
- [ ] add support for tasks in new `tasks` filetype
- [ ] add support for updating, creating, and removing files from the project list
- [ ] TreeSitter support for highlights as well as folding and manipulation of objects in-buffer
