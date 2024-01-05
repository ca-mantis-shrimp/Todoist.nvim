local api = require("Todoist.api")
local query = require("Todoist.query")
local ui = require("Todoist.ui")
local config = require("Todoist.config")
local model = require("Todoist.model")
local display = require("Todoist.display")

local M = {}

function M.setup(opts)
	config.setup(opts)
end

M.open_project_list =
	api.open_project_list(query.get_all_projects, ui.show_project_list, config.api_key, config.options.ui)

return M
