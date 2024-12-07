M = {}

M.format_html = function(html)
	-- ヘッダー（<h1>～<h6>）を変換
	html = html:gsub("<h(%d)>(.-)</h%1>", function(level, content)
		return string.rep("#", tonumber(level)) .. " " .. content
	end)

	-- コードブロック (<pre><code>...</code></pre>)
	html = html:gsub("<pre><code>(.-)</code></pre>", function(code)
		return "```\n" .. code .. "\n```"
	end)

	-- インラインコード (<code>...</code>)
	html = html:gsub("<code>(.-)</code>", function(code)
		return "`" .. code .. "`"
	end)

	-- ボーダー (<hr>)
	html = html:gsub("<hr ?/?>", "\n---\n")

	-- 順序なしリスト (<ul><li>...</li></ul>)
	html = html:gsub("<ul>(.-)</ul>", function(list)
		return list:gsub("<li>(.-)</li>", function(item)
			return "- " .. item
		end)
	end)

	-- 順序付きリスト (<ol><li>...</li></ol>)
	html = html:gsub("<ol>(.-)</ol>", function(list)
		local i = 0
		return list:gsub("<li>(.-)</li>", function(item)
			i = i + 1
			return i .. ". " .. item
		end)
	end)

	-- 不要なHTMLタグを削除
	html = html:gsub("<[^>]+>", "")

	-- トリム（不要な空白を削除）
	html = html:gsub("^%s+", ""):gsub("%s+$", "")

	return html
end

return M
