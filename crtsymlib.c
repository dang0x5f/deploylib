/* #include <stdio.h> */
/* #include <stdlib.h> */
#include <errno.h>
#include <unistd.h>
#include "lua.h"
#include "lauxlib.h"

static int lnk(lua_State* L)
{
    /* printf("hello world"); */

    /* int */
    symlink(lua_tostring(L,-1), "crtlibsym");

    return(1);
}

static const struct luaL_Reg lib [] = {
     { "lnk", lnk }
    ,{ NULL  , NULL }
};

int 
luaopen_crtsymlib(lua_State* L)
{
    luaL_newlib(L,lib);
    return(1);
}
