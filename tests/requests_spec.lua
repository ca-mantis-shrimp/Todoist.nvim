local requests = require("Todoist.query")

describe("Todoist Queries", function()
	it("Syncs with Todoist Servers When Given Valid Key", function()
		local sync_response = requests.get_all_projects(os.getenv("TODOIST_API_KEY"))

		assert.is_true(type(sync_response) == "table")
	end)
end)
