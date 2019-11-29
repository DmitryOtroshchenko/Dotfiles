
-- Hotkey kitty.
-- hs.hotkey.bind({"cmd"}, "escape", app_man:toggle("kitty"))

-- https://github.com/Hammerspoon/hammerspoon/issues/882
-- https://kirbuchi.com/2016/10/26/playing-with-hammerspoon/
-- https://github.com/Hammerspoon/hammerspoon/issues/848
-- https://github.com/cmsj/hammerspoon-config/blob/master/init.lua

function launchOrFocusCall(app)
  return function ()
    hs.application.launchOrFocus(app)
  end
end

AppLauncherApps = {
  ["n"] = launchOrFocusCall("Vivaldi"),
  ["e"] = launchOrFocusCall("Visual Studio Code"),
  ["space"] = launchOrFocusCall("kitty"),
  ["m"] = launchOrFocusCall("Slack"),
  ["0"] = hs.toggleConsole
}

AppLauncherMode = hs.hotkey.modal.new({"cmd"}, "escape", nil)

AppLauncherModeKeyEvent = hs.eventtap.new(
  {hs.eventtap.event.types.keyDown},
  function (event)
    local keyPressed = hs.keycodes.map[event:getKeyCode()]
    local action = AppLauncherApps[keyPressed]
    if (action ~= nil) then action() end
    AppLauncherMode:exit()
    AppLauncherModeKeyEvent:stop()
    return true
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
