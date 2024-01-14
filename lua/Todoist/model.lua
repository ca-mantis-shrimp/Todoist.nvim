M = {}

M.create_node_dictionary = function(types)
	local nodes = {}

	M.add_projects_to_nodes_immutably(types.projects, nodes)
	M.add_tasks_to_nodes_immutably(types.items, nodes)

	return nodes
end

M.add_projects_to_nodes_immutably = function(projects, nodes)
	for _, project in ipairs(projects) do
		nodes[tonumber(project.id)] = {
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
end

M.add_tasks_to_nodes_immutably = function(tasks, nodes)
	for _, task in ipairs(tasks) do
		nodes[tonumber(task.id)] = {
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
end

return M
