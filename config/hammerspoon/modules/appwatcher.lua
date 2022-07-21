local mod = {}

mod.previousActiveApp = nil

function mod.appSwitchListener(appName, eventType, app)
    if (eventType == hs.application.watcher.deactivated and mod.previousActiveApp ~= appName) then
        print("changed " .. appName)
        mod.previousActiveApp = appName
    end
end

mod.activeAppWatcher = hs.application.watcher.new(mod.appSwitchListener):start()

return mod
