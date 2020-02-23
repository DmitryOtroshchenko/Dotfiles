-- Classes in lua: http://lua-users.org/wiki/SimpleLuaClasses

hs.application.enableSpotlightForNameSearches(true)

-- Reload hs.
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function () hs.reload() end
)

require("modules.launcher")

LauncherInstance = Launcher:create({}, "f20", LauncherApps)
LauncherApps = {
  ["n"] = {
    hotkey = "n",
    text = "Vivaldi",
    action = function () lfAndMaximize("Vivaldi") end,
  },
  ["e"] = {
    hotkey = "e",
    text = "Visual Studio Code",
    action = function () lfAndMaximize("Visual Studio Code") end,
  },
  ["space"] = {
    hotkey = "space",
    text = "kitty",
    action = function () lfAndMaximize("kitty") end,
  },
  ["m"] = {
    hotkey = "m",
    text = "Slack",
    action = function () lfAndMaximize("Slack") end,
  },
  ["i"] = {
    hotkey = "i",
    text = "IntelliJ",
    action = function () lfAndMaximize("IntelliJ IDEA Community") end,
  },
  ["p"] = {
    hotkey = "p",
    text = "Postman",
    action = function () lfAndMaximize("Postman") end,
  },
  ["f20"] = {
    hotkey = "f20",
    text = "Activate previous appp",
    action = function () LauncherInstance:focusPreviousApp() end
  },
  ["0"] = {
    hotkey = "0",
    text = "Hammerspoon Console",
    action = hs.toggleConsole,
  },
  ["-"] = {
    hotkey = "-",
    text = "",
    action = function () hs.keycodes.setLayout("Colemak") end
  },
  ["="] = {
    hotkey = "=",
    text = "",
    action = function () hs.keycodes.setLayout("Rulemak") end
  },
}
LauncherInstance:enable(LauncherApps)

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
