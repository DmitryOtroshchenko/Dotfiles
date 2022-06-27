-- Classes in lua: http://lua-users.org/wiki/SimpleLuaClasses
-- luacheck setup: https://github.com/mpeterv/luacheck/issues/78

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
LauncherInstance = Launcher:create({}, "f20", LauncherApps)
LauncherApps = {
  -- {
  --   hotkey = "x",
  --   text = "xcode",
  --   action = function()
  --     pcall(function() hs.window.find("iPhone 11"):focus() end)
  --     lfAndMaximize("Xcode")
  --   end,
  -- },
  -- {
  --   hotkey = "z",
  --   text = "Zoom",
  --   action = function() lfAndMaximize("zoom.us") end,
  -- },
  -- {
  --   hotkey = "n",
  --   text = "Firefox",
  --   action = function() lfAndMaximize("Brave Browser") end,
  -- },
  -- {
  --   hotkey = "e",
  --   text = "Visual Studio Code",
  --   action = function() lfAndMaximize("Visual Studio Code") end,
  -- },
  -- {
  --   hotkey = "space",
  --   text = "kitty",
  --   action = function() lfAndMaximize("kitty") end,
  -- },
  -- {
  --   hotkey = "m",
  --   text = "Slack",
  --   action = function() lfAndMaximize("Slack") end,
  --   -- action = function() lfAndMaximize("Brave Browser") end,
  -- },
  {
    hotkey = "i",
    text = "IntelliJ",
    action = function() lfAndMaximize("IntelliJ IDEA") end,
  },
  -- {
  --   hotkey = "p",
  --   text = "Bitwarden",
  --   action = function() lfAndMaximize("Bitwarden") end,
  -- },
  -- {
  --   hotkey = "r",
  --   text = "Insomnia",
  --   action = function() lfAndMaximize("Insomnia") end,
  -- },
  -- {
  --   hotkey = "s",
  --   text = "Spotify",
  --   action = function() lfAndMaximize("Spotify") end,
  -- },
  -- {
  --   hotkey = "t",
  --   text = "Telegram",
  --   action = function() lfAndMaximize("Telegram") end,
  -- },
  -- {
  --   hotkey = "l",
  --   text = "Obsidian",
  --   action = function() lfAndMaximize("Obsidian") end,
  -- },
  -- {
  --   hotkey = "c",
  --   text = "Fusion 360",
  --   action = function () lfAndMaximize("Autodesk Fusion 360") end,
  -- },
  {
    hotkey = "f20",
    text = "Activate previous app",
    action = function() LauncherInstance:focusPreviousApp() end
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
LauncherInstance:enable(LauncherApps)

-- ChooserInstance = FuzzyChooser:create(LauncherApps)
-- hs.hotkey.bind(
--   {"ctrl"}, "j",
--   function () ChooserInstance:showAppChooser() end
-- )

require("modules.sound")

MuteOnLockInstance = MuteOnLock:create():enable()

require("modules.window_management")

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
