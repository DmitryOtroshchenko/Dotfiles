-- https://github.com/Hammerspoon/hammerspoon/issues/882
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- https://github.com/Hammerspoon/hammerspoon/issues/848
-- https://github.com/cmsj/hammerspoon-config/blob/master/init.lua

function rgb256(r, g, b, alpha)
  local alpha = alpha or 1.0
  return {red = r / 256, green = g / 256, blue = b / 256, opacity = alpha}
end

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

Launcher = {}
Launcher.__index = Launcher

function Launcher:create(mods, key, apps)
  local obj = {}
  setmetatable(obj, Launcher)
  obj.mods = mods
  obj.key = key
  obj.apps = apps
  -- Setup state remembering app switches.
  obj.previousActiveApp = nil
  obj.activeAppWatcher = hs.application.watcher.new(
    function(appName, eventType, app)
      if (Launcher.previousActiveApp ~= appName) then
        Launcher.previousActiveApp = app:path()
      end
    end
  )
  obj.previousActiveAppHotkey = nil
  -- Set up app launcher hotkey mode.
  obj.isLauncherMode = false
  -- Process individual keystrokes in launcher mode.
  obj.launcherModeKeyListener = hs.eventtap.new(
    {hs.eventtap.event.types.keyDown},
    function (event)
      if (not obj.isLauncherMode) then
        return
      end
      -- Exit on any, even on unbound key press.
      obj.launcherMode:exit()
      local keyPressed = hs.keycodes.map[event:getKeyCode()]
      local action = obj.apps[keyPressed]
      if (action ~= nil) then
        pcall(action.action)
      elseif (keyPressed == obj.previousActiveAppHotkey) then
        obj:focusPreviousApp()
      end
      -- Consume the pressed key.
      return true
    end
  )
  -- Show indicator in launcher mode.
  obj.modeIndicator = Launcher._composeModeIndicator()

  return obj
end

function Launcher:setPreviousActiveAppHotkey(key)
  if (self.apps[key] ~= nil) then error(key .. " is already bound.") end
  self.previousActiveAppHotkey = key
  return self
end

function Launcher:_composeModeIndicator()
  solarizedRed = rgb256(208, 27, 36)
  solarizedTeal = rgb256(37, 145, 133)
  mainScreenFrame = hs.screen.mainScreen():frame()
  modeIndicatorSize = 200
  launcherModeIndicator = hs.drawing.rectangle{
    x = mainScreenFrame.x + (mainScreenFrame.w - modeIndicatorSize) / 2,
    y = mainScreenFrame.y + (mainScreenFrame.h - modeIndicatorSize) / 2,
    w = modeIndicatorSize,
    h = modeIndicatorSize
  }:setStrokeWidth(0):setFillColor(solarizedTeal):setStrokeColor(solarizedTeal)
  return launcherModeIndicator
end

function Launcher:focusPreviousApp()
  lf(self.previousActiveApp)
end

function Launcher:enable()
  if (self.launcherMode ~= nil) then
    error("Launcher mode is already enabled.")
  end
  self.launcherMode = hs.hotkey.modal.new(self.mods, self.key, nil)
  self.launcherMode.entered = function ()
    self.isLauncherMode = true
    self.modeIndicator:show()
  end
  self.launcherMode.exited = function ()
    self.isLauncherMode = false
    self.modeIndicator:hide()
  end

  self.activeAppWatcher:start()
  self.launcherModeKeyListener:start()
  return self
end

function Launcher:disable()
  launcherMode:exit()
  launcherMode:delete()
  self.launcherMode = nil

  self.activeAppWatcher:stop()
  self.launcherModeKeyListener:stop()
  return self
end

-- ["9"] = {
--   hotkey = "9",
--   text = "",
--   action = function()
--     AppLauncherChooser:query("")
--     AppLauncherChooser:show()
--   end,
-- },

-- AppLauncherChooser = hs.chooser.new(
--   function(choice)
--     print("Choice =", choice["text"])
--     local action = AppLauncherApps[choice["text"]]
--     if (action ~= nil) then action() end
--   end
-- )
-- AppLauncherChooser:choices(choices)
-- AppLauncherChooser:queryChangedCallback(
--   function (newQuery)
--     if (#newQuery > 0) then
--       AppLauncherChooser:query(newQuery)
--       AppLauncherChooser:select()
--     end
--   end
-- )

-- hs.loadSpoon("Seal")
-- spoon.Seal:loadPlugins({"pasteboard"})
-- spoon.Seal:bindHotkeys({show={{"cmd", "shift"}, "\\"}})
-- spoon.Seal.plugins.useractions.actions = {
--     ["Red Hat Bugzilla"] = { url = "https://bugzilla.redhat.com/show_bug.cgi?id=${query}", icon="favicon", keyword="bz" },
--     ["Launchpad Bugs"] = { url = "https://launchpad.net/bugs/${query}", icon="favicon", keyword="lp" },
-- }
-- spoon.Seal:start()
