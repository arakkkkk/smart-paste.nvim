local smart_paste = require("smart-paste")
print("\n\n\n\n\n\n\n")

describe("smart-paste", function()
	it("works!", function()
		local content = ""
		local formatter = require("formatter")
		local res = formatter.format_html(content)
		print(res)
	end)
end)
