local M = {}

M.url = "https://api.todoist.com/sync/v9/sync"

M.todoist_resource_types = {
	"labels",
	"projects",
	"items",
	"notes",
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

function M.get_all_projects(api_key, request_engine)
	local sync_response = request_engine.request({
		url = "https://api.todoist.com/sync/v9/sync",
		headers = { Authorization = "Bearer " .. api_key },
		data = {
			sync_token = "*",
			resource_types = '["projects", "items", "notes"]',
		},
	})

	if sync_response.status == 200 then
		return vim.json.decode(sync_response.body)
	else
		return sync_response
	end
end

M.reduce_response = function(response)
	return { ["projects"] = response.projects, ["items"] = response.items, ["notes"] = response.notes }
end

return M
