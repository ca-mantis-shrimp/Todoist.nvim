local query = require("Todoist.query")
local curl = require("plenary.curl")
local model = require("Todoist.model")
local util = require("Todoist.util")

describe("integration between the query module and the todoist model", function()
	it("should be able to create a node dictionary from a successful query", function()
		local response = query.get_all_projects("e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", curl)

		local node_dictionary = model.create_task_node_dictionary(response)

		assert(util.length(node_dictionary) == 5)
	end)
end)
