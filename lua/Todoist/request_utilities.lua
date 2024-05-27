local M = {}

M.url = "https://api.todoist.com/sync/v9/sync"

M.todoist_resource_types = {
	"projects",
	"items",
	"notes",
	"labels",
	"sections",
	"reminders",
	"reminders_location",
	"locations",
	"users",
	"live_notification",
	"collaborators",
	"user_settings",
	"notification_settings",
	"user_plan_limits",
	"completed_info",
	"stats",
}

M.response_status_codes = {
	[200] = "OK",
	[400] = "Bad Request: The Request was incorrect",
	[401] = "Unauthorized: Authentication is required, and has failed, or has not yet been provided.",
	[403] = "Forbidden: The request was valid, but for something that is forbidden",
	[404] = "Not Found: The requested resource could not be found",
	[429] = "Too Many Requests: The user sent too many requests in a give amount of time",
	[500] = "Internal Server Error: the request failed due to a server error",
	[503] = "Service Unavailable: The server is currently unable to handle the request",
}

local function create_resource_list_str(resource_types)
	local resource_list_str = "["

	for i, resource_type in pairs(resource_types) do
		resource_list_str = resource_list_str .. '"' .. resource_type .. '"'

		if i < #resource_types then
			resource_list_str = resource_list_str .. ", "
		end
	end

	resource_list_str = resource_list_str .. "]"

	return resource_list_str
end

function M.create_sync_request(api_key, sync_token, resource_types)
	return {
		url = "https://api.todoist.com/sync/v9/sync",
		headers = { Authorization = "Bearer " .. api_key },
		data = {
			sync_token = sync_token or "*",
			resource_types = create_resource_list_str(resource_types or { "projects", "items", "notes", "sections" }),
		},
		timeout = 100000,
	}
end

function M.get_all_projects(api_key, request_engine)
	local sync_response = request_engine.request({
		url = "https://api.todoist.com/sync/v9/sync",
		headers = { Authorization = "Bearer " .. api_key },
		data = {
			sync_token = "*",
			resource_types = '["projects", "items", "notes"]',
		},
	})

	return vim.json.decode(sync_response.body)
end

function M.process_response(response)
	if response.status == 200 then
		return vim.json.decode(response.body)
	else
		error(M.response_status_codes[response.status], 2)
	end
end

M.reduce_response = function(response)
	return { ["projects"] = response.projects, ["items"] = response.items, ["project_notes"] = response.project_notes }
end

return M
