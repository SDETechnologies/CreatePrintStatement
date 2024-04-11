local cps = require("create_print_statement.create_print_statement")
local print = require("create_print_statement.test")
local printFunction = require("create_print_statement.printFunction")

local M = {}

M.create_print_statement = cps.create_print_statement
M.print = print.test
M.printFunction = printFunction.printFunction

return M
