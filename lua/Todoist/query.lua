local curl = require("plenary.curl")

local M = {}

M.url = "https://api.todoist.com/sync/v9/sync"

function M.get_all_projects(api_key)
	local authorization = "Bearer " .. api_key
	local data = { sync_token = "*", resource_types = "projects" }

	local response = curl.get(M.url, {
		auth = authorization,
		query = data,
	})

	return vim.fn.json_decode(response)
end

return M
