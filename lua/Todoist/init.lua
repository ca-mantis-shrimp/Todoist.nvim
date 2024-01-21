local api = require("Todoist.api")
local config = require("Todoist.config")

local M = {}

function M.setup(opts)
	config.config(opts)
end

function M.get_all_projects()
	api.show_project_list()
end

return M
