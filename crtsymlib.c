#include <errno.h>
#include <string.h>
#include <unistd.h>
#include "lua.h"
#include "lauxlib.h"

static int makelink(lua_State* L)
{
    if(symlink(lua_tostring(L,-2), lua_tostring(L,-1)) == -1){
        lua_pushinteger(L,-1);
        lua_pushstring(L,strerror(errno));
        return(2);
    }
    
    lua_pushinteger(L,0);

    return(1);
}

static const struct luaL_Reg lib [] = {
     { "makelink", makelink }
    ,{ NULL      , NULL     }
};

int 
luaopen_crtsymlib(lua_State* L)
{
    luaL_newlib(L,lib);
    return(1);
}
