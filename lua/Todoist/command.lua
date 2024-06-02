local api = require("Todoist.api")
M = {}

M.create_all_projects_command = function()
	vim.api.nvim_create_user_command("SyncTodoistProjects", function(opts)
		local project_file_path = opts[1] or vim.fn.stdpath("cache") .. "/Todoist/todoist.projects"
		api.download_project_tree_to_file(project_file_path)
	end, {})
	vim.api.nvim_create_user_command("OpenTodoistProjectFile", function(opts)
		local project_file_path = opts[1] or vim.fn.stdpath("cache") .. "/Todoist/todoist.projects"
		api.open_projects_file_as_buffer(project_file_path)
	end, {})
end

return M
