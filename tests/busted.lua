#!/usr/bin/env -S nvim -l

vim.env.LAZY_STDPATH = ".tests"
load(vim.fn.system("curl -s https://raw.githubusercontent.com/folke/lazy.nvim/main/bootstrap.lua"))()

require("lazy.minit").busted({
	spec = {
		{ "nvim-lua/plenary.nvim", lazy = true },
		{ "ca-mantis-shrimp/Todoist.nvim" },
	},
})
