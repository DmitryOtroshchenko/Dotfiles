local app_man = require("modules.appman")

require("modules.menu")
require("modules.sound")
require("modules.window_management")


hs.application.enableSpotlightForNameSearches(true)

-- Reload hs.
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function()
    hs.reload()
  end
)

-- Hotkey kitty.
-- hs.hotkey.bind({"cmd"}, "escape", app_man:toggle("kitty"))

local log = hs.logger.new("root", "debug")

-- hs.loadSpoon("Seal")
-- spoon.Seal:loadPlugins({"useractions"})
-- spoon.Seal:bindHotkeys({show={{"cmd"}, "escape"}})
-- spoon.Seal.plugins.useractions.actions = {
--     ["Red Hat Bugzilla"] = { url = "https://bugzilla.redhat.com/show_bug.cgi?id=${query}", icon="favicon", keyword="bz" },
--     ["Launchpad Bugs"] = { url = "https://launchpad.net/bugs/${query}", icon="favicon", keyword="lp" },
-- }
-- spoon.Seal:start()

-- https://github.com/Hammerspoon/hammerspoon/issues/882
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- https://github.com/Hammerspoon/hammerspoon/issues/848
AppLauncherMode = hs.hotkey.modal.new({"cmd"}, "escape", nil)

AppLauncherApps = {
  ["n"] = "Vivaldi",
  ["e"] = "Visual Studio Code",
  ["space"] = "kitty",
  ["m"] = "Slack"
}

AppLauncherModeKeyEvent = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown},
  function (event)
    local keyPressed = hs.keycodes.map[event:getKeyCode()]
    local appToFocus = AppLauncherApps[keyPressed]
    if (appToFocus ~= nil) then hs.application.launchOrFocus(appToFocus) end
    AppLauncherMode:exit()
    AppLauncherModeKeyEvent:stop()
    return (appToFocus ~= nil)
  end
)

AppLauncherMode.entered = function () AppLauncherModeKeyEvent:start() end
