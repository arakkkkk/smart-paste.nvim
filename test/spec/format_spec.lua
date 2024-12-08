local smart_paste = require("smart-paste")

describe("smart-paste", function()
	it("works!", function()
		local file, err = io.open("./mock/test1.html", "r")
		local content = file:read("*a") -- ファイル全体を読み込む
		file:close()

		local formatter = require("formatter")
		local res = formatter.format_html(content)

		local tmp_file, err = io.open("./mock/test1.md", "r")
		local template = tmp_file:read("*a") -- ファイル全体を読み込む
		tmp_file:close()

		assert(res == template)
	end)
end)
