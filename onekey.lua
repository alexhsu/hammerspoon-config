local hyper = {"alt"}
-- App shortcuts
local key2App = {
    d = "/Users/alex/Downloads",
    -- e = "/Users/alex/eBooks",
    n = "/Users/alex/Documents/notes",
}

local function openWithFinder(p)
    ast = [[
        tell application "Finder"
            open POSIX file %q
            activate
        end tell
    ]]
    as = string.format(ast, p)
    hs.osascript.applescript(as)
end

for key, path in pairs(key2App) do
    hs.hotkey.bind(hyper, key, function()
        openWithFinder(path)
    end)
end
