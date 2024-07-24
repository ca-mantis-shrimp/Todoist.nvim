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
	["project_add"] = function(name, temp_id, uuid, parent, child_order, is_favorite)
		local command_string = string.format(
			[[{
			"type": "project_add",
			"temp_id": "%s",
			"uuid": "%s",
			"args": {
				"name:" "%s"
			]],
			temp_id,
			uuid,
			name
		)

		if parent then
			command_string = command_string .. string.format(',"parent": "%s"', parent)
		end
		if child_order then
			command_string = command_string .. string.format(',"child_order": %s', child_order)
		end
		if is_favorite then
			command_string = command_string .. string.format(',"is_favorite": %s', is_favorite)
		end

		command_string = command_string .. [[}
		}]]

		return command_string
	end,
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
	assert(response.status == 200, M.response_status_codes[response.status])

	return vim.json.decode(response.body)
end

M.reduce_response = function(response)
	return { ["projects"] = response.projects, ["items"] = response.items, ["project_notes"] = response.project_notes }
end

return M
