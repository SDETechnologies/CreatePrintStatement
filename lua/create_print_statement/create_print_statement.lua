local M = {}

function M.create_print_statement()

    local test = "hi"

    print("create_print_statement")
end

-- vim.cmd([[command! CreatePrintStatement lua require('eliot.create_print_statement').create_print_statement()]])


return M


