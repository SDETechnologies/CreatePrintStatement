local M = {}
function M.test()
    -- print("swag!")
    local line = vim.fn.line(".")
    -- print("line: ", line)
    -- Get the text of the current line
    local line_text = vim.fn.getline(line)
    -- print("line_text: ", line_text)
    -- Get the highlighted text
    local selection = vim.fn.getreg(vim.v.register)
    -- local selection = vim.fn.getreg("*")
    -- local selection = vim.fn.

    -- If there's no selection or it's empty, return
    if not selection or selection == "" then
        print("No variable selected")
        return
    end

    local printStatement = ""

    local fileType = vim.bo.filetype
    print('fileType: ', fileType)
    if fileType == "lua" or fileType == "python" then
        printStatement = "print('" .. selection .. ": ', " .. selection .. ")"
    elseif fileType == "go" then
        printStatement = 'fmt.Println("' .. selection .. ': ", ' .. selection ..')'
    elseif fileType == "javascript" then
        printStatement = 'console.log("' .. selection .. ': ", ' .. selection .. ')'
    elseif fileType == "sh" then
        printStatement = 'echo "' .. selection .. ': ", $' .. selection
    else
        print("invalid file type: ", fileType)
        return 
    end


    -- print("printStatement: ", printStatement)
    if printStatement ~= "" then
        vim.fn.append(line, printStatement)
        vim.api.nvim_command('normal! j')
        -- Enter visual line mode
        vim.api.nvim_command('normal! V')

        -- Invoke the = operator to format the line
        vim.api.nvim_command('normal! =')
    end
end

-- vim.keymap.set('v', '<leader>cp', function() test() end)
-- M.test()

return M
