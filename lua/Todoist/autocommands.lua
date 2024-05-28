local M = {}
--Ensure the autocommands group 'AutoIndentProjects' exists and is clear
M.create_indent_autocmd = function()
	vim.api.nvim_create_augroup("AutoIndentProjects", { clear = true })

	-- Create an autocommand for `.projects` files
	vim.api.nvim_create_autocmd("BufEnter", {
		group = "AutoIndentProjects",
		pattern = "*.projects",
		callback = function()
			vim.cmd("normal gg=G")
		end,
		desc = "Auto-indent .projects files",
	})
end

return M
