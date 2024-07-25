-- https://github.com/Hammerspoon/hammerspoon/issues/882
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- https://github.com/Hammerspoon/hammerspoon/issues/848
-- https://github.com/cmsj/hammerspoon-config/blob/master/init.lua

require("common")

local std = require("std")
local func = require("std.functional")

Launcher = {}
Launcher.__index = Launcher

function Launcher:create(mods, key, apps)
  local obj = {}
  setmetatable(obj, Launcher)

  self.key = key

  obj.prevLayout = hs.keycodes.currentLayout()
  obj.isLauncherMode = false
  -- Process individual keystrokes in launcher mode.
  obj.launcherModeKeyListener = hs.eventtap.new(
    {
      hs.eventtap.event.types.keyDown,
      -- hs.eventtap.event.types.leftMouseDown,
      -- hs.eventtap.event.types.leftMouseUp,
      -- hs.eventtap.event.types.rightMouseDown,
      -- hs.eventtap.event.types.rightMouseUp,
      -- hs.eventtap.event.types.otherMouseDown,
      -- hs.eventtap.event.types.otherMouseUp
    },
    withself(obj, obj.modeKeyListener)
  ):start()

  obj.apps = {}
  for _, a in ipairs(apps) do
    obj.apps[a["hotkey"]] = a
  end

  return obj
end

-- hs.execute("~/bin/karabiner --set-variables '{\"is_launcher_mode\":1'}")
function Launcher:modeKeyListener(event)
  local keyPressed = hs.keycodes.map[event:getKeyCode()]
  local isRepeat = event:getProperty(hs.eventtap.event.properties.keyboardEventAutorepeat) ~= 0
  print(keyPressed ..
    " " .. tostring(event:getType()) .. " " .. tostring(isRepeat) .. " " .. tostring(self.isLauncherMode))
  -- if (event:getType() == hs.eventtap.event.types.keyDown
  --     and keyPressed == self.key
  --     and isRepeat) then
  --   print("consume 1")
  --   return true
  -- end

  -- if (not self.isLauncherMode) then
  --   if (event:getType() == hs.eventtap.event.types.keyDown and keyPressed == self.key) then
  --     print("consume 2")
  --     self:onLauncherModeEntered()
  --     return true
  --   else
  --     print("normal")
  --     return false
  --   end
  -- else
  --   print("consume 3")
  --   -- Exit on any, even on unbound key press.
  --   self:onLauncherModeExited()
  --   local action = self.apps[keyPressed]
  --   print("action = " .. action.text)
  --   if (action ~= nil) then pcall(action.action) end
  --   -- Consume the pressed key.
  --   return true
  -- end
  return false
end

function Launcher:onLauncherModeEntered()
  self.isLauncherMode = true
  hs.alert.show("Launcher mode", 999999)
  self.prevLayout = hs.keycodes.currentLayout()
  if (self.prevLayout ~= "Colemak") then
    hs.keycodes.setLayout("Colemak")
  end
end

function Launcher:onLauncherModeExited()
  self.isLauncherMode = false
  hs.alert.closeAll()
  if (hs.keycodes.currentLayout() ~= self.prevLayout) then
    hs.keycodes.setLayout(self.prevLayout)
  end
end
