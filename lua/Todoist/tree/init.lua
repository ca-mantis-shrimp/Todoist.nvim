M = {}

M.create_tree = function(nodes)
	local root_nodes = {}

	for id, node in pairs(nodes) do
		if node.parent_id then
			nodes[node.parent_id].children[id] = node
		else
			root_nodes[id] = node
		end
	end

	return root_nodes
end

M.set_tree_depth_immutably = function(tree, root_node_depth_function)
	local copy = vim.deepcopy(tree)

	for _, root_node in pairs(copy) do
		root_node_depth_function(root_node, 0)
	end

	return copy
end

M.set_node_depth_from_root = function(node, depth)
	node.depth = depth
	for _, child in pairs(node.children) do
		M.set_node_depth_from_root(child, depth + 1)
	end
end

return M
