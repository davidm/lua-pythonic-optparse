package.path = './lmod/?.lua;'..package.path

arg = { '-d', '-l', 'DEBUG' , 'localhost', '60000', [0] = 'testdeamon'}  -- set global arg

local OP = require 'pythonic.optparse'

local opt = OP.OptionParser{usage="%prog [options] address port \n", version='0.0', add_help_option=false}
opt.add_option{'-h', '--help',          help = 'show this help message and exit', action='store_true' }
opt.add_option{'-d', '--daemon',        help = 'Run as daemon', action='store_true' }
opt.add_option{'-l', '--log-level',     choices = {'DEBUG', 'INFO', 'WARN', 'ERROR', 'FATAL'},   default = 'INFO', metavar='LEVEL' }
opt.add_option{      '--logfile',       help = 'Name of logfile', metavar='FILE' }
opt.add_option{'-c', '--config',        help = 'Name of configfile',  default = '/etc/opt/test', metavar='FILE' }
opt.add_option{'-s', '--check-interval',help = 'Seconds between checking config',  type='int',  dest='ci', default = 15 , metavar='SEC'}
opt.add_option{      '--check-float',   help = 'Check floating raft',  type='float', metavar='liters'}
--opt.print_help()

local options, args = opt.parse_args() -- use global arg

assert(options.log_level=='DEBUG')
assert(options.config=='/etc/opt/test') -- default value
assert(options.daemon==true)            -- -d
assert(options.logfile == nil)
assert(options.ci == 15)           -- dest, default
assert(options.check_float == nil)
assert(#args == 2)
assert(args[1] == 'localhost')
assert(args[2] == '60000')

-- Next case, now passing arg as paramenter
options, args = opt.parse_args{ 'localhost',  '60001', '-l', 'FATAL', '-s', '60' , 
   '--config', '/home/test/config', '--logfile', '/var/log/test', '--check-float=3.14' }
assert(options.log_level=='FATAL')
assert(options.config=='/home/test/config') -- config
assert(options.logfile == '/var/log/test')
assert(options.daemon==nil) 
assert(options.ci == 60)            -- dest, default
assert(options.check_float == 3.14) -- float and --name=var syntax
assert(#args == 2)
assert(args[1] == 'localhost')
assert(args[2] == '60001')


-- harness for error cases: 
opt.fail=error
local function check_errorcase(args, errtext)
  local res, err = pcall(opt.parse_args, args)
  assert(res==false, 'Illegal parameter not caught')
  if errtext then
    assert(err:find(errtext, nil, true), 'Unexpected error text')
  else
    print("'"..err.."'")
  end
end

-- test error cases: 
check_errorcase({  '--bogous', 'foo'},  'invalid option --bogous')
check_errorcase({  '-l' },              'option requires an argument -l')
check_errorcase({  '-l', 'DEADLY' },    'illegal value for option -l: DEADLY')
check_errorcase({  '-s', '6f' },        'option -s: 6f not a int')
check_errorcase({  '-s', '3.14' },      'option -s: number 3.14 not an int')

print 'DONE'
