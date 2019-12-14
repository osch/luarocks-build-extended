package = "moduletest02"
version = "scm-0"
source = {
  url = "https://github.com/osch/moduletest02/archive/master.zip",
  dir = "moduletest02-master",
}
description = {
  summary = "Example",
  homepage = "https://github.com/osch/moduletest02",
  license = "MIT/X11",
  detailed = [[
  ]],
}
dependencies = {
  "lua >= 5.1, < 5.4",
}
build = {
  type = "extended",
  modules = {
    moduletest02 = {
      sources = { 
          "main.cpp",
      },
      variables = { 
          CFLAG_EXTRAS= { "-D", "EXAMPLE_VERSION=V1" }
      },
    },
  }
}
