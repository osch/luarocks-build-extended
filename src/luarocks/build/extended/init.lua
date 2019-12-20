local builtin    =    require("luarocks.build.extended.builtin")
local tryrequire =    require("luarocks.build.extended.util").tryrequire
local cfg        = tryrequire("luarocks.core.cfg", "luarocks.cfg")

local extended = {}

local function chaintables(first, second)
    setmetatable(first, {
        __index = second
    })
    return first
end

local function cppbuildmethods(moduleVars)
    local vars = chaintables({}, moduleVars)
    if not vars.LIBFLAG_EXTRAS then vars.LIBFLAG_EXTRAS = {} end
    if vars.CXXFLAG_EXTRAS then
        vars.CFLAG_EXTRAS = vars.CXXFLAG_EXTRAS
    end
    if vars.CXX then
        vars.CC = vars.CXX
    end
    if vars.CXXFLAGS then
        vars.CFLAGS = vars.CXXFLAGS
    end
    if cfg.is_platform("mingw32") then
        vars.LIBFLAG_EXTRAS[#vars.LIBFLAG_EXTRAS + 1] = "-lstdc++"
    elseif cfg.is_platform("win32") then
        vars.CFLAGS = "/EHsc "..vars.CFLAGS
    else
        vars.LIBFLAG_EXTRAS[#vars.LIBFLAG_EXTRAS + 1] = "-lstdc++"
    end
    return builtin.buildmethods(vars)
end

function extended.run(rockspec)
    local build     = rockspec.build
    local buildVars = chaintables(build.variables or {}, rockspec.variables)
    if not buildVars.BUILD_DATE then
        buildVars.BUILD_DATE = os.date("%Y-%m-%dT%H:%M:%S")
    end

    local function callback(moduleName, module)
    
        local moduleVars = chaintables(module.variables or {}, buildVars)
        
        local hascpp = false
    
        local compile_obj_c, 
              compile_lib_c, 
              compile_static_lib_c = builtin.buildmethods(moduleVars)

        local compile_obj_cpp, 
              compile_lib_cpp, 
              compile_static_lib_cpp = nil, nil, nil
              
        local function compile_object(object, source, defines, incdirs, ...)
            local ext = string.lower(source:match("%.([^.]+)$"))
            local cpp = (ext == "cpp" or ext == "cxx" or ext == "cc")
            if cpp then
                if not hascpp then
                    compile_obj_cpp, 
                    compile_lib_cpp, 
                    compile_static_lib_cpp = cppbuildmethods(moduleVars)
                    hascpp = true
                end
            end
            if cpp then
                return compile_obj_cpp(object, source, defines, incdirs, ...)
            else
                return compile_obj_c(object, source, defines, incdirs, ...)
            end
        end
        local function compile_library(...)
            if hascpp then
                return compile_lib_cpp(...)
            else
                return compile_lib_c(...)
            end
        end
        local function compile_static_library(...)
            return compile_static_lib_c(...)
        end

        return compile_object, compile_library, compile_static_library        
    end
    
    return builtin.run2(rockspec, callback)
end
 
return extended
