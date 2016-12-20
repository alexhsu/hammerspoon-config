hyper = {"ctrl", "alt"}
function resize_win(direction)
    local win = hs.window.focusedWindow()
    if win then
        local f = win:frame()
        local screen = win:screen()
        local max = screen:frame()
        local stepw = max.w/30
        local steph = max.h/30
        if direction == "halfright" then f.x = max.x + max.w / 2 f.y = max.y f.w = max.w/2 f.h = max.h end
        if direction == "halfleft" then f.x = max.x f.y = max.y f.w = max.w/2 f.h = max.h end
        if direction == "center" then f.x = max.x + (max.w-f.w)/2 f.y = max.y + (max.h-f.h)/2 end
        if direction == "fullscreen" then f = max end
        if direction == "shrink" then f.w = f.w-(stepw*2) f.h = f.h-(steph*2) end
        if direction == "expand" then f.w = f.w+(stepw*2) f.h = f.h+(steph*2) end
        win:setFrame(f)
    else
        hs.alert.show("No focused window!")
    end
end

hs.hotkey.bind(hyper, "a", function()
    resize_win('halfleft')
end)

hs.hotkey.bind(hyper, "f", function()
    resize_win('fullscreen')
end)

hs.hotkey.bind(hyper, "d", function()
    resize_win('halfright')
end)

hs.hotkey.bind(hyper, "s", function()
    resize_win('center')
end)

hs.hotkey.bind(hyper, "=", function()
    resize_win('expand')
end)

hs.hotkey.bind(hyper, "-", function()
    resize_win('shrink')
end)

-- hyper + w move the current window to the next monitor
hs.hotkey.bind(hyper, 'w', function()
    local w = hs.window.focusedWindow()
    if not w then
        return
    end
    local s = w:screen():next()
    if s then
        w:moveToScreen(s)
    end
end)

hs.hotkey.bind(hyper, 'h', function()
    hs.hints.windowHints()
end)
