rockspec_format = "3.0"
package = "todoist-nvim"
version = "scm-1"

description = {
	summary = "Neovim Client for Todoist to edit items using vim motions",
	labels = { "neovim" },
	homepage = "https://github.com/ca-mantis-shrimp/Todoist.nvim",
	license = "GPL-3.0",
}

source = {
	url = "git://github.com/ca-mantis-shrimp/Todoist.nvim",
}
dependencies = {
	"lua == 5.1",
	"jsonschema ~> 0.9.7",
}

build = {
	type = "builtin",
}
