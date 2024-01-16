M = {}

local function add_projects_to_nodes(projects, nodes)
	for _, project in ipairs(projects) do
		nodes[tonumber(project.id)] = {
			name = project.name,
			parent_id = tonumber(project.parent_id) or nil, -- captures the parent id if a subproject, sets nil otherwise
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

local function add_tasks_to_nodes(tasks, nodes)
	for _, task in ipairs(tasks) do
		nodes[tonumber(task.id)] = {
			name = task.content,
			description = task.description,
			checked = task.checked,
			priority = task.priority,
			due = task.due,
			all_day = task.all_day,
			day_order = task.day_order,
			labels = task.labels,
			parent_id = tonumber(task.parent_id) or tonumber(task.project_id), -- cpatures the parent id if a subtask, sets project otherwise
			child_order = task.child_order,
			collapsed = task.collapsed,
			date_added = task.date_added,
			in_history = task.in_history,
			is_deleted = task.is_deleted,
			sync_id = task.sync_id,
			children = {},
			type = "task",
		}
	end
end

M.create_node_dictionary = function(types)
	local nodes = {}

	add_projects_to_nodes(types.projects, nodes)
	add_tasks_to_nodes(types.items, nodes)

	return nodes
end

return M
