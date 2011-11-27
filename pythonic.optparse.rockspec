package = "pythonic.optparse"
version = "$(_VERSION)"
source = {
   url = "http://math2.org/download/lua-pythonic-optparse-FIX.tar.gz",
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
        ["pythonic.optparse"] = "lmod/pythonic/optparse.lua",
     }
  }
}
