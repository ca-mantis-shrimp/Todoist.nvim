M = {}

local function set_node_depth_from_root(node, depth)
	node.depth = depth

	for _, child in pairs(node.children) do
		set_node_depth_from_root(child, depth + 1)
	end
end

local function set_tree_depth(tree)
	for _, root_node in pairs(tree) do
		set_node_depth_from_root(root_node, 0)
	end
end

M.create_tree = function(nodes)
	local root_nodes = {}

	for id, node in pairs(nodes) do
		if node.parent_id then
			nodes[node.parent_id].children[id] = node
		else
			root_nodes[id] = node
		end
	end

	set_tree_depth(root_nodes)

	return root_nodes
end

return M
