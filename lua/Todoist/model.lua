local tree = require("nui.tree")

M = {}

M.convert_to_node = function(node_data)
	return tree.Node({ data = node_data })
end

return M
