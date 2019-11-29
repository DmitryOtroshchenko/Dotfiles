local app_man = require("modules.appman")

require("modules.launcher")
require("modules.menu")
require("modules.sound")
require("modules.window_management")

hs.application.enableSpotlightForNameSearches(true)

-- Reload hs.
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function() hs.reload() end
)
