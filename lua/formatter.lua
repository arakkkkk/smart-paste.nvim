M = {}

M.format_html = function(html)
	local cmd = "echo '" .. html .. "' | pandoc --from=html --to=markdown --strip-comments"
	local handle = io.popen(cmd)
	local content = handle:read("*a")
	local success, _, _ = handle:close()

	if not success or content == "" then
		return nil
	end

	content = content:gsub("\n:::%s?[^\n]*", "")
	content = content:gsub("^:::%s?[^\n]*\n", "")

	content = content:gsub("%(.-%)%{.-%}", "")
	content = content:gsub("%[!%[.-%]%]\n", "")

	content = content:gsub(" %{.-%}\n", "")
	content = content:gsub(" %{.-%}$", "")

	content = content:gsub("\n(%s*)%-   ", "\n%1- ")

	return content
end

return M
