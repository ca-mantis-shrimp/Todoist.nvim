M = {}

local util = require("Todoist.util")

local function calculate_icon_depth(node, icon)
	return vim.fn["repeat"](icon, node.depth + 1)
end

local function get_project_icon(_)
	return "#"
end

local function get_project_note_icon(_)
	return "+"
end

local function get_section_icon(_)
	return "&"
end

local function get_task_icon(node)
	if node.checked then
		return "[x]"
	else
		return "[ ]"
	end
end

local icon_calculators = {
	project = get_project_icon,
	project_note = get_project_note_icon,
	task = get_task_icon,
	section = get_section_icon,
}

local function add_buffer_lines_from_node(lines, node)
	local icon = icon_calculators[node.type](node)
	if node.type == "project" then
		local depth_display = calculate_icon_depth(node, icon)

		table.insert(lines, depth_display .. " " .. node.name .. "|>" .. node.id)
	else
		table.insert(lines, icon .. " " .. node.name .. "|>" .. node.id)
	end

	if node.children == nil or util.length(node.children) == 0 then
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
