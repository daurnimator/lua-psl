describe("psl", function()
	local psl_lib = require "psl"
	it("__tostring works", function()
		local psl = psl_lib.builtin()
		local str = tostring(psl)
		assert.same("psl_ctx_t*: 0x", str:match("^.-0x"))
	end)
end)
