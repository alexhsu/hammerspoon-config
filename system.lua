hyper = {"ctrl", "cmd"}
hs.hotkey.bind(hyper, "l", function()
    hs.caffeinate.lockScreen()
end)


local mouseCircle = nil
local mouseCircleTimer = nil

function mouseHighlight()
    -- Delete an existing highlight if it exists
    if mouseCircle then
        mouseCircle:delete()
        if mouseCircleTimer then
            mouseCircleTimer:stop()
        end
    end
    -- Get the current co-ordinates of the mouse pointer
    mousepoint = hs.mouse.getAbsolutePosition()
    -- Prepare a big red circle around the mouse pointer
    rs = {
            s = {
                r = 20,
                color = {["red"]=0,["blue"]=1,["green"]=0,["alpha"]=0.7}
            },
            m = {
                r = 30,
                color = {["red"]=0,["blue"]=0,["green"]=1,["alpha"]=0.7}
            },
            l = {
                r = 40,
                color = {["red"]=1,["blue"]=0,["green"]=0,["alpha"]=0.7}
            },
        }
    circles = {}
    for k,r in pairs(rs) do
        mouseCircle = hs.drawing.circle(hs.geometry.rect(mousepoint.x-r.r, mousepoint.y-r.r, r.r*2, r.r*2))
        mouseCircle:setStrokeColor(r.color)
        mouseCircle:setFill(false)
        mouseCircle:setStrokeWidth(10)
        mouseCircle:show()
        circles[k] = mouseCircle
    end
    for k, c in pairs(circles) do
        hs.timer.doAfter(2, function() c:delete() end)
    end
    circles = nil
    --
    -- Set a timer to delete the circle after 3 seconds
end
hs.hotkey.bind(hyper, "m", mouseHighlight)

darkblue = {red=24/255,blue=195/255,green=145/255,alpha=0.8}
function show_time()
    if not time_draw then
        local mainScreen = hs.screen.mainScreen()
        local mainRes = mainScreen:fullFrame()
        local time_str = hs.styledtext.new(os.date("%H:%M:%S"),{font={name="Impact",size=200},color=darkblue,paragraphStyle={alignment="center"}})
        local timeframe = hs.geometry.rect(mainRes.x + (mainRes.w-760)/2, mainRes.y + (mainRes.h-260)/2,760,260)
        time_draw = hs.drawing.text(timeframe,time_str)
        time_draw:setLevel(hs.drawing.windowLevels.overlay)
        time_draw:show()
        ttimer = hs.timer.doAfter(2, function() time_draw:delete() time_draw=nil end)
    else
        time_draw:delete()
        time_draw=nil
    end
end
hs.hotkey.bind(hyper, "t", show_time)

hs.hotkey.bind(hyper, "R", function()
    hs.reload()
end)

hs.hotkey.bind(hyper, '`', function()
    local screen = hs.mouse.getCurrentScreen()
    local nextScreen = screen:next()
    local rect = nextScreen:fullFrame()
    local center = hs.geometry.rectMidPoint(rect)
    hs.mouse.setAbsolutePosition(center)
    mouseHighlight()
end)

function initChooser()
    local choices = {
        {
            ["text"] = "First Choice",
            ["subText"] = "This is the subtext of the first choice",
            ["uuid"] = "0001"
        },
        { ["text"] = "Second Option",
        ["subText"] = "I wonder what I should type here?",
        ["uuid"] = "Bbbb"
    },
    { ["text"] = "Third Possibility",
    ["subText"] = "What a lot of choosing there is going on here!",
    ["uuid"] = "III3"
},
}
c = hs.chooser.new(function(chosen)
    hs.alert.show(chosen.text)
end)
c:choices(choices)
c:bgDark(true)
c:show()
end

hs.hotkey.bind(hyper, 'c', function()
    initChooser()
end)
