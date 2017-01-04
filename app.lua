k = hs.hotkey.modal.new('ctrl', 'g')
pressedk = function()
  k:enter()
  end

-- Leave Hyper Mode when F18 (Hyper/Capslock) is pressed,
--   send ESCAPE if no other keys are pressed.
releasedk = function()
    k:exit()
end

-- App shortcuts
local key2App = {
    a = 'Atom',
    c = 'Google Chrome',
    f = 'Firefox',
    i = 'iTunes',
    k = 'Keyboard Maestro',
    m = 'Spark',
    o = 'Opera',
    p = 'PyCharm',
    q = 'QQ',
    s = 'Safari',
    t = 'iTerm',
    w = 'WeChat',
    x = 'Xcode',
}

for key, app in pairs(key2App) do
    k:bind({}, key, nil, function()
        releasedk()
        hs.application.launchOrFocus(app)
    end)
end
