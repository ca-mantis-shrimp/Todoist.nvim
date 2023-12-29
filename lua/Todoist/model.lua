M = {}

M.convert_projects_to_dictionary = function(projects)
	local dictionary = {}

	for _, project in ipairs(projects) do
		dictionary[tonumber(project.id)] = {
			name = project.name,
			parent_id = project.parent_id,
			inbox_project = project.inbox_project,
			collapsed = project.collapsed,
			color = project.color,
			child_order = project.child_order,
			is_archived = project.is_archived,
			is_deleted = project.is_deleted,
			view_style = project.view_style,
		}
	end

	return dictionary
end

return M
