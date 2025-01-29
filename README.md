# deploy lib

created for dot file management lua script. lua does not have build-in symbolic link function.

- make_link(src_file , link_file)
  - returns: status , errno

- split_comma(line)
  - returns: field1 , field2 , field3

> ## install

```sh
$ ./build.sh
```

> ## require

```lua
local deploy = require "deploylib"
```
