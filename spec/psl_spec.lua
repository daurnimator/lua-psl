describe("psl", function()
	local psl_lib = require "psl"
	local function newer_than(x)
		if psl_lib.VERSION_NUMBER and psl_lib.VERSION_NUMBER >= x then
			return it
		end
		return pending
	end
	it("builtin returns same object each time", function()
		assert.equal(psl_lib.builtin(), psl_lib.builtin())
	end)
	it("__tostring works", function()
		local psl = psl_lib.builtin()
		local str = tostring(psl)
		assert.same("psl_ctx_t*: 0x", str:match("^.-0x"))
	end);
	newer_than(0x001000)("has working psl_lib.dist_filename()", function()
		local dist_filename = psl_lib.dist_filename()
		if dist_filename then
			assert.same("string", type(dist_filename))
		else
			assert.same(nil, dist_filename)
		end
	end);
	it("has working psl_lib.get_version()", function()
		assert.same("string", type(psl_lib.get_version()))
	end);
	newer_than(0x000b00)("has working psl_lib.check_version_number()", function()
		local version = psl_lib.check_version_number()
		assert.same("number", type(version))
		assert.same(false, psl_lib.check_version_number(version - 1))
	end);
	newer_than(0x000c00)("has psl_lib.TYPE field", function()
		assert.same("table", type(psl_lib.TYPE))
		assert.same("number", type(psl_lib.TYPE.ANY))
	end)
	describe("psl_lib.str_to_utf8lower()", function()
		it("works", function()
			assert.same("foo.com", psl_lib.str_to_utf8lower("foo.com"))
			assert.same("foo.com", psl_lib.str_to_utf8lower("FOO.com"))
		end)
		it("throws error on invalid arguments", function()
			assert.has.errors(function() psl_lib.str_to_utf8lower() end)
			assert.has.errors(function() psl_lib.str_to_utf8lower(nil) end)
			assert.has.errors(function() psl_lib.str_to_utf8lower({}) end)
			assert.has.errors(function() psl_lib.str_to_utf8lower("foo", {}) end)
			assert.has.errors(function() psl_lib.str_to_utf8lower("foo", nil, {}) end)
		end)
	end)
	it("can read the most basic of files", function()
		local file = io.tmpfile()
		assert(file:write("foo.bar"))
		assert(file:seek("set", 0))
		local psl = assert(psl_lib.load_fp(file))
		assert.same(1, psl:suffix_count())
		assert.same(0, psl:suffix_exception_count())
		assert.same(true, psl:is_public_suffix("bar"))
		assert.same(true, psl:is_public_suffix("foo.bar"))
		assert.same(false, psl:is_public_suffix("other.bar"))
		assert.same(false, psl:is_public_suffix("sub.foo.bar"))
		if psl_lib.VERSION then
			assert.same(0, psl:suffix_wildcard_count())
		end
		assert.same(true, psl:is_cookie_domain_acceptable("foo.bar", "foo.bar"))
		assert.same(false, psl:is_cookie_domain_acceptable("other.bar", "foo.bar"))
		assert.same(false, psl:is_cookie_domain_acceptable("foo.bar", "other.bar"))
		assert.same(false, psl:is_cookie_domain_acceptable("sub.foo.bar", "foo.bar"))
		assert.same(true, psl:is_cookie_domain_acceptable("sub.foo.bar", "sub.foo.bar"))
		assert.same(true, psl:is_cookie_domain_acceptable("qux.sub.foo.bar", "sub.foo.bar"))
	end);
	newer_than(0x001000)("has working psl_lib.latest()", function()
		psl_lib.latest()
	end);
end)
