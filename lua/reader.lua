M = {}
local formats = {
	"image/png",
	"text/html",
	"text/richtext",
	"text/plain",
}

-- フォーマット判定関数
M.read = function()
	for _, format in ipairs(formats) do
		-- xclipでデータ取得を試みる
		local handle = io.popen("xclip -gelection clipboard -target " .. format .. " -o 2>/dev/null")
		local content = handle:read("*a")
		local success, _, _ = handle:close()

		if success and content ~= "" then
			-- 成功した場合、結果を保存
			return format, content, nil
		end
	end
	return nil, nil, "ERROR: Clipboad cant retrieved!"
end

return M
