M = {}

M.convert_projects_to_dictionary = function(projects)
	local project_copy = projects

	local dictionary = {}

	for _, project in ipairs(project_copy) do
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
	for id, node in pairs(tree) do
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
