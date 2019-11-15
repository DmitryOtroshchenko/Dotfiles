require("modules.window_management")
require("modules.sound")

-- Reload hs.
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function() hs.reload() end
)

-- Hotkey kitty.
local app_man = require("modules.appman")
hs.hotkey.bind({"cmd"}, "escape", app_man:toggle("kitty"))
