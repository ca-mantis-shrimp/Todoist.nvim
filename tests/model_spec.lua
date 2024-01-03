local tree_converter = require("Todoist.model")

describe("Modeling Todoist for Display:", function()
	it("can convert a Project List to Tree Nodes", function()
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
				children = {},
				type = "project",
			},
		}
		local converted_dictionary = tree_converter.convert_projects_to_dictionary(minimal_projects)

		assert.are.equal(vim.inspect(example_output), vim.inspect(converted_dictionary))
	end)

	it("can convert a list of tasks into a dictionary", function()
		local task = {
			{
				user_id = 1,
				responsible_uid = nil,
				sync_id = nil,
				added_by_uid = 1,
				assigned_by_uid = 1,
				day_order = -1,
				parent_id = nil,
				all_day = false,
				child_order = 1,
				collapsed = 0,
				date_added = "2016-08-01T13:19:45Z",
				priority = 1,
				id = 102835615,
				content = "Task1",
				description = "",
				in_history = 0,
				is_deleted = 0,
				due = nil,
				project_id = 176637191,
				checked = 0,
				labels = {},
			},
		}

		local expected_output = {
			[102835615] = {
				user_id = 1,
				responsible_uid = nil,
				sync_id = nil,
				added_by_uid = 1,
				assigned_by_uid = 1,
				day_order = -1,
				parent_id = nil,
				all_day = false,
				child_order = 1,
				collapsed = 0,
				date_added = "2016-08-01T13:19:45Z",
				priority = 1,
				id = 102835615,
				content = "Task1",
				description = "",
				in_history = 0,
				is_deleted = 0,
				due = nil,
				project_id = 176637191,
				checked = 0,
				labels = {},
			},
		}

		local converted_dictionary = tree_converter.convert_tasks_to_dictionary(task)

		assert.are.equal(vim.inspect(expected_output), vim.inspect(converted_dictionary))
	end)
	it("can convert a dictionary into a tree", function()
		local nodes = { [1] = { parent_id = 2, children = {} }, [2] = { children = {} } }
		local expected_output = { [2] = { children = { [1] = { parent_id = 2, children = {} } } } }

		local tree = tree_converter.convert_to_todoist_tree(nodes)

		assert.are.equal(vim.inspect(tree), vim.inspect(expected_output))
	end)
	it("can can add the depth of a root node and its' children", function()
		local layered_node = {
			[1] = {
				parent_id = nil,
				children = {
					[2] = {
						parent_id = 1,
						children = {
							[3] = {
								parent_id = 2,
								children = {},
							},
						},
					},
				},
			},
		}

		local expected_node = {
			[1] = {
				parent_id = nil,
				depth = 0,
				children = {
					[2] = {
						parent_id = 1,
						depth = 1,
						children = {
							[3] = {
								parent_id = 2,
								depth = 2,
								children = {},
							},
						},
					},
				},
			},
		}

		tree_converter.set_node_depth_from_root(layered_node[1], 0)

		assert.are.equal(vim.inspect(expected_node), vim.inspect(layered_node))
	end)
	it("can update a tree with depth", function()
		local layered_tree = {
			[1] = {
				parent_id = nil,
				children = {
					[2] = {
						parent_id = 1,
						children = {
							[3] = {
								parent_id = 2,
								children = {},
							},
						},
					},
				},
			},
			[4] = {
				parent_id = nil,
				children = {
					[5] = {
						parent_id = 4,
						children = {},
					},
				},
			},
		}

		local expected_node = {
			[1] = {
				parent_id = nil,
				depth = 0,
				children = {
					[2] = {
						parent_id = 1,
						depth = 1,
						children = {
							[3] = {
								parent_id = 2,
								depth = 2,
								children = {},
							},
						},
					},
				},
			},
			[4] = {
				parent_id = nil,
				depth = 0,
				children = {
					[5] = {
						parent_id = 4,
						depth = 1,
						children = {},
					},
				},
			},
		}

		tree_converter.set_tree_depth(layered_tree)

		assert.are.equal(vim.inspect(expected_node), vim.inspect(layered_tree))
	end)
end)
