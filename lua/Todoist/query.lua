local curl = require("plenary.curl")

local M = {}

M.url = "https://api.todoist.com/sync/v9/sync"

function M.get_all_projects(api_key)
	local authorization = "Bearer " .. api_key
	local data = '{"authorization":"' .. authorization .. '","sync_token":"*","resource_types":["projects"]}'

	local response = curl.post(M.url, {
		data = data,
		headers = { ["Content-Type"] = "application/json" },
	})

	return vim.fn.json_decode(response)
end

return M
