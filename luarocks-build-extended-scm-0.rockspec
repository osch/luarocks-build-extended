package = "luarocks-build-extended"
version = "scm-0"
source = {
  url = "https://github.com/osch/luarocks-build-extended/archive/master.zip",
  dir = "luarocks-build-extended-master",
}
description = {
	summary = "A fork of Luarocks built-in build system",
	detailed = "luarocks-build-extended is a fork of Luarocks built-in build system which "..
	           "supports compiling C++ sources and specifying additional compiler and "..
	           "linker flags.",
	homepage = "http://github.com/osch/luarocks-build-extended",
	license = "MIT/X11"
}
dependencies = {
	"lua >= 5.1"
}
build = {
	type = "builtin",
	modules = {
		["luarocks.build.extended"]         = "src/luarocks/build/extended/init.lua",
		["luarocks.build.extended.util"]    = "src/luarocks/build/extended/util.lua" ,
		["luarocks.build.extended.builtin"] = "src/luarocks/build/extended/builtin.lua" ,
	},
	copy_directories = {}
}

