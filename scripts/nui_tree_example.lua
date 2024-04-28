local NuiTree = require("nui.tree")

local bufnr = vim.api.nvim_create_buf(false, true)

vim.api.nvim_open_win(bufnr, true, {
	relative = "editor",
	width = 30,
	height = 10,
	row = 1,
	col = 1,
	style = "minimal",
})

local tree = NuiTree({
	bufnr = bufnr,
	nodes = {
		NuiTree.Node({ text = "a" }),
		NuiTree.Node({ text = "b" }, {
			NuiTree.Node({ text = "b-1" }),
			NuiTree.Node({ text = { "b-2", "b-3" } }),
		}),
	},
})

tree:render()
