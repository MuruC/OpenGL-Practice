local arch = "x64"
local currentWorkingDirectory = os.getcwd()
print("Current working directory = "..currentWorkingDirectory)

-- Solution
workspace("OpenGLPratices")
	location("build")
	configurations { "Debug", "Release" }
	systemversion("latest")
	architecture(arch)
	
	filter "configurations:Debug"
		defines { "DEBUG" }
		symbols "On"
		
	filter "configurations:Release"
		defines { "NDEBUG" }
		optimize "On"

-- Create pratice project
local function createPracticeProject(projectName)
	project(projectName)
		kind "ConsoleApp"
		cppdialect("C++20")
		language("C++")
		location("build/"..projectName)
		targetdir("build/bin/"..projectName.."/%{cfg.buildcfg}/"..arch)
		
		local projectFolder = "practices/"..projectName
		
		debugargs { currentWorkingDirectory.."/"..projectFolder.."/shaders/" }
		debugger("VisualStudioLocal")
		
		files
		{
			"coreUtil/**.*",
			"externalSource/**.*",
			projectFolder.."/**.*",
		}
		
		vpaths
		{
			["external"] = { "externalSource/*.h", "externalSource/*.cpp" },
			["external/imgui"] = { "externalSource/imgui/*.*" },
			["utils"] = { "coreUtil/**.*" },
			["shaders"]  = { "**.vs", "**.fs" },
			["source"]   = { projectFolder.."/**.h", projectFolder.."/**.cpp" },
		}
		
		includedirs
		{
			"coreUtil/",
			"externalSource/",
			"externalSource/imgui/",
			"library/include/",
		}
		
		libdirs
		{
			"library/lib/",
		}
		
		links
		{
			"glfw3",
		}
end

-- Practices
local allPracticeProjects = os.matchdirs("practices/*")
for _, v in ipairs(allPracticeProjects) do
	local projectName = path.getname(v)
	print("Make project : "..projectName)
	createPracticeProject(projectName)
end