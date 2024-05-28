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
	assert(config.api_key, "API key must not be nil for request to work")
	local request_successful, request_result =
		pcall(request_utilities.process_response, curl.request(request_utilities.create_sync_request(config.api_key)))

	assert(request_successful, request_result)
	local key_val_conversion_successful, key_val_conversion_result =
		pcall(model.create_project_node_dictionary, request_result)

	assert(key_val_conversion_successful, key_val_conversion_result)
	local tree_conversion_successful, tree_conversion_result = pcall(tree.create_tree, key_val_conversion_result)

	assert(tree_conversion_successful, tree_conversion_result)
	local line_extraction_successful, line_extraction_result =
		pcall(tree_display.get_buffer_lines_from_tree, tree_conversion_result)

	assert(line_extraction_successful, line_extraction_result)
	local file_writing_successful, _ = pcall(filesystem.write_file, path, line_extraction_result)

	assert(
		file_writing_successful,
		"writing tree lines to file failed, ensure path is valid and opent to user for writing"
	)
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
