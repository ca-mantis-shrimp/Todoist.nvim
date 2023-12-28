local tree = require("nui.tree")
local NuiLine = require("nui.line")

M = {}

M.create_todoist_tree = function(buffer_number, node_list)
	return tree({
		bufnr = buffer_number,
		nodes = node_list,
		get_node_id = M.get_node_id,
		prepare_node = M.prepare_node_func,
	})
end

M.convert_to_node_list = function(list)
	local node_list = {}

	for _, value in ipairs(list) do
		table.insert(node_list, M.convert_to_node(value))
	end

	return node_list
end

M.convert_to_node = function(node_data)
	return tree.Node(node_data)
end

M.prepare_node_func = function(node)
	return "> " .. node.text
end

M.get_node_id = function(node)
	return node.id
end

return M
