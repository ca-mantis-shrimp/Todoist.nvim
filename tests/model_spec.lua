local tree_converter = require("Todoist.model")

local minimal_projects = {
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
local example_output = {
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
describe("Converting Todoist Lists into Trees", function()
	it("can convert some projects into a dictionary", function()
		local converted_dictionary = tree_converter.convert_projects_to_dictionary(minimal_projects)

		assert.are.equal(vim.inspect(example_output), vim.inspect(converted_dictionary))
	end)

	it("can handle parental relationships for projects", function()
		local update_list = vim.deepcopy(minimal_projects)

		update_list[#update_list + 1] = {
			is_archived = false,
			color = "lime_green",
			shared = false,
			inbox_project = false,
			id = "220474324",
			collapsed = false,
			child_order = 0,
			name = "Child Project",
			is_deleted = false,
			parent_id = "220474323",
			view_style = "list",
		}

		local updated_expected_list = vim.deepcopy(example_output)

		updated_expected_list[220474324] = {
			name = "Child Project",
			parent_id = 220474323,
			inbox_project = false,
			collapsed = false,
			color = "lime_green",
			child_order = 0,
			is_archived = false,
			is_deleted = false,
			view_style = "list",
		}

		local converted_dictionary = tree_converter.convert_projects_to_dictionary(update_list)

		assert.are.equal(vim.inspect(converted_dictionary), vim.inspect(updated_expected_list))
	end)
end)
