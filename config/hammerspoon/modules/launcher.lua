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
    hs.window.focusedWindow():moveToUnit({ x, y, w, h })
  end
end

function lfAndMaximize(app)
  lfAndMove(app, 0, 0, 1, 1)
end

Launcher = {}
Launcher.__index = Launcher

function Launcher:create(mods, key, apps)
  print('Creating launcher bound to ' .. key .. '.')
  local obj = {}
  setmetatable(obj, Launcher)

  obj.prevLayout = hs.keycodes.currentLayout()
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
  ):start()

  obj.apps = {}
  for _, a in ipairs(apps) do
    obj.apps[a["hotkey"]] = a
  end
  -- Setup hotkey event.
  obj.launcherMode = hs.hotkey.modal.new(mods, key, nil)
  obj.launcherMode.entered = withself(obj, obj._onLauncherModeEntered)
  obj.launcherMode.exited = withself(obj, obj._onLauncherModeExited)

  print('Launcher created.')
  return obj
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
  hs.alert.show("Launcher mode", 999999)
  hs.execute("~/bin/karabiner --set-variables '{\"is_launcher_mode\":1'}")
  self.prevLayout = hs.keycodes.currentLayout()
  if (self.prevLayout ~= "Colemak") then
    hs.keycodes.setLayout("Colemak")
  end
end

function Launcher:_onLauncherModeExited()
  self.isLauncherMode = false
  hs.alert.closeAll()
  hs.execute("~/bin/karabiner --set-variables '{\"is_launcher_mode\":0'}")
  if (hs.keycodes.currentLayout() ~= self.prevLayout) then
    hs.keycodes.setLayout(self.prevLayout)
  end
end

function Launcher._triggerAction(action)
  pcall(action.action)
end

-- hs.loadSpoon("Seal")
-- spoon.Seal:loadPlugins({"apps"})
-- spoon.Seal:bindHotkeys({show={{"cmd", "shift"}, "\\"}})
-- -- spoon.Seal.plugins.useractions.actions = {
-- --     ["Red Hat Bugzilla"] = { url = "https://bugzilla.redhat.com/show_bug.cgi?id=${query}", icon="favicon", keyword="bz" },
-- --     ["Launchpad Bugs"] = { url = "https://launchpad.net/bugs/${query}", icon="favicon", keyword="lp" },
-- -- }
-- spoon.Seal:start()
