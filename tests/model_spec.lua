local tree_converter = require("Todoist.model")

describe("Converting Todoist Types into nui.nvim Tree", function()
	it("Can convert a single, empty inbox project into a Tree", function()
		local inbox_projects = {
			{
				is_archived = false,
				color = "lime_green",
				shared = false,
				inbox_project = true,
				id = "220474322",
				collapsed = false,
				child_order = 0,
				name = "Inbox",
				is_deleted = false,
				parent_id = nil,
				view_style = "list",
			},
			{
				is_archived = false,
				color = "lime_green",
				shared = false,
				inbox_project = false,
				id = "220474323",
				collapsed = false,
				child_order = 1,
				name = "Another Project",
				is_deleted = false,
				parent_id = nil,
				view_style = "list",
			},
		}

		local expected_dictionary = {
			[220474322] = {
				name = "Inbox",
				parent_id = nil,
				inbox_project = true,
				collapsed = false,
				color = "lime_green",
				child_order = 0,
				is_archived = false,
				is_deleted = false,
				view_style = "list",
			},
			[220474323] = {
				name = "Another Project",
				parent_id = nil,
				inbox_project = false,
				collapsed = false,
				color = "lime_green",
				child_order = 1,
				is_archived = false,
				is_deleted = false,
				view_style = "list",
			},
		}

		local converted_dictionary = tree_converter.convert_projects_to_dictionary(inbox_projects)

		assert.are.equal(vim.inspect(expected_dictionary), vim.inspect(converted_dictionary))
	end)
end)
