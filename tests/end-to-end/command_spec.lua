local commands = require("Todoist.command")
local config = require("Todoist.config")

describe("testing the Ex commands defined for the Plugin", function()
	it("should return the window id for our main project command", function()
		config.api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750"

		commands.create_all_projects_command()

		local buffer_id = vim.cmd.TodoistGetProjects()

		assert(buffer_id)
	end)
end)
