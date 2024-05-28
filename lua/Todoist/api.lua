local config = require("Todoist.config")
local curl = require("plenary.curl")
local request_utilities = require("Todoist.request_utilities")
local model = require("Todoist.model")
local tree = require("Todoist.tree")
local tree_display = require("Todoist.tree.display")
local buffer = require("Todoist.buffer")
local window = require("Todoist.window")
local autocmd = require("Todoist.autocommands")
local filesystem = require("Todoist.filesystem")
M = {}

M.download_project_tree_to_file = function(path)
	assert(config.api_key, "API key must not be nil for request to work, be sure config was run before this")
	local request_result =
		request_utilities.process_response(curl.request(request_utilities.create_sync_request(config.api_key)))

	local key_val_conversion_result = model.create_project_node_dictionary(request_result)

	local tree_conversion_result = tree.create_tree(key_val_conversion_result)

	local line_extraction_result = tree_display.get_buffer_lines_from_tree(tree_conversion_result)

	filesystem.write_file(path, line_extraction_result)
end

M.open_projects_file_as_buffer = function(path)
	local tree_lines = filesystem.read_file(path)
	local buffer_id = buffer.create_buffer_with_lines(true, false, tree_lines, "todoist_projects")

	autocmd.create_indent_autocmd()

	return buffer_id
end

M.show_project_task_list = function()
	local todoist_items =
		request_utilities.process_response(curl.request(request_utilities.create_sync_request(config.api_key)))

	local items = model.create_task_node_dictionary(todoist_items)

	local todoist_tree = tree.create_tree(items)

	local tree_lines = tree_display.get_buffer_lines_from_tree(todoist_tree)

	local buffer_id = buffer.create_buffer_with_lines(true, false, tree_lines, "actions")

	local window_id = window.create_split_window(buffer_id)

	return window_id
end

return M
