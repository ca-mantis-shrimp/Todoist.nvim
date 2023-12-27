local curl = require("plenary.curl")

local M = {}

M.url = "https://api.todoist.com/sync/v9/sync"

function M.get_all_projects(api_key)
	local sync_response = curl.request({
		url = "https://api.todoist.com/sync/v9/sync",
		headers = { Authorization = "Bearer " .. api_key },
		data = {
			sync_token = "*",
			resource_types = "[]",
		},
	})
	if sync_response.status == 200 then
		return vim.fn.json_decode(sync_response.body)
	else
		return sync_response.status
	end
end

return M
