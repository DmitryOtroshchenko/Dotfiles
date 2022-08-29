-- Classes in lua: http://lua-users.org/wiki/SimpleLuaClasses
-- luacheck setup: https://github.com/mpeterv/luacheck/issues/78

-- To make lua work with packages: config/hammerspoon/luarocks -> /usr/local/share/lua/5.4/luarocks/
-- See https://github.com/Hammerspoon/hammerspoon/issues/363
package.path = "/usr/local/share/lua/5.3/?.lua;/usr/local/share/lua/5.3/?/init.lua;" .. package.path
package.cpath = "/usr/local/lib/lua/5.3/?.so;" .. package.cpath

require("hs.ipc")

hs.application.enableSpotlightForNameSearches(true)

-- Reload hs.
hs.hotkey.bind(
  { "cmd", "alt", "ctrl" }, "R",
  function() hs.reload() end
)

AppWatcher = require("modules.appwatcher")
require("modules.launcher")
require("modules.fuzzy_chooser")
require("modules.audio_device_chooser")

local function starcraftRemoveUnitFromSelection()
  local first_unit_icon_center = { x = 550, y = 880 }
  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types['leftMouseDown'], first_unit_icon_center, { 'shift' }):post()
  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types['leftMouseUp'], first_unit_icon_center, { 'shift' }):post()
  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types['leftMouseDown'], first_unit_icon_center, { 'shift' }):post()
  hs.eventtap.event.newMouseEvent(hs.eventtap.event.types['leftMouseUp'], first_unit_icon_center, { 'shift' }):post()
end

-- LauncherInstance = Launcher:create('cmd-ctrl', "a", LauncherApps)
LauncherApps = {
  {
    hotkey = "x",
    text = "xcode",
    action = function()
      pcall(function() hs.window.find("iPhone 11"):focus() end)
      lfAndMaximize("Xcode")
    end,
  },
  {
    hotkey = "z",
    text = "Zoom",
    action = function() lfAndMaximize("zoom.us") end,
  },
  {
    hotkey = "n",
    text = "Firefox",
    action = function() lfAndMaximize("Brave Browser") end,
  },
  {
    hotkey = "e",
    text = "Visual Studio Code",
    action = function() lfAndMaximize("Visual Studio Code") end,
  },
  {
    hotkey = "space",
    text = "kitty",
    action = function() lfAndMaximize("kitty") end,
  },
  {
    hotkey = "m",
    text = "Slack",
    action = function() lfAndMaximize("Slack") end,
  },
  {
    hotkey = "i",
    text = "IntelliJ",
    action = function() lfAndMaximize("IntelliJ IDEA") end,
  },
  {
    hotkey = "p",
    text = "Bitwarden",
    action = function() lfAndMaximize("Bitwarden") end,
  },
  {
    hotkey = "r",
    text = "Insomnia",
    action = function() lfAndMaximize("Insomnia") end,
  },
  {
    hotkey = "s",
    text = "Spotify",
    action = function() lfAndMaximize("Spotify") end,
  },
  {
    hotkey = "t",
    text = "Telegram",
    action = function() lfAndMaximize("Telegram") end,
  },
  {
    hotkey = "l",
    text = "Obsidian",
    action = function() lfAndMaximize("Obsidian") end,
  },
  {
    hotkey = "f20",
    text = "Activate previous app",
    action = function() lf(AppWatcher.previousActiveApp) end
  },
  {
    hotkey = "0",
    text = "Hammerspoon Console",
    action = hs.toggleConsole,
  },
  {
    hotkey = "-",
    text = "Switch to Colemak",
    action = function() hs.keycodes.setLayout("Colemak") end
  },
  {
    hotkey = "=",
    text = "Switch to Rulemak",
    action = function() hs.keycodes.setLayout("Rulemak") end
  },
  {
    hotkey = "delete",
    text = "Choose audio output device",
    action = chooseAudioOutputDevice
  },
  {
    hotkey = "'",
    text = "AltTab",
    action = function() hs.eventtap.keyStroke({ "alt" }, "tab") end
  },
}
LauncherInstance = Launcher:create({}, "f20", LauncherApps)

-- Reload hs.
hs.hotkey.bind(
  { "cmd", "alt", "ctrl" }, "R",
  function()
    hs.reload()
    hs.application.launchOrFocus("Hammerspoon")
  end
)

-- ChooserInstance = FuzzyChooser:create(LauncherApps)
-- hs.hotkey.bind(
--   {"ctrl"}, "j",
--   function () ChooserInstance:showAppChooser() end
-- )

require("modules.sound")

MuteOnLockInstance = MuteOnLock:create():enable()

require("modules.window_management")

function getThrottleSettings()
  -- hs.execute("pmset -g therm | sd '\n' ' ' | rg 'CPU_Scheduler_Limit\\s+=\\s+(\\d+)\\s+CPU_Available_CPUs\\s+=\\s+(\\d+)\\s+CPU_Speed_Limit\\s+=\\s+(\\d+)' -r '$1 $2 $3'")
  local output = hs.execute("pmset -g therm")
  local _, _, schedulerLimit = string.find(output, "CPU_Scheduler_Limit%s+=%s+(%d+)")
  local _, _, speedLimit = string.find(output, "CPU_Speed_Limit%s+=%s+(%d+)")
  return schedulerLimit, speedLimit
end

ThrottleMenuItem = hs.menubar.new()
ThrottleMenuItemTimer = hs.timer.new(5, function()
  local scheduler, speed = getThrottleSettings()
  print(scheduler, speed)
  ThrottleMenuItem:setTitle('Scheduler = ' .. tostring(scheduler) .. ' Speed = ' .. tostring(speed))
end)
ThrottleMenuItemTimer:start()

-- spaces = require("hsmodules._asm.undocumented.spaces")
-- hs.hotkey.bind(
--   {"cmd", "ctrl"}, "A",
--   function ()
--     local sp = hs.window:spaces()
--     print(sp)
--     spaces.moveToSpace(1)
--   end
-- )

-- local mt = {
--   __newindex = function(t, k, v)
--     error('Attempt to set new global variable "' .. k .. '", was this a typo?', 2)
--   end,
--   __index = function(t,k)
--     error('Attempt to access non-existent global variable "' .. k .. '", was this a typo?', 2)
--   end
-- }
-- setmetatable(_ENV, mt)
