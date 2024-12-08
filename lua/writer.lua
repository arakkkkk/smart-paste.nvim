M = {}

M.write_text = function(text)
	local buf = vim.api.nvim_get_current_buf()
	-- 現在のカーソル位置を取得 (行と列)
	local row, col = table.unpack(vim.api.nvim_win_get_cursor(0))
	-- カーソル位置に文字列を挿入
	local lines = {}
	for line in text:gmatch("[^\n]+") do
		table.insert(lines, line)
	end
	vim.api.nvim_buf_set_text(buf, row - 1, col, row - 1, col, lines)
end

return M
