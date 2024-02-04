local config = require("Todoist.config")
local curl = require("plenary.curl")
local query = require("Todoist.query")
local model = require("Todoist.model")
local tree = require("Todoist.tree")
local tree_display = require("Todoist.tree.display")
local buffer = require("Todoist.buffer")
local window = require("Todoist.window")

M = {}

M.show_project_list = function()
	local response = query.get_all_projects(config.api_key, curl)

	local items = model.create_task_node_dictionary(response)

	local todoist_tree = tree.create_tree(items)

	local tree_lines = tree_display.get_buffer_lines_from_tree(todoist_tree)

	local buffer_id = buffer.create_buffer_with_lines(false, true, tree_lines)

	local window_id = window.create_floating_window(buffer_id)

	return window_id
end

return M
