package.path = 'lmod/?.lua;'..package.path

local OptionParser = require "pythonic.optparse" . OptionParser
local opt = OptionParser{usage="%prog [options] [gzip-file...]",
                           version="foo 1.23", add_help_option=false}
opt.add_option{"-h", "--help", action="store_true", dest="help",
                 help="give this help"}
opt.add_option{
    "-f", "--force", dest="force", action="store_true",
    help="force overwrite of output file"}

local options, args = opt.parse_args()

if options.help or #args==0 then opt.print_help(); os.exit(1) end
if options.force then print 'f' end
for _, name in ipairs(args) do print(name) end

print 'done'
