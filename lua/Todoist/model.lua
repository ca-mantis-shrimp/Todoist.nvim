M = {}

M.convert_projects_to_dictionary = function(projects)
	local dictionary = {}

	for _, project in ipairs(projects) do
		dictionary[tonumber(project.id)] = {
			name = project.name,
			parent_id = tonumber(project.parent_id),
			inbox_project = project.inbox_project,
			collapsed = project.collapsed,
			color = project.color,
			child_order = project.child_order,
			is_archived = project.is_archived,
			is_deleted = project.is_deleted,
			view_style = project.view_style,
			children = {},
			type = "project",
		}
	end

	return dictionary
end

M.convert_tasks_to_dictionary = function(tasks)
	local dictionary = {}

	for _, task in ipairs(tasks) do
		dictionary[tonumber(task.id)] = {
			content = task.content,
			description = task.description,
			checked = task.checked,
			priority = task.priority,
			due = task.due,
			all_day = task.all_day,
			day_order = task.day_order,
			labels = task.labels,
			project_id = tonumber(task.project_id),
			parent_id = tonumber(task.parent_id),
			child_order = task.child_order,
			collapsed = task.collapsed,
			date_added = task.date_added,
			in_history = task.in_history,
			is_deleted = task.is_deleted,
			sync_id = task.sync_id,
		}

		return dictionary
	end
end

M.convert_to_todoist_tree = function(nodes)
	local root_nodes = {}

	for id, node in ipairs(nodes) do
		if node.parent_id then
			nodes[node.parent_id].children[id] = node
		else
			root_nodes[id] = node
		end
	end

	return root_nodes
end

M.set_tree_depth = function(tree)
	for id, _ in pairs(tree) do
		M.set_node_depth_from_root(tree[id], 0)
	end
end

M.set_node_depth_from_root = function(node, depth)
	node.depth = depth
	for _, child in pairs(node.children) do
		M.set_node_depth_from_root(child, depth + 1)
	end
end

return M
