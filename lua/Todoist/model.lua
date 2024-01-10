M = {}

M.create_node_dictionary = function(types, conversions)
	local nodes = {}

	for type, data in pairs(types) do
		nodes = conversions[type](data, nodes)
	end

	return nodes
end

M.type_conversions = { ["projects"] = M.add_projects_to_nodes_immutably, ["items"] = M.add_tasks_to_nodes_immutably }

M.add_projects_to_nodes_immutably = function(projects, nodes)
	local copy = vim.deepcopy(nodes)

	for _, project in ipairs(projects) do
		copy[tonumber(project.id)] = {
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

	return copy
end

M.add_tasks_to_nodes_immutably = function(tasks, nodes)
	local copy = vim.deepcopy(nodes)

	for _, task in ipairs(tasks) do
		copy[tonumber(task.id)] = {
			content = task.content,
			description = task.description,
			checked = task.checked,
			priority = task.priority,
			due = task.due,
			all_day = task.all_day,
			day_order = task.day_order,
			labels = task.labels,
			parent_id = task.parent_id or task.project_id,
			child_order = task.child_order,
			collapsed = task.collapsed,
			date_added = task.date_added,
			in_history = task.in_history,
			is_deleted = task.is_deleted,
			sync_id = task.sync_id,
			type = "task",
		}
	end

	return copy
end

return M
