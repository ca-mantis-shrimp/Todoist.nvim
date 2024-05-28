M = {}

local function set_node_depth_from_root(node, depth)
	assert(node, "Node cannot be nil")
	assert(type(depth) == "number", "depth must be a number")

	node.depth = depth
	if node.children then
		for _, child in pairs(node.children) do
			assert(pcall(set_node_depth_from_root, child, depth + 1))
		end
	end
end

local function set_tree_depth(tree)
	assert(tree, "tree cannot be nil")

	for _, root_node in pairs(tree) do
		assert(pcall(set_node_depth_from_root, root_node, 0))
	end
end

M.create_tree = function(nodes)
	local root_nodes = {}

	assert(nodes, "nodes cannot be nil")

	for id, node in pairs(nodes) do
		if node.parent_id then
			nodes[node.parent_id].children[id] = node
		else
			root_nodes[id] = node
		end
	end

	assert(pcall(set_tree_depth, root_nodes))

	return root_nodes
end

return M
