local M = {}

-- OS判定

-- 書式判定

-- 書式によるフォーマット
local res = require("reader").run()
print(res.format)
print(res.content)

-- ペースト処理

M.test = function()
	print("ok")
end

function M.setup()
	vim.api.nvim_create_user_command("SmartPaste", M.test, {})
end

return M
