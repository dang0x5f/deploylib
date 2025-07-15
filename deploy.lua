#!/usr/local/bin/lua54 

package.cpath = package.cpath..";/home/dang/lib/?.so"

local home_path  = os.getenv("HOME")
local lib_name   = "deploylib"
local lib_path   = home_path.."/lib/"..lib_name

-- local deploy = require(lib_name)
local lib_status, deploy = pcall(require,lib_name)

local src_path    = nil
local dot_path    = nil
local file        = nil

function usage()
    print("[ERR] requires 1 argument")
    print("usage:\n  deploy.lua MANIFEST")
end

function preview()
    file = io.open(arg[1],"r")
    if file then
        for line in io.lines(arg[1]) do

            c = string.sub(line,1,1)

            if c == "*" then
                src_path = line:sub(2)
            elseif c == "#" then
                goto continue
            else
                buildpaths(line)
                
                print("[PREVIEW] " .. dst_path .. " -> " .. dot_path)
            end

            ::continue::
        end
        file:close()
    end

    repeat
        io.write("Does this look correct? [y/n] ")
        input = io.read()
    until input ~= "" and 
          input == "y" or 
          input == "n"

    return input
end

function createlink(line)
    buildpaths(line)

    status, errno = deploy.make_link(dot_path,dst_path)
    if status == -1 then
        print("[ERR] " .. dst_path .. " : " .. errno)
    else
        print("[OK] " .. dst_path .. " -> " .. dot_path)
    end
end

function buildpaths(line)
    src, dst, ext = deploy.split_comma(line,line:len())
    if ext == "null" then
        dst_path = home_path .. dst
    else
        dst_path = home_path .. ext .. dst
    end
    dot_path = src_path .. src
end

function main()
    if #arg < 1 then
        usage()
        goto exit
    end

    print("[DEPENDENCY] "..lib_path)

    if not lib_status then
        print("[ERR] Dependency NOT loaded: "..lib_path)
        usage()
        goto exit
    end

    -- TODO: delete
    print("Dependency loaded")

--[[
    ans = preview()
    if ans == "n" then
        goto exit
    end

    file = io.open(arg[1],"r")

    if file then
        for line in io.lines(arg[1]) do

            c = string.sub(line,1,1)

            if c == "*" then
                src_path = line:sub(2)
            elseif src_path == nil then
                goto exit
            elseif c == "#" then
                goto continue
            else
                createlink(line)
            end

            ::continue::
        end
        file:close()
    end
--]]
    ::exit::
end

main()
