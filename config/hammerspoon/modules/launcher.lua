
-- Hotkey kitty.
-- hs.hotkey.bind({"cmd"}, "escape", app_man:toggle("kitty"))

-- https://github.com/Hammerspoon/hammerspoon/issues/882
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- https://github.com/Hammerspoon/hammerspoon/issues/848
-- https://github.com/cmsj/hammerspoon-config/blob/master/init.lua

function lf(app)
  hs.application.launchOrFocus(app)
end

function lfAndMove(app, x, y, w, h)
  local hasBeenRunning = hs.application.find(app) ~= nil
  lf(app)
  if (not hasBeenRunning) then
    hs.window.focusedWindow():moveToUnit({x, y, w, h})
  end
end

function lfAndMaximize(app)
  lfAndMove(app, 0, 0, 1, 1)
end

PreviousAppActivated = nil

LastAppWatcher = hs.application.watcher.new(
  function(appName, eventType, app)
    if (PreviousAppActivated ~= appName) then
      PreviousAppActivated = app:path()
    end
  end
):start()

AppLauncherApps = {
  ["n"] = {
    hotkey = "n",
    text = "Vivaldi",
    action = function() lfAndMaximize("Vivaldi") end,
  },
  ["e"] = {
    hotkey = "e",
    text = "Visual Studio Code",
    action = function() lfAndMaximize("Visual Studio Code") end,
  },
  ["space"] = {
    hotkey = "space",
    text = "kitty",
    action = function() lfAndMaximize("kitty") end,
  },
  ["m"] = {
    hotkey = "m",
    text = "Slack",
    action = function() lfAndMaximize("Slack") end,
  },
  ["i"] = {
    hotkey = "i",
    text = "IntelliJ",
    action = function() lfAndMaximize("IntelliJ IDEA Community") end,
  },
  ["p"] = {
    hotkey = "p",
    text = "Postman",
    action = function() lfAndMaximize("Postman") end,
  },
  ["0"] = {
    hotkey = "0",
    text = "Hammerspoon Console",
    action = hs.toggleConsole,
  },
  ["9"] = {
    hotkey = "9",
    text = "",
    action = function()
      AppLauncherChooser:query("")
      AppLauncherChooser:show()
    end,
  },
  ["f20"] = {
    hotkey = "f20",
    text = "",
    action = function() lf(PreviousAppActivated) end
  },
  ["-"] = {
    hotkey = "-",
    text = "",
    action = function() hs.keycodes.setLayout("Colemak") end
  },
  ["="] = {
    hotkey = "=",
    text = "",
    action = function() hs.keycodes.setLayout("Rulemak") end
  },
}

function rgb256(r, g, b, alpha)
  local alpha = alpha or 1.0
  return {red = r / 256, green = g / 256, blue = b / 256, opacity = alpha}
end

SolarizedRed = rgb256(208, 27, 36)
SolarizedTeal = rgb256(37, 145, 133)
MainScreenFrame = hs.screen.mainScreen():frame()
ModeIndicatorSize = 200
LauncherModeIndicator = hs.drawing.rectangle{
  x = MainScreenFrame.x + (MainScreenFrame.w - ModeIndicatorSize) / 2,
  y = MainScreenFrame.y + (MainScreenFrame.h - ModeIndicatorSize) / 2,
  w = ModeIndicatorSize,
  h = ModeIndicatorSize
}:setStrokeWidth(0):setFillColor(SolarizedTeal):setStrokeColor(SolarizedTeal)

AppLauncherChooser = hs.chooser.new(
  function(choice)
    print("Choice =", choice["text"])
    local action = AppLauncherApps[choice["text"]]
    if (action ~= nil) then action() end
  end
)
AppLauncherChooser:choices(choices)
AppLauncherChooser:queryChangedCallback(
  function (newQuery)
    if (#newQuery > 0) then
      AppLauncherChooser:query(newQuery)
      AppLauncherChooser:select()
    end
  end
)

IsAppLauncherMode = false
AppLauncherMode = hs.hotkey.modal.new({}, "f20", nil)

AppLauncherModeKeyEvent = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown},
  function (event)
    if (not IsAppLauncherMode) then return end

    AppLauncherMode:exit()
    local keyPressed = hs.keycodes.map[event:getKeyCode()]
    local action = AppLauncherApps[keyPressed]
    if (action ~= nil) then pcall(action.action) end
    return true
  end
):start()

AppLauncherMode.entered = function ()
  IsAppLauncherMode = true
  -- AppLauncherModeKeyEvent:start()
  LauncherModeIndicator:show()
end
AppLauncherMode.exited = function ()
  IsAppLauncherMode = false
  -- AppLauncherModeKeyEvent:stop()
  LauncherModeIndicator:hide()
end

-- hs.loadSpoon("Seal")
-- spoon.Seal:loadPlugins({"pasteboard"})
-- spoon.Seal:bindHotkeys({show={{"cmd", "shift"}, "\\"}})
-- spoon.Seal.plugins.useractions.actions = {
--     ["Red Hat Bugzilla"] = { url = "https://bugzilla.redhat.com/show_bug.cgi?id=${query}", icon="favicon", keyword="bz" },
--     ["Launchpad Bugs"] = { url = "https://launchpad.net/bugs/${query}", icon="favicon", keyword="lp" },
-- }
-- spoon.Seal:start()
