M = {}

M.length = function(table)
	local count = 0

	for _ in pairs(table) do
		count = count + 1
	end

	return count
end
M.merge_tables = function(t1, t2)
	local mergedTable = {}
	for k, v in pairs(t1) do
		mergedTable[k] = v
	end
	for k, v in pairs(t2) do
		mergedTable[k] = v
	end
	return mergedTable
end

return M
