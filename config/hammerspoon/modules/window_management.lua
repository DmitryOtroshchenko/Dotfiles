
hs.window.animationDuration = 0

function moveToPreviousScreen()
  local fw = hs.window.focusedWindow()
  fw:moveToScreen(fw:screen():previous())
end

function moveToNextScreen()
  local fw = hs.window.focusedWindow()
  fw:moveToScreen(fw:screen():next())
end

function maximizeWindow()
  local fw = hs.window.focusedWindow()
  fw:moveToScreen(fw:screen():previous())
end

WmPrefix = {"cmd", "ctrl"}

local mv = function(key, xr, yr, wr, hr)
  hs.hotkey.bind(
    WmPrefix, key,
    function() hs.window.focusedWindow():moveToUnit({xr, yr, wr, hr}) end
  )
end

mv("n", 0, 0, 0.5, 1)
mv("o", 0.5, 0, 0.5, 1)
mv("e", 0, 0, 1, 0.5)
mv("i", 0, 0.5, 1, 0.5)
mv("t", 0, 0, 1, 1)

hs.hotkey.bind(WmPrefix, "l", moveToPreviousScreen)
hs.hotkey.bind(WmPrefix, "u", moveToNextScreen)
