local M = {}

function M.open_project_list(query_function, ui_function, api_key, ui_opts)
	local project_list = query_function(api_key)
	ui_function(project_list, ui_opts)
end

return M
