hs.window.animationDuration = 0

function focusScreen(screen)
  local windows = hs.fnutils.filter(
    hs.window.orderedWindows(),
    hs.fnutils.partial(isInScreen, screen))
  local windowToFocus = #windows > 0 and windows[1] or hs.window.desktop()
  windowToFocus:focus()
  -- Move mouse to center of screen
  local center = hs.geometry.rectMidPoint(screen:fullFrame())
  hs.mouse.setAbsolutePosition(center)
end

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

WmPrefix = { "cmd", "ctrl" }

local mv = function(key, xr, yr, wr, hr)
  hs.hotkey.bind(
    WmPrefix, key,
    function() hs.window.focusedWindow():moveToUnit({ xr, yr, wr, hr }) end
  )
end

mv("n", 0, 0, 0.5, 1)
mv("o", 0.5, 0, 0.5, 1)
mv("e", 0, 0, 1, 0.5)
mv("i", 0, 0.5, 1, 0.5)
mv("t", 0, 0, 1, 1)

hs.hotkey.bind(WmPrefix, "l", moveToPreviousScreen)
hs.hotkey.bind(WmPrefix, "u", moveToNextScreen)

-- Shortcuts for launcher and internal usage.

function lf(app)
  hs.application.launchOrFocus(app)
end

function lfAndMove(app, x, y, w, h)
  local hasBeenRunning = hs.application.find(app) ~= nil
  lf(app)
  if (not hasBeenRunning) then
    hs.window.focusedWindow():moveToUnit({ x, y, w, h })
  end
end

function lfAndMaximize(app)
  lfAndMove(app, 0, 0, 1, 1)
end
