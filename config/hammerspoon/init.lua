
hs.application.enableSpotlightForNameSearches(true)

-- Reload hs.
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function() hs.reload() end
)

require("modules.launcher")

require("modules.sound")
Sound:enable()

require("modules.window_management")

-- spaces = require("hsmodules._asm.undocumented.spaces")
-- hs.hotkey.bind(
--   {"cmd", "ctrl"}, "A",
--   function()
--     local sp = hs.window:spaces()
--     print(sp)
--     spaces.moveToSpace(1)
--   end
-- )
