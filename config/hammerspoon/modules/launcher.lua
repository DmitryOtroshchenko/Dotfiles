
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
  if (hasBeenRunning) then
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
  ["n"] = function() lfAndMaximize("Vivaldi") end,
  ["e"] = function() lfAndMaximize("Visual Studio Code") end,
  ["space"] = function() lfAndMaximize("kitty") end,
  ["m"] = function() lfAndMaximize("Slack") end,
  ["f20"] = function() lf(PreviousAppActivated) end,
  ["0"] = hs.toggleConsole
}

IsAppLauncherMode = false
AppLauncherMode = hs.hotkey.modal.new({}, "f20", nil)
AppLauncherMode.entered = function () IsAppLauncherMode = true end
AppLauncherMode.exited = function () IsAppLauncherMode = false end

AppLauncherModeKeyEvent = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown},
  function (event)
    if (not IsAppLauncherMode) then return end

    local keyPressed = hs.keycodes.map[event:getKeyCode()]
    local action = AppLauncherApps[keyPressed]
    if (action ~= nil) then action() end
    AppLauncherMode:exit()
    return true
  end
):start()

-- Seal
hs.loadSpoon("Seal")
-- spoon.Seal:loadPlugins({"apps"})
-- spoon.Seal:bindHotkeys({show={{"cmd"}, "\\"}})
-- spoon.Seal.plugins.useractions.actions = {
--     ["Red Hat Bugzilla"] = { url = "https://bugzilla.redhat.com/show_bug.cgi?id=${query}", icon="favicon", keyword="bz" },
--     ["Launchpad Bugs"] = { url = "https://launchpad.net/bugs/${query}", icon="favicon", keyword="lp" },
-- }
spoon.Seal:start()
