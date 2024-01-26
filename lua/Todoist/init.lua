local api = require("Todoist.api")
local config = require("Todoist.config")
local commands = require("Todoist.command")

local M = {}

function M.setup(opts)
	config.config(opts)

	commands.create_all_projects_window_command()
end

function M.get_all_projects()
	api.show_project_list()
end

return M
