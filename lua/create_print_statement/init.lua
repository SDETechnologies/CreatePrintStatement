local cps = require("create_print_statement.create_print_statement")
local print = require("create_print_statement.test")

local M = {}

M.create_print_statement = cps.create_print_statement
M.print = print.test
M.printFunction = print.printFunction

return M
