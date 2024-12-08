M = {}

M.format = function(type, content)
	if type == "text/html" then
		return M.format_html(content)
	else
		return content
	end
end

M.format_html = function(html)
	local cmd = "echo '" .. html .. "' | pandoc --from=html --to=markdown --strip-comments"
	local handle = io.popen(cmd)
	local content = handle:read("*a")
	local success, _, _ = handle:close()

	if not success or content == "" then
		return nil
	end

	-- ::: zeroclipboard-container
	-- :::
	content = content:gsub("\n:::%s?[^\n]*", "")
	content = content:gsub("^:::%s?[^\n]*\n", "")

	-- [![](data:image/svg+xml;base64,PHN2ZyBjbGFzcz0ib2N0aWNvbiBvY3RpY29uLWxpbmsiIHZpZXdib3g9IjAgMCAxNiAxNiIgdmVyc2lvbj0iMS4xIiB3aWR0aD0iMTYiIGhlaWdodD0iMTYiIGFyaWEtaGlkZGVuPSJ0cnVlIj48L3N2Zz4=){.octicon
	-- .octicon-link}](https://github.com/arakkkkk/smart-paste.nvim#test){#user-content-test
	-- .anchor aria-label="Permalink: test"}
	content = content:gsub("%(.-%)%{.-%}", "")
	content = content:gsub("%[!%[.-%]%]\n", "")

	-- ## test {#test .heading-element tabindex="-1" dir="auto"}
	content = content:gsub(" %{.-%}\n", "")
	content = content:gsub(" %{.-%}$", "")

	-- -   list
	content = content:gsub("\n(%s*)%-   ", "\n%1- ")

	return content
end

return M
