local api = require("Todoist.api")
local autocmd = require("Todoist.autocommands")
local config = require("Todoist.config")
local commands = require("Todoist.command")

local M = {}

function M.setup(opts)
	config.config(opts)

	vim.filetype.add({
		extension = {
			projects = "projects",
		},
	})

	vim.fn.mkdir(vim.fn.stdpath("cache") .. "/Todoist", "p")

	commands.create_all_projects_command()

	autocmd.create_indent_autocmd()
end

function M.get_all_projects()
	api.show_project_task_list()
end

return M
