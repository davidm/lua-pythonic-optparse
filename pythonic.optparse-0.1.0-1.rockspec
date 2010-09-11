package = "pythonic.optparse"
version = "0.1.0-1"
source = {
   url = "http://math2.org/download/lua-pythonic-optparse-0.1.tar.gz",
}
description = {
   summary    = "'pythonic.optparse' Command-line argument parsing similar to Python's optparse library",
   detailed   = [[]],
   license    =  "MIT/X11",
   homepage   = "http://lua-users.org/wiki/ModulePythonicOptparse",
   maintainer = "David Manura <http://lua-users.org/wiki/DavidManura>",
}
dependencies = {
}
build = {
  type = "none",
  install = {
     lua = {
        ["pythonic.optparse"] = "module/lmod/pythonic/optparse.lua",
     }
  }
}
