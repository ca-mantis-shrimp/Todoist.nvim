local util = require("Todoist.util")
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
	local todoist_types =
		request_utilities.process_response(curl.request(request_utilities.create_sync_request(config.api_key)))

	local item_list = model.create_project_node_dictionary(todoist_types)

	local project_tree = tree.create_tree(item_list)
	local tree_lines = tree_display.get_buffer_lines_from_tree(project_tree)

	tree_lines[util.length(tree_lines) + 1] = tostring("@" .. todoist_types.sync_token)

	filesystem.write_file(path, tree_lines)
end

local open_projects_file_as_buffer = function(path)
	local tree_lines = filesystem.read_file(path)
	local buffer_id = buffer.create_buffer_with_lines(true, false, tree_lines, path)

	autocmd.create_indent_autocmd()

	return buffer_id
end

M.create_updates_from_project_trees = function()
	local client_tree = vim.treesitter.get_parser()

	local server_path = vim.fn.stdpath("cache") .. "/Todoist/server_todoist.projects"
	local server_tree = vim.treesitter.get_parser(open_projects_file_as_buffer(server_path))

	print(vim.inspect(client_tree))
	print(vim.inspect(server_tree))
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
