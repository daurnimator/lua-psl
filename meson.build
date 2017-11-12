project('lua-psl', 'c')

lua = dependency('lua')
luaversion = lua.version().split('.')
luavdir = luaversion.get(0) + '.' + luaversion.get(1)
lualdir = get_option('datadir') + '/lua/' + luavdir
luacdir = get_option('libdir') + '/lua/' + luavdir

psl = dependency('psl', required: false)
if not psl.found()
	psl = meson.get_compiler('c').find_library('psl')
endif

shared_module('psl',
	['psl/psl.c'],
	name_prefix: 'lua/' + luavdir + '/',
	dependencies: [lua, psl],
	install: true,
	install_dir: luacdir
)

test('linter', find_program('luacheck'),
	args: [meson.current_source_dir()]
)

test('test suite', find_program('busted'),
	workdir: meson.current_source_dir()
)
