local requests = require("Todoist.query")

describe("Todoist Queries", function()
	it("Syncs with Todoist Servers When Given Valid Key", function()
		local sync_response = requests.get_all_projects(os.getenv("TODOIST_API_KEY"))

		assert.are.equal(type(sync_response), "table")
	end)

	it("Resturns Status Code When Unsuccessful", function()
		local sync_response = requests.get_all_projects("bad api key")

		assert.are.equal(type(sync_response), "number")
	end)
end)
