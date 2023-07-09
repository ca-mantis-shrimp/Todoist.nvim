local tree = require("nui.tree")
local M = {}

function M.show_project_list(ui_opts, data)
	local project_list = {}

	for project in data do
		M.append_node_to_list(project_list, project)
	end
	local project_tree = tree.NuiTree({
		bufnr = vim.api.nvim_create_buf(false, true),
		data = project_list,
	})

	project_tree.render()
end

function M.append_node_to_list(tree, node)
	return tree.append(tree.Node(node))
end

return M
