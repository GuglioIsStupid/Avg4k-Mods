-- Bunch of snippets thats available for use in avg4k

function readFile(file)
    -- literally just dofile
    -- make the text file start with return [[ and end with ]]
    return dofile(file)
end

--[[
E.g.
text.json:
return [[
{
    "text": "Hello World!"
}
--]]--]]
--[[
json = dofile(formCompletePath("json.lua"))

jsonfile = json.decode(readFile(formCompletePath("text.json")))
consolePrint(jsonfile.text)
--]]