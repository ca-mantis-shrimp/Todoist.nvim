M = {}

local util = require("Todoist.util")

local function calculate_icon_depth(node, icon)
	return vim.fn["repeat"](icon, node.depth + 1)
end

local function get_collapsed_icon(node)
	if util.length(node.children) > 0 then
		if node.collapsed then
			return ">"
		else
			return "v"
		end
	else
		return ""
	end
end

local function get_project_icon(node)
	return "#"
end

local function get_project_note_icon(node)
	return "+"
end

local function get_task_icon(node)
	if node.checked then
		return "[x]"
	else
		return "[ ]"
	end
end

local icon_calculators = { project = get_project_icon, project_note = get_project_note_icon, task = get_task_icon }

local function add_buffer_lines_from_node(lines, node)
	local icon = icon_calculators[node.type](node)
	local depth_display = calculate_icon_depth(node, icon)
	local collapsed_icon = get_collapsed_icon(node)

	table.insert(lines, depth_display .. collapsed_icon .. " " .. node.name)

	if util.length(node.children) == 0 or node.collapsed then
		return lines
	else
		for _, child in pairs(node.children) do
			add_buffer_lines_from_node(lines, child)
		end
	end

	return lines
end

M.get_buffer_lines_from_tree = function(tree)
	local lines = {}

	for _, node in pairs(tree) do
		lines = add_buffer_lines_from_node(lines, node)
	end

	return lines
end

return M
