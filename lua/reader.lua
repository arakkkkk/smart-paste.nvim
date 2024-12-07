M = {}
local formats = {
	"image/png",
	"text/html",
	"text/richtext",
	"text/plain",
}

M.get_os = function()
	if vim.fn.has("win32") == 1 then
		return "Windows"
	end

	local this_os = tostring(io.popen("uname"):read())
	if this_os == "Linux" and vim.fn.readfile("/proc/version")[1]:lower():match("microsoft") then
		this_os = "Wsl"
	end
	return this_os
end

M.read = function()
	local cmd = ""
	local this_os = M.get_os()
	if this_os == "Linux" then
		local display_server = os.getenv("XDG_SESSION_TYPE")
		if display_server == "x11" or display_server == "tty" then
			cmd = "xclip -selection clipboard -o -t TARGETS"
		elseif display_server == "wayland" then
			cmd = "wl-paste --list-types"
		end
	elseif this_os == "Darwin" then
		cmd = "pngpaste -b 2>&1"
	elseif this_os == "Windows" or this_os == "Wsl" then
		cmd = "Get-Clipboard -Format Image"
		cmd = 'powershell.exe "' .. cmd .. '"'
	end

	local handle = io.popen(cmd)
	local clip_f = handle:read("*a")
	local success, _, _ = handle:close()

	if not success or clip_f == "" then
		return nil, "check command failed!"
	end

	for _, format in ipairs(formats) do
		print(format)
		if clip_f:find(format) then
			return format
		end
	end

	return nil, "unknown format!"
end

return M
