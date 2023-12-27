local tree = require("nui.tree")

M = {}

M.convert_to_node = function(node_data)
	return tree.Node({ data = node_data })
end

M.convert_to_tree = function(buffer_number, node_list)
	return tree({
		bufnr = buffer_number,
		nodes = node_list,
		get_node_id = function(node)
			return node.id
		end,
	})
end

return M
