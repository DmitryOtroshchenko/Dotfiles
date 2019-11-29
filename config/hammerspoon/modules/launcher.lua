
-- Hotkey kitty.
-- hs.hotkey.bind({"cmd"}, "escape", app_man:toggle("kitty"))

-- https://github.com/Hammerspoon/hammerspoon/issues/882
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- https://github.com/Hammerspoon/hammerspoon/issues/848
-- https://github.com/cmsj/hammerspoon-config/blob/master/init.lua
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
    if (appToFocus ~= nil) then
      hs.application.launchOrFocus(appToFocus)
    elseif (keyPressed == "0") then
      hs.toggleConsole()
    end
    AppLauncherMode:exit()
    AppLauncherModeKeyEvent:stop()
    return (appToFocus ~= nil or keyPressed == "0")
  end
)

AppLauncherMode.entered = function () AppLauncherModeKeyEvent:start() end

-- Seal
hs.loadSpoon("Seal")
-- spoon.Seal:loadPlugins({"apps"})
-- spoon.Seal:bindHotkeys({show={{"cmd"}, "\\"}})
-- spoon.Seal.plugins.useractions.actions = {
--     ["Red Hat Bugzilla"] = { url = "https://bugzilla.redhat.com/show_bug.cgi?id=${query}", icon="favicon", keyword="bz" },
--     ["Launchpad Bugs"] = { url = "https://launchpad.net/bugs/${query}", icon="favicon", keyword="lp" },
-- }
spoon.Seal:start()
