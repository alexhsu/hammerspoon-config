function moveFile(src, dist)
    local d = dist
    local fn = src:match(".+/([^/]*%.%w+)$")
    if d:sub(-1) == '/' then
        d = dist..fn
    else
        d = dist..'/'..fn
    end
    os.rename(src, d)
end

hazelRules = {
    downloads = {
        src = "/Users/alex/Downloads",
        rules = {
            ebook = {
                exts = {"pdf", "epub", "chm"},
                dist = "/Users/alex/eBooks",
                action = moveFile
            },
            music = {
                exts = {"flac", "ape", "alac", "wav"},
                dist = "/Users/alex/Music/我的收藏",
                action = moveFile
            },
            software = {
                exts = {"dmg"},
                dist = "/Users/alex/packages",
                action = moveFile
            }
        }
    }
}

function inArray(val,list)
    if not list then
        return false
    else
        for k, v in ipairs(list) do
            if v == val then
                return true
            end
        end
    end
end

for _, obj in pairs(hazelRules) do
    hs.pathwatcher.new(obj.src,function(files)
        for _, file in pairs(files) do
            local ext = file:match(".+%.(%w+)$")
            for _, rule in pairs(obj.rules) do
                if inArray(ext, rule.exts) then
                    rule.action(file, rule.dist)
                end
            end
        end
    end):start()
end
