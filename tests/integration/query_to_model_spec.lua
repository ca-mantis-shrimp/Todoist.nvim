local query = require("Todoist.query")
local curl = require("plenary.curl")
local model = require("Todoist.model")

-- describe("integration between the query module and the todoist model", function()
-- 	it("should be able to create a node dictionary from a successful query", function()
-- 		==local response = query.reduce_response(query.get_all_projects("e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", curl))
--
-- 		--local node_dictionary = model.create_node_dictionary(response, model.type_conversions)
--
-- 		local expected_dictionary = {
-- 			[1] = { id = 1, name = "test_project", parent_id = nil, children = {} },
-- 		}
--
-- 		assert.are.equal(vim.inspect(response), vim.inspect(expected_dictionary))
-- 	end)
-- end)
