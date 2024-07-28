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

M.todoist_commands = {
	["project_add"] = function(name, temp_id, uuid, parent, child_order, is_favorite_req)
		assert(name, "Must Have a Name for our new project!")

		local command = {
			type = "project_add",
			temp_id = temp_id,
			uuid = uuid,
			args = {
				name = name,
				parent = parent,
				child_order = child_order,
				is_favorite = is_favorite_req,
			},
		}

		return vim.json.encode(command)
	end,
}

function M.create_sync_request(api_key, sync_token, resource_types, commands)
	local request_body = {
		url = "https://api.todoist.com/sync/v9/sync",
		headers = { Authorization = "Bearer " .. api_key },
		data = {
			sync_token = sync_token or "*",
			resource_types = vim.json.encode(resource_types or { "projects", "items", "notes", "sections" }),
		},
		timeout = 100000,
	}

	request_body.data.commands = commands

	return request_body
end

function M.process_response(response)
	assert(response.status == 200, M.response_status_codes[response.status])

	return vim.json.decode(response.body)
end

M.reduce_response = function(response)
	return { ["projects"] = response.projects, ["items"] = response.items, ["project_notes"] = response.project_notes }
end

return M
