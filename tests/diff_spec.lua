local diff = require("Todoist.diff")
describe("Calculating Diffs", function()
	it("can represent an addition", function()
		local old = "this is a test\n"
		local new = "this is a test\nof another string\n"

		local result = diff.create_diff_dictionary(old, new)

		assert.are.same(vim.inspect({ ["-1,0 +2"] = "of another string" }), vim.inspect(result))
	end)
end)
