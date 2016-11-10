package = "psl"
version = "scm-0"
source = {
	url = "git+https://github.com/daurnimator/lua-psl.git";
}
description = {
	detailed = "Bindings to libpsl, a C library that handles the Public Suffix List (PSL).";
	homepage = "https://github.com/daurnimator/lua-psl";
	license = "MIT";
}
dependencies = {}
external_dependencies = {
	PSL = {
		header = "libpsl.h";
		library = "psl";
	};
}
build = {
	type = "builtin";
	modules = {
		psl = {
			sources = "psl/psl.c";
			libraries = {
				"psl";
			};
			defines = {
			};
			incdirs = {
				"$(PSL_INCDIR)";
			};
			libdirs = {
				"$(PSL_LIBDIR)";
			};
		};
	};
}
