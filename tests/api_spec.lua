local config = require("Todoist.config")
local todoist_api = require("Todoist.api")

local api_key = vim.fn.getenv("TODOIST_TEST_API_KEY")

describe("creating a todoist window", function()
	it("can create the todoist project floating window", function()
		config.api_key = api_key
		local tree_path = vim.fn.stdpath("cache") .. "/Todoist/end-to-end-test.projects"

		local success, _ = pcall(todoist_api.download_project_tree_to_file)

		local tree_lines = io.input(tree_path):read("*a")

		assert(success)
		assert(tree_lines)
	end)
end)
