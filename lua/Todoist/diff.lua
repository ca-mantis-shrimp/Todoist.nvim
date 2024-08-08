local M = {}
M.create_diff_dictionary = function(str_1, str_2)
	local diff_list = vim.split(vim.diff(str_1, str_2, { ignore_cr_at_eol = true }), "@@")

	local diff_dict = {}
	for index, value in ipairs(diff_list) do
		if index % 2 == 0 then
			diff_dict[value] = diff_list[index + 1]
		end
	end

	return diff_dict
end
return M
