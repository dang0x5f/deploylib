#!/usr/local/bin/lua54 

package.cpath = package.cpath..";/home/dang/lib/?.so"

-- load shared lib
local home_path  = os.getenv("HOME")
local lib_name   = "deploylib"
local lib_path   = home_path.."/lib/"..lib_name
local lib_status, deploy = pcall(require,lib_name)

-- ansi color
local ESC = "\27"
local RST = "\27[0m"
local R   = "\27[31m"
local G   = "\27[32m"
local B   = "\27[34m"
local C   = "\27[36m"
local M   = "\27[35m"
local Y   = "\27[33m"

-- info tags
local tag_err  = "["..R.."ERR"..RST.."] "
local tag_ok   = "["..G.."OK"..RST.."] "
local tag_so   = "["..Y.."SHARED OBJECT"..RST.."] "
local tag_prev = "["..Y.."PREVIEW"..RST.."] "
local tag_info = "["..Y.."INFO"..RST.."] "

local DEFAULT_MANIFEST = "MANIFEST.def"
local file_name = nil

local file     = nil
local src_path = nil
local dot_path = nil

function usage()
    print("usage:\n  deploy.lua MANIFEST")
    -- TODO: print MANIFEST format
end

function preview()
    file = io.open(file_name,"r")
    if file then
        for line in io.lines(file_name) do

            c = string.sub(line,1,1)

            if c == "*" then
                src_path = line:sub(2)
            elseif c == "#" then
                goto continue
            else
                buildpaths(line)
                
                print(tag_prev..dst_path.." -> "..dot_path)
            end

            ::continue::
        end
        file:close()
    else
        print(tag_err.."Failed to open file: "..file_name)
        return "n"
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

    status, errno = deploy.mk_link(dot_path,dst_path)
    -- status, errno = deploy.rm_link(dst_path)
    if status == -1 then
        print(tag_err..dst_path.." : "..errno)
    else
        print(tag_ok..dst_path.." -> "..dot_path)
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
        print(tag_info.."No file parameter.\n"..
              tag_info.."Reverting to default: "..DEFAULT_MANIFEST)
        file_name = DEFAULT_MANIFEST
    else
        file_name = arg[1]
    end

    print(tag_so..lib_path..".so")

    if not lib_status then
        print(tag_err.."Dependency NOT loaded: "..lib_path)
        usage()
        goto exit
    end

    -- TODO: delete
    print(tag_ok.."Shared Object Loaded.")

    ans = preview()
    if ans == "n" then
        goto exit
    end

    file = io.open(file_name,"r")

    if file then
        for line in io.lines(file_name) do

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
    ::exit::
end

main()

-- TODO:
-- makefile
-- unlink/rm in c lib
-- default MANIFEST, if not passed as arg, in same dir as lua script
-- rename: conflink / dotlink
--
-- TODO: other
-- delete ruby
-- usage for exec.sh
-- grabkeyboard for mixer dev win
-- rewrite loose-end scripts in lua, OR exec.sh in lua
-- better documentation for all of MY sys programs and their dependencies
-- touchpad  -> bsd_osd
-- stopwatch -> bsd_osd
-- prev of github repos window
