local api = require("Todoist.api")
M = {}

M.create_all_projects_window_command = function()
	vim.api.nvim_create_user_command("TodoistGetProjects", function()
		api.show_project_task_list()
	end, {})
end

return M
