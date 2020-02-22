
hs.application.enableSpotlightForNameSearches(true)

local app_man = require("modules.appman")

require("modules.launcher")
require("modules.menu")
require("modules.window_management")

require("modules.sound")
Sound:enable()

-- Reload hs.
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function() hs.reload() end
)

-- spaces = require("hsmodules._asm.undocumented.spaces")
-- hs.hotkey.bind(
--   {"cmd", "ctrl"}, "A",
--   function()
--     local sp = hs.window:spaces()
--     print(sp)
--     spaces.moveToSpace(1)
--   end
-- )
