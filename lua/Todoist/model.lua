M = {}

local function add_projects_to_nodes(projects, nodes)
	for _, project in pairs(projects) do
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
			id = tonumber(project.id),
			children = {},
			type = "project",
		}
	end
end

local function add_project_notes_to_nodes(project_notes, nodes)
	for _, note in pairs(project_notes) do
		nodes[tonumber(note.id)] = {
			name = note.content,
			parent_id = tonumber(note.project_id),
			is_deleted = note.is_deleted,
			id = tonumber(note.id),
			type = "project_note",
		}
	end
end

local function add_sections_to_nodes(sections, nodes)
	for _, section in pairs(sections) do
		nodes[tonumber(section.id)] = {
			name = section.name,
			parent_id = tonumber(section.project_id),
			is_deleted = section.is_deleted,
			id = tonumber(section.id),
			order = section.order,
			type = "section",
		}
	end
end

local function add_tasks_to_nodes(tasks, nodes)
	for _, task in pairs(tasks) do
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
			id = tonumber(task.id),
			in_history = task.in_history,
			is_deleted = task.is_deleted,
			sync_id = task.sync_id,
			children = {},
			type = "task",
		}
	end
end

M.create_task_node_dictionary = function(types)
	local nodes = {}

	add_projects_to_nodes(types.projects, nodes)
	add_tasks_to_nodes(types.items, nodes)

	return nodes
end

M.create_project_node_dictionary = function(types)
	local nodes = {}

	add_projects_to_nodes(types.projects, nodes)
	add_sections_to_nodes(types.sections, nodes)
	add_project_notes_to_nodes(types.project_notes, nodes)

	nodes.sync_token = types.sync_token
	return nodes
end

return M
