local M = {}

M.smart_paste = function()
	-- OS判定

	-- 書式判定
	local format, content, err = require("reader").read()

	-- 書式によるフォーマット
	local content_treated = require("formatter").format(format, content)

	-- ペースト処理
	require("writer").write_text(content_treated)
end

function M.setup()
	vim.api.nvim_create_user_command("SmartPaste", M.smart_paste, {})
end

return M
