-- https://github.com/Hammerspoon/hammerspoon/issues/882
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- https://github.com/Hammerspoon/hammerspoon/issues/848
-- https://github.com/cmsj/hammerspoon-config/blob/master/init.lua

require("common")

local std = require("std")
local func = require("std.functional")

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

function Launcher:create(mods, key)
  print('Creating launcher bound to ' .. key .. '.')
  local obj = {}
  setmetatable(obj, Launcher)
  obj.mods = mods
  obj.key = key
  obj.apps = nil
  obj.prevLayout = hs.keycodes.currentLayout()
  -- Setup state remembering app switches.
  obj.previousActiveApp = nil
  obj.activeAppWatcher = hs.application.watcher.new(
    withself(obj, obj._appSwitchListener))
  -- Set up app launcher hotkey mode.
  obj.isLauncherMode = false
  -- Process individual keystrokes in launcher mode.
  obj.launcherModeKeyListener = hs.eventtap.new(
    {
      hs.eventtap.event.types.keyDown,
      hs.eventtap.event.types.leftMouseDown,
      hs.eventtap.event.types.leftMouseUp,
      hs.eventtap.event.types.rightMouseDown,
      hs.eventtap.event.types.rightMouseUp,
      hs.eventtap.event.types.otherMouseDown,
      hs.eventtap.event.types.otherMouseUp
    },
    withself(obj, obj._modeKeyListener)
  )
  -- Show indicator in launcher mode.
  obj.modeIndicators = nil

  print('Launcher created.')
  return obj
end

function Launcher:focusPreviousApp()
  lf(self.previousActiveApp)
end

function Launcher:enable(apps)
  print('Enabling launcher...')
  if (self.launcherMode ~= nil) then
    error("Launcher mode is already enabled.")
  end
  self.apps = {}
  for _, a in ipairs(apps) do
    self.apps[a["hotkey"]] = a
  end
  -- Setup hotkey event.
  self.launcherMode = hs.hotkey.modal.new(self.mods, self.key, nil)
  self.launcherMode.entered = withself(self, self._onLauncherModeEntered)
  self.launcherMode.exited = withself(self, self._onLauncherModeExited)
  -- Start listeners.
  self.activeAppWatcher:start()
  self.launcherModeKeyListener:start()
  print('Launcher enabled.')
  return self
end

function Launcher:disable()
  print('Disabling launcher...')
  -- Exit and delete mode.
  launcherMode:exit()
  launcherMode:delete()
  self.launcherMode = nil
  -- Stop event listeners.
  self.activeAppWatcher:stop()
  self.launcherModeKeyListener:stop()
  print('Launcher disabled.')
  return self
end

function Launcher:_appSwitchListener(appName, eventType, app)
  if (self.previousActiveApp ~= appName) then
    self.previousActiveApp = app:path()
  end
end

function Launcher:_modeKeyListener(event)
  local keyPressed = hs.keycodes.map[event:getKeyCode()]
  local isRepeat = event:getProperty(hs.eventtap.event.properties.keyboardEventAutorepeat) ~= 0
  if (event:getType() == hs.eventtap.event.types.keyDown
      and keyPressed == self.key
      and isRepeat) then
    return true
  end
  if (not self.isLauncherMode) then
    if (event:getType() == hs.eventtap.event.types.keyDown and keyPressed == self.key) then
      self.launcherMode:enter()
      return true
    else
      return false
    end
  else
    -- Exit on any, even on unbound key press.
    self.launcherMode:exit()
    local action = self.apps[keyPressed]
    if (action ~= nil) then Launcher._triggerAction(action) end
    -- Consume the pressed key.
    return true
  end
end

function Launcher:_onLauncherModeEntered()
  self.isLauncherMode = true
  self.prevLayout = hs.keycodes.currentLayout()
  if (self.prevLayout ~= "Colemak") then
    hs.keycodes.setLayout("Colemak")
  end
  self.modeIndicators = func.map(
    function (screen)
      local mi = Launcher._composeModeIndicator(screen:frame())
      mi:show()
      return mi
    end,
    std.ielems,
    hs.screen.allScreens()
  )
end

function Launcher:_onLauncherModeExited()
  self.isLauncherMode = false
  if (hs.keycodes.currentLayout() ~= self.prevLayout) then
    hs.keycodes.setLayout(self.prevLayout)
  end
  func.map(
    function (indicator)
      indicator:hide()
      indicator:delete()
    end,
    std.ielems,
    self.modeIndicators
  )
  self.modeIndicators = nil
end

function Launcher._triggerAction(action)
  pcall(action.action)
end

function Launcher._composeModeIndicator(screenFrame)
  local solarizedRed = rgb256(208, 27, 36)
  local solarizedTeal = rgb256(37, 145, 133)
  local modeIndicatorSize = 200
  local launcherModeIndicator = hs.drawing.rectangle{
      x = screenFrame.x + (screenFrame.w - modeIndicatorSize) / 2,
      y = screenFrame.y + (screenFrame.h - modeIndicatorSize) / 2,
      w = modeIndicatorSize,
      h = modeIndicatorSize
    }
    :setStrokeWidth(0)
    :setFillColor(solarizedTeal)
    :setStrokeColor(solarizedTeal)
  return launcherModeIndicator
end

-- hs.loadSpoon("Seal")
-- spoon.Seal:loadPlugins({"apps"})
-- spoon.Seal:bindHotkeys({show={{"cmd", "shift"}, "\\"}})
-- -- spoon.Seal.plugins.useractions.actions = {
-- --     ["Red Hat Bugzilla"] = { url = "https://bugzilla.redhat.com/show_bug.cgi?id=${query}", icon="favicon", keyword="bz" },
-- --     ["Launchpad Bugs"] = { url = "https://launchpad.net/bugs/${query}", icon="favicon", keyword="lp" },
-- -- }
-- spoon.Seal:start()
