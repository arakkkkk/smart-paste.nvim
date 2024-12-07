M = {}
local formats = {
	"image/png",
	"text/html",
	"text/richtext",
	"text/plain",
}

-- フォーマット判定関数
M.run = function()
	for _, format in ipairs(formats) do
		-- xclipでデータ取得を試みる
		local handle = io.popen("xclip -selection clipboard -target " .. format .. " -o 2>/dev/null")
		local content = handle:read("*a")
		local success, _, _ = handle:close()

		if success and content ~= "" then
			-- 成功した場合、結果を保存
			return { format = format, content = content }
		end
	end
	return nil
end

return M
