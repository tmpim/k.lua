local function github(user, repo, branch, file, name)
  local url = "https://github.com/"..textutils.urlEncode(user).."/"..textutils.urlEncode(repo).."/raw/"..textutils.urlEncode(branch).."/"..textutils.urlEncode(file)
  shell.run("wget",url,name)
end

github("justync7","jua","master","jua.lua","jua.lua")
github("justync7","w.lua","master","w.lua","w.lua")
github("justync7","r.lua","master","r.lua","r.lua")
github("justync7","k.lua","master","k.lua","k.lua")
github("justync7","k.lua","master","example.lua","kexample.lua")
print("kstrapped! You now have the proper dependencies and kexample.lua in your current directory.")
