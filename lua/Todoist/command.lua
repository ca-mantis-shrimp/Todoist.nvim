local api = require("Todoist.api")
local filesystem = require("Todoist.filesystem")

local M = {}

M.create_all_project_commands = function()
	vim.api.nvim_create_user_command("TodoistFullSync", function()
		local server_project_file_path = vim.fn.stdpath("cache") .. "/Todoist/server_todoist.projects"
		local client_project_file_path = vim.fn.stdpath("cache") .. "/Todoist/client_todoist.projects"

		tree_lines = api.download_project_tree_to_file()

		filesystem.write_file(server_project_file_path, tree_lines)
		filesystem.write_file(client_project_file_path, tree_lines)
	end, {})
	vim.api.nvim_create_user_command("TodoistOpenProjectFile", function()
		local project_file_path = vim.fn.stdpath("cache") .. "/Todoist/client_todoist.projects"
		vim.cmd("e " .. project_file_path)
	end, {})
end

return M
