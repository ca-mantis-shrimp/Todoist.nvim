local api = require("Todoist.api")
M = {}

M.create_all_projects_command = function()
	vim.api.nvim_create_user_command("TodoistGetProjects", function(opts)
		local project_file_path = opts[1] or vim.fn.stdpath("cache") .. "/Todoist/todoist.projects"
		if not io.open(project_file_path, "r") then
			api.download_project_tree_to_file(project_file_path)
		end
		api.open_projects_file_as_buffer(project_file_path)
	end, {})
end

return M
