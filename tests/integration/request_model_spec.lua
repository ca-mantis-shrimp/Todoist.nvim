local request = require("Todoist.request_utilities")
local curl = require("plenary.curl")
local model = require("Todoist.model")
local util = require("Todoist.util")

local success, result = pcall(
	request.process_response,
	curl.request(request.create_sync_request("e0007362ae4002e7ce38bc9cf5f17b71f3fc6750"))
)
describe("integration between the request utils module and the todoist model", function()
	it("should be able to create a taske node dictionary from a successful query", function()
		assert(success)

		local node_dictionary = model.create_task_node_dictionary(result)

		assert(util.length(node_dictionary) > 1)
	end)

	it("should be able to create a project dictionary from a successful query", function()
		local node_dictionary = model.create_project_node_dictionary(result)

		assert(util.length(node_dictionary) > 1)
	end)
end)
