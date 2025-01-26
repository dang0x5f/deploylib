#!/usr/local/bin/lua54 

local crtsymlib = require "crtsymlib"

home = os.getenv("HOME")
pwd  = os.execute("pwd")

file = io.open(arg[1],"r")
if file then
    for line in io.lines(arg[1]) do
        -- print(line)
        -- print(string.len(line))
        src, dst, path = crtsymlib.split_on_comma(line,string.len(line));
        print(src)
        print(dst)
        print(path)
        -- print(dst)
        -- print(path)
        -- crtsymlib.split_on_comma(line);
    end
end
file:close()


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

