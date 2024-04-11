function isFunction(lineText)
    print('isFunction(linetext=', linetext, ')')
    local word=lineText:match("%((.-)%)")
    print("word: ", word)
    -- if string.find(lineText, "("), 1, true) ~= nil and string.find(lineText,")", 1, true) ~= nil then
    --     return true
    -- end
    if word == nil then
        return false
    end
    return true
end

function getFunctionParams(lineText)
    finalParamString = ""
    paramString = ""
    local items = {}
    local word=lineText:match("%((.-)%)")
    print("word: ", word)
    if word == nil then
        error("no function detected in getFunctionParams(lineText=",lineText,")")
        return
    end
    for item in word:gmatch("[^,%s]+") do
        print('item: ', item)
        -- table.insert(items, item)
        paramString = paramString..item..","
    end
    -- return items
    for substring in paramString:gmatch("([^,%s]+)") do
        print('substring: ', substring)
        finalParamString = finalParamString.."'"..substring.."=',"..substring..","
    end
    return finalParamString:sub(1,-2)
end

function getPrintStatement(text, fileType)
    local printStatement = ""
    if fileType == "lua" or fileType == "python" then
        printStatement = "print(" .. text .. ")"
    elseif fileType == "go" then
        printStatement = 'fmt.Println(' .. selection ..')'
    elseif fileType == "javascript" then
        printStatement = 'console.log(' .. text .. ')'
    elseif fileType == "sh" then
        printStatement = 'echo "' .. text .. ''
    else
        print("invalid file type: ", fileType)
        return 
    end
    return printStatement
end

local M = {}
function M.test()
    -- print("swag!")
    local line = vim.fn.line(".")
    -- print("line: ", line)
    -- Get the text of the current line
    local line_text = vim.fn.getline(line)
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
        printStatement = 'echo "' .. selection .. ': $' .. selection .. '"'
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

function M.printFunction()
    local line = vim.fn.line(".")
    local lineText = vim.fn.getline(line)
    print('lineText: ', lineText)
    local isFunction = isFunction(lineText)
    -- print('isFunction: ', isFunction)
    if isFunction == false then
        -- print("No function found on line")
        error("No function found on line")
        return
    end
    local functionName=lineText:match("%s(%w+)%(")
    print('functionName: ', functionName)
    -- local functionParams=lineText:match("%((.-)%)")
    local functionParams = getFunctionParams(lineText)
    print('functionParams: ', functionParams)
    local fileType = vim.bo.filetype
    printStatement = getPrintStatement("'"..functionName.."'("..functionParams..")", fileType)
    print('printStatement: ', printStatement)
    -- -- print('fileType: ', fileType)
    -- for k in ipairs(functionParams) do
    --     print(param.."")
    -- end
    -- print('table: ', table.concat(functionParams, ','))
    -- print('pairs: ', ipairs(functionParams))
    -- for substring in functionParams:gmatch("([^,%s]+)") do
    --     print('substring: ', substring)
    -- end

-- M.printFunction()

end

return M
