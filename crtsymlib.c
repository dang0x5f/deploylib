#include <stdio.h>
#include <stdlib.h>
#include "lua.h"
#include "lauxlib.h"

int link(lua_State* L)
{
    printf("hello world");

    return(1);
}

static const struct luaL_Reg lib [] = {
     { "link", link }
    ,{ NULL  , NULL }
};

int 
luaopen_crtsymlib(lua_State* L)
{
    luaL_newlib(L,lib);
    return(1);
}
