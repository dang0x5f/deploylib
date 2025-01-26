#!/usr/local/bin/lua54 

local crtsymlib = require "crtsymlib"

home = os.getenv("HOME")
pwd  = os.execute("pwd")

file = io.open(arg[1],"r")
if file then
    for line in io.lines(arg[1]) do
        print(line)
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

