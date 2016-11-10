#include <libpsl.h>

#include <lua.h>
#include <lauxlib.h>

static const psl_ctx_t **luapsl_preppslctx(lua_State *L) {
	const psl_ctx_t **ud = lua_newuserdata(L, sizeof(psl_ctx_t*));
	*ud = NULL;
	luaL_setmetatable(L, "psl_ctx_t*");
	return ud;
}

static void luapsl_pushpslctx(lua_State *L, const psl_ctx_t *psl) {
	if (psl == NULL) {
		lua_pushnil(L);
	} else {
		const psl_ctx_t **ud = luapsl_preppslctx(L);
		*ud = psl;
	}
}

static const psl_ctx_t *luapsl_checkpslctx(lua_State *L, int idx) {
	const psl_ctx_t **ud = luaL_checkudata(L, idx, "psl_ctx_t*");
	return *ud;
}

static int luapsl__tostring(lua_State *L) {
	const psl_ctx_t *psl = luapsl_checkpslctx(L, 1);
	lua_pushfstring(L, "psl_ctx_t*: %p", psl);
	return 1;
}

static int luapsl_free(lua_State *L) {
	psl_ctx_t **ud = luaL_checkudata(L, 1, "psl_ctx_t*");
	if (*ud != NULL && *ud != psl_builtin()) {
		psl_free(*ud);
		*ud = NULL;
	}
	return 0;
}

/* builtin is cached in upvalue */
static int luapsl_builtin(lua_State *L) {
	lua_pushvalue(L, lua_upvalueindex(1));
	return 1;
}

int luaopen_psl(lua_State *L) {
	static const luaL_Reg lib[] = {
		{"free", luapsl_free},
		{NULL, NULL}
	};

	/* create psl metatable */
	luaL_newmetatable(L, "psl_ctx_t*");
	lua_pushcfunction(L, luapsl_free);
	lua_setfield(L, -2, "__gc");
	lua_pushcfunction(L, luapsl__tostring);
	lua_setfield(L, -2, "__tostring");
	lua_pop(L, 1);

	luaL_newlib(L, lib);

	/* cache builtin as upvalue so same pointer is returned every time */
	luapsl_pushpslctx(L, psl_builtin());
	lua_pushcclosure(L, luapsl_builtin, 1);
	lua_setfield(L, -2, "builtin");

	return 1;
}
