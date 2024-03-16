local config = require("Todoist.config")
local curl = require("plenary.curl")
local request_utilities = require("Todoist.request_utilities")
local model = require("Todoist.model")
local tree = require("Todoist.tree")
local tree_display = require("Todoist.tree.display")
local buffer = require("Todoist.buffer")
local window = require("Todoist.window")

M = {}

M.show_project_task_list = function()
	local todoist_items =
		request_utilities.process_response(curl.request(request_utilities.create_sync_request(config.api_key)))

	local items = model.create_task_node_dictionary(todoist_items)

	local todoist_tree = tree.create_tree(items)

	local tree_lines = tree_display.get_buffer_lines_from_tree(todoist_tree)

	local buffer_id = buffer.create_buffer_with_lines(false, true, tree_lines)

	local window_id = window.create_split_window(buffer_id)

	return window_id
end

M.show_project_overview_list = function()
	local todoist_items =
		request_utilities.process_response(curl.request(request_utilities.create_sync_request(config.api_key)))

	local items = model.create_project_node_dictionary(todoist_items)

	local todoist_tree = tree.create_tree(items)

	local tree_lines = tree_display.get_buffer_lines_from_tree(todoist_tree)

	local buffer_id = buffer.create_buffer_with_lines(false, true, tree_lines)

	local window_id = window.create_split_window(buffer_id)

	return window_id
end

return M
