# symlink make/remove lib

Created for dot file management Lua script. Lua does not have build-in symbolic link function.

- **mk_link**(*src_file* , *link_file*)
  - returns -> *status* , *errno*

- **rm_link**(*link_file*)
  - returns -> *status* , *errno*

- **split_comma**(*line*)
  - returns -> *field1* , *field2* , *field3*

## install

```sh
$ ./build.sh
```

## require

```lua
package.cpath = package.cpath..";/home/dang/lib/?.so"
local dotlink = pcall(require, lib_name)
```
