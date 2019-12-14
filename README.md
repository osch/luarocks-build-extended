# luarocks-build-extended

[![Licence](http://img.shields.io/badge/Licence-MIT-brightgreen.svg)](LICENSE)
[![Build Status](https://travis-ci.com/osch/luarocks-build-extended.png?branch=master)](https://travis-ci.com/osch/luarocks-build-extended)
[![Build status](https://ci.appveyor.com/api/projects/status/0ooqnhlu5rh0q8cd/branch/master?svg=true)](https://ci.appveyor.com/project/osch/luarocks-build-extended/branch/master)
[![Install](https://img.shields.io/badge/Install-LuaRocks-brightgreen.svg)](https://luarocks.org/modules/osch/luarocks-build-extended)


A fork of Luarocks built-in build system. 

Specify `"extended"` as build type and `"luarocks-build-extended"` as dependency to use it (see example below). 

* Support for compiling C++ sources, similar to [luarocks-build-cpp].
  C++ files are detected by file extensions (`.cpp`, `.cxx` or `.cc`)
  For C++ compiling g++ is not used, gcc with stdc++ library is. 
* Support for module specific variables (see also https://github.com/luarocks/luarocks/pull/368 
  or https://github.com/luarocks/luarocks/issues/367):
   * CFLAG_EXTRAS list of additional C compiler arguments
   * CXXFLAG_EXTRAS list of additional C++ compiler arguments
   * LIBFLAG_EXTRAS list of additional linker arguments

[luarocks-build-cpp]: https://luarocks.org/modules/osch/luarocks-build-cpp

## Example rockspec

```lua

package = "name"
version = "0.1-1"
source = {
    url = "git://github.com/username/name.git"
}
description = {
    summary = "...",
    detailed = "...",
    homepage = "http://github.com/username/name",
    license = "MIT/X11"
}
dependencies = {
    "lua >= 5.1, < 5.3",
    "luarocks-build-extended"
}
build = {
    type = "extended",
    platforms = {
        macosx = {
            modules = {
                name = {
                    variables = {
                        LIBFLAG_EXTRAS = { 
                            "-framework", "Cocoa" 
                        }
                    }
                }
            }
        }
    },
    modules = {
        name = {
            sources = {
                "name.cpp",
                "aux.cpp"
            }
        }
    }
}

```


