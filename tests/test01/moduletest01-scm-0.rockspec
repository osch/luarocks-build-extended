package = "moduletest01"
version = "scm-0"
source = {
  url = "https://github.com/osch/moduletest01/archive/master.zip",
  dir = "moduletest01-master",
}
description = {
  summary = "Example",
  homepage = "https://github.com/osch/moduletest01",
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
    moduletest01 = {
      sources = { 
          "main.cpp",
      },
      defines = { "EXAMPLE_VERSION=V1" },
    },
  }
}