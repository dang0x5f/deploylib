#!/usr/local/bin/lua54 

local crtsymlib = require "crtsymlib"

home = os.getenv("HOME")

-- repeat
--     print(" * Symbolic Link -> " .. 
--           " anoteuhsaou")
--     io.write("Does this look correct? [y/n] ")
--     input = io.read()
-- until input ~= "" and 
--       input == "y" or 
--       input == "n"

-- print(input)

file = io.open(arg[1],"r")
if file then
    for line in io.lines(arg[1]) do
        c = string.sub(line,1,1)

        if c == "*" then
            print(line:sub(2))
        elseif c == "#" then
            print("comment")
        else
            print("gtg")
        end


        -- src, dst, path = crtsymlib.split_on_comma(line,string.len(line));

        -- print(src)
        -- if path == "null" then
        --     print(home .. dst)
        -- else
        --     print(home .. path .. dst)
        -- end
    end
    file:close()
end

-- status, errno = crtsymlib.makelink("./crtsymlib.c","symlink")

-- if status == -1 then
--     print(status)
--     print(errno)
-- else
--     print(status)
--     print(errno)
-- end

-- status, errno = crtsymlib.makelink("./crtsymlib.c","csl")

-- if status == -1 then
--     print(status)
--     print(errno)
-- else
--     print(status)
--     print(errno)
-- end

