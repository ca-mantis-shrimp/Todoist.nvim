local M = {}

M.url = "https://api.todoist.com/sync/v9/sync"

function M.get_all_projects(api_key, request_engine)
	local sync_response = request_engine.request({
		url = "https://api.todoist.com/sync/v9/sync",
		headers = { Authorization = "Bearer " .. api_key },
		data = {
			sync_token = "*",
			resource_types = "['projects', 'items']",
		},
	})

	if sync_response.status == 200 then
		return vim.json.decode(sync_response.body)
	else
		return sync_response
	end
end

return M
