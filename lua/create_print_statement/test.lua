local function test()

    print("swag!")
    local line = vim.fn.line(".")
    print("line: ", line)
    -- Get the text of the current line
    local line_text = vim.fn.getline(line)
    print("line_text: ", line_text)
    -- Get the highlighted text
    local selection = vim.fn.getreg(vim.v.register)
    -- local selection = vim.fn.getreg("@")

    -- If there's no selection or it's empty, return
    if not selection or selection == "" then
        print("No variable selected")
        return
    end
    print("selection: ", selection)

    local printStatement = "print('" .. selection .. ":', " .. selection .. ")"
    -- vim.fn.append(line, printStatement)
    print("printStatement: ", printStatement)
end

-- vim.keymap.set('v', '<leader>cp', function() test() end)
-- test()
