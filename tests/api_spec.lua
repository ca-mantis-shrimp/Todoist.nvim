local config = require("Todoist.config")
local todoist_api = require("Todoist.api")

describe("creating a todoist window", function()
	it("can create the todoist task floating window", function()
		config.config({ api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750" })

		local todoist_window = todoist_api.show_project_task_list()

		assert(todoist_window ~= nil)
	end)
	it("can create the todoist project floating window", function()
		config.config({ api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750" })

		local todoist_window = todoist_api.show_project_overview_list()

		assert(todoist_window ~= nil)
	end)
end)
