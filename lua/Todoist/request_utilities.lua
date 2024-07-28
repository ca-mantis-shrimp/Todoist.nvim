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

local generate_command_args_string = function(args)
	local args_str = '"args": {'

	for name, value in pairs(args) do
		if type(value) == "string" then
			args_str = args_str .. string.format('"%s": "%s"', name, value)
		elseif not value then
			goto continue
		else
			args_str = args_str .. string.format('"%s": %s', name, tostring(value))
		end
		if next(args, name) then
			args_str = args_str .. ", "
		end
		::continue::
	end

	return args_str .. "}"
end

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

function M.create_sync_request(api_key, sync_token, resource_types, commands)
	local request_body = {
		url = "https://api.todoist.com/sync/v9/sync",
		headers = { Authorization = "Bearer " .. api_key },
		data = {
			sync_token = sync_token or "*",
			resource_types = create_resource_list_str(resource_types or { "projects", "items", "notes", "sections" }),
		},
		timeout = 100000,
	}

	return request_body
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

M.colors = {
	berry_red = {
		id = 30,
		hex = "#b8256f",
	},
	red = {
		id = 31,
		hex = "#db4035",
	},
	oranges = {
		id = 32,
		hex = "#ff9933",
	},
	yellow = {
		id = 33,
		hex = "#fad000",
	},
	olive_green = {
		id = 34,
		hex = "#afb83b",
	},
	lime_green = {
		id = 35,
		hex = "#7ecc49",
	},
	green = {
		id = 36,
		hex = "#299438",
	},
	mint_green = {
		id = 37,
		hex = "#6accbc",
	},
	teal = {
		id = 38,
		hex = "#158fad",
	},
	sky_blue = {
		id = 39,
		hex = "#14aaf5",
	},
	light_blue = {
		id = 40,
		hex = "#96c3eb",
	},
	blue = {
		id = 41,
		hex = "#4073ff",
	},
	grape = {
		id = 42,
		hex = "#884dff",
	},
	violet = {
		id = 43,
		hex = "#af38eb",
	},
	lavender = {
		id = 44,
		hex = "#eb96eb",
	},
	magenta = {
		id = 45,
		hex = "#e05194",
	},
	salmon = {
		id = 46,
		hex = "#ff8d85",
	},
	charcoal = {
		id = 47,
		hex = "#808080",
	},
	grey = {
		id = 48,
		hex = "#b8b8b8",
	},
	taupe = {
		id = 49,
		hex = "#ccac93",
	},
}

return M
