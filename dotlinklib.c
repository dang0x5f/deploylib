#include <errno.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include "lua.h"
#include "lauxlib.h"

static int 
mk_link(lua_State* L)
{
    if(symlink(lua_tostring(L,-2), lua_tostring(L,-1)) == -1){
        lua_pushinteger(L,-1);
        lua_pushstring(L,strerror(errno));
        return(2);
    }
    
    lua_pushinteger(L,0);

    return(1);
}

static int 
rm_link(lua_State* L)
{
    if(unlink(lua_tostring(L,-1)) == -1){
        lua_pushinteger(L,-1);
        lua_pushstring(L,strerror(errno));
        return(2);
    }
    
    lua_pushinteger(L,0);

    return(1);
}

static int 
split_comma(lua_State* L)
{
    int x, i;
    int comma     = 1;
    int len       = lua_tointeger(L,-1) + 1;    
    char* buffer  = malloc(len * sizeof(char)); 
    char* field   = malloc(len * sizeof(char)); 

    sprintf(buffer,"%s", lua_tostring(L,-2));

    i = 0;
    char* iter = buffer;
    while(*iter != '\0'){
        if(*iter == ','){
            *(field+i) = '\0';
            lua_pushstring(L,field);
            i = 0;
        } else {
            *(field+i) = *iter;
            i++;
        }

        iter++;
    }
    *(field+i) = '\0';
    lua_pushstring(L,field);
    
    free(field);
    free(buffer);
    
    return(3);
}

static const struct luaL_Reg lib [] = {
     { "mk_link"     , mk_link     }
    ,{ "rm_link"     , rm_link     }
    ,{ "split_comma" , split_comma }
    ,{ NULL          , NULL        }
};

int 
luaopen_dotlinklib(lua_State* L)
{
    luaL_newlib(L,lib);
    return(1);
}
