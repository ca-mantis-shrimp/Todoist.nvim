local api = require("Todoist.api")
M = {}

M.create_all_projects_command = function()
	vim.api.nvim_create_user_command("SyncTodoistProjects", function()
		local server_project_file_path = vim.fn.stdpath("cache") .. "/Todoist/server_todoist.projects"
		local client_project_file_path = vim.fn.stdpath("cache") .. "/Todoist/client_todoist.projects"

		api.download_project_tree_to_file(server_project_file_path)
		api.download_project_tree_to_file(client_project_file_path)
	end, {})
	vim.api.nvim_create_user_command("OpenTodoistProjectFile", function()
		local project_file_path = vim.fn.stdpath("cache") .. "/Todoist/client_todoist.projects"
		vim.cmd("e " .. project_file_path)
	end, {})
end

return M
