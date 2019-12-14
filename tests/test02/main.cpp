#include <string>

#include <lua.hpp>

#include "util.hpp"

#define STRINGIFY(x) #x
#define TOSTRING(x) STRINGIFY(x)
#define EXAMPLE_VERSION_STRING TOSTRING(EXAMPLE_VERSION)

using std::string;

extern "C" {

DLL_PUBLIC int luaopen_moduletest02(lua_State* L)
{
    int n = lua_gettop(L);

    int module = ++n; lua_newtable(L);
    
    string name = string() + "test02-" + EXAMPLE_VERSION_STRING;
    
    lua_pushstring(L, name.c_str());
    lua_setfield(L, module, "_NAME");

    lua_settop(L, module);
    return 1;
}

} // extern "C"
