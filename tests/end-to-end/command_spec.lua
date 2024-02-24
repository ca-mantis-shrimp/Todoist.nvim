local commands = require("Todoist.command")
local config = require("Todoist.config")

describe("testing the Ex commands defined for the Plugin", function()
	it("should return the window id for our main task command", function()
		config.config({ api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750" })

		commands.create_all_projects_window_command()

		local window_id = vim.cmd.TodoistGetTasks()

		assert(window_id ~= nil)
	end)
	it("should return the window id for our main project command", function()
		config.config({ api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750" })

		commands.create_all_projects_window_command()

		local window_id = vim.cmd.TodoistGetProjects()

		assert(window_id ~= nil)
	end)
end)
