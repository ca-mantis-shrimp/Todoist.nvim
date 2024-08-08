M = {}

---@param projects table[] #list of projects
---@param nodes table<integer, table> #key-value table to add projects to
---@return table<integer, table> nodes #the updated key-value table
local function add_projects_to_nodes(projects, nodes)
	assert(projects, "Projects cannot be nil")
	for _, project in pairs(projects) do
		project["type"] = "project"
		table.insert(nodes, project)
	end
	return nodes
end

---@param project_notes table[] #list of projects
---@param nodes table<integer, table> #key-value table to add projects to
---@return table<integer, table> nodes #the updated key-value table
local function add_project_notes_to_nodes(project_notes, nodes)
	assert(project_notes, "Project notes cannot be nil")
	for _, note in pairs(project_notes) do
		note["type"] = "project_note"
		table.insert(nodes, note)
	end
	return nodes
end

---@param sections table[] #list of projects
---@param nodes table<integer, table> #key-value table to add projects to
---@return table<integer, table> nodes #the updated key-value table
local function add_sections_to_nodes(sections, nodes)
	assert(sections, "Sections cannot be nil")
	for _, section in pairs(sections) do
		section["type"] = "section"
		table.insert(nodes, section)
	end
	return nodes
end

---@param tasks table[] #list of projects
---@param nodes table<integer, table> #key-value table to add projects to
---@return table<integer, table> nodes #the updated key-value table
local function add_tasks_to_nodes(tasks, nodes)
	assert(tasks, "tasks cannot be nil")
	for _, task in pairs(tasks) do
		task["type"] = "task"
		table.insert(nodes, task)
	end
	return nodes
end

M.create_task_node_dictionary = function(types)
	local nodes = {}

	add_projects_to_nodes(types.projects, nodes)
	add_tasks_to_nodes(types.items, nodes)

	return nodes
end

---@param nodes table<integer, table> #Dictionary of types with type name as key
---@param types table<string, table> #Dictionary of types with type name as key
---@return table<integer, table>|nil #errors if empty
M.create_project_node_dictionary = function(nodes, types)
	assert(types, "dictionary source cannot be nil")
	assert(nodes, "nodes cannot be nil")

	local project_add_successful, project_add_results = pcall(add_projects_to_nodes, types.projects, nodes)
	if not project_add_successful then
		error(project_add_results, 2)
	end

	local section_add_successful, section_add_results = pcall(add_sections_to_nodes, types.sections, nodes)
	if not section_add_successful then
		error(section_add_results, 2)
	end

	local notes_add_successful, notes_add_results = pcall(add_project_notes_to_nodes, types.project_notes, nodes)
	if not notes_add_successful then
		error(notes_add_results, 2)
	end

	return nodes
end

return M
