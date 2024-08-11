local jsonschema = require("jsonschema")

describe("jsonschema testing", function()
	it("shoudl validate a basic schema", function()
		-- Note: Cache the result of the schema compilation as this is quite expensive
		local myvalidator = jsonschema.generate_validator({
			type = "object",
			properties = {
				foo = { type = "string" },
				bar = { type = "number" },
			},
		})

		assert(myvalidator({ foo = "hello", bar = 42 }))
	end)
end)
