-- states
--  disable window animation
hs.window.animationDuration = 0

-- auto reload config files
-- function reloadConfig(files)
--     doReload = false
--     for _,file in pairs(files) do
--         if file:sub(-4) == ".lua" then
--             doReload = true
--         end
--     end
--     if doReload then
--         hs.reload()
--     end
--     hs.notify.new({title="Hammerspoon", informativeText="Config Reloaded"}):send()
-- end
-- local myWatcher = hs.pathwatcher.new(os.getenv("HOME") .. "/.hammerspoon/", reloadConfig):start()

if not module_list then
    module_list = {
        "app",
        "moom",
        "onekey",
        "system",
        "textexpander",
        "hazel",
    }
end

for i=1,#module_list do
    require(module_list[i])
end
