local config = require("Todoist.config")
local request = require("Todoist.request_utilities")
local curl = require("plenary.curl")

local opts = { api_key = "e0007362ae4002e7ce38bc9cf5f17b71f3fc6750", default_window_type = "float" }
config.config(opts)

local projects = request.process_response(curl.request(request.create_sync_request(config.api_key)))
local reduced_response = request.reduce_response(projects)

print(vim.inspect(reduced_response))
