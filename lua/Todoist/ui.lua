local nui = require("nui")
local M = {}

function M.show_project_list(ui_opts, data)
	local project_list = {}

	for project in data do
		M.append_node_to_list(project_list, project)
	end
	local project_tree = nui.tree.NuiTree({
		bufnr = vim.api.nvim_create_buf(false, true),
		data = project_list,
	})

	project_tree.render()
end

function M.append_node_to_list(tree, node)
	return tree.append(nui.tree.Node(node))
end
