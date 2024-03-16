-- stylua: ignore start 
--

-- Clean directory
newaction {
   trigger     = "clean",
   description = "clean the software",
   execute     = function ()
      print("clean the build...")
      os.rmdir("./bin")
      os.rmdir("./obj")
        os.remove("./Sandbox.make")
        os.remove("./Gengine.make")
        os.remove("Makefile")
      print("done.")
   end
}

-- Run Program
newaction {
    trigger = "run",
    description = "run the application",
    execute = function ()
        os.execute("./bin/Debug/Sandbox")
    end
}

workspace "HelloWorld"
    configurations {"Debug", "Release", "Dist"} -- Executable configurations

project "Gengine"
    kind "StaticLib"
    language "C"
    files{
       "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.c",
    }
    filter "system:macosx"
        defines {
            "GE_PLATFORM_MACOS"
        }
    links {"$(VULKAN_SDK)/lib/libvulkan.1.dylib"}
    includedirs { "$(VULKAN_SDK)/include"}



project "Sandbox"
    kind "ConsoleApp"
    language "C"
    files{
        "%{prj.name}/src/**.h",
        "%{prj.name}/src/**.c",
    }
    filter "system:macosx"
    defines {
        "GE_PLATFORM_MACOS"
    }
    includedirs {
        "Gengine/src"
    }

    links {"Gengine"}
    filter "Debug"
        defines { "DEBUG" }
        symbols  "ON" 

    filter "Release"
        defines { "NDEBUG" }
        optimize "ON"
-- stylua: ignore end
