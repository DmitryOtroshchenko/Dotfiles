
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function() hs.reload() end
)


local app_man = require('modules.appman')
hs.hotkey.bind({"cmd"}, "escape", app_man:toggle("kitty"))


hasBeenMutedBeforeLock = false

function sleepWatch(eventType)
  -- Set volume to 0 when locked.
  if (eventType == hs.caffeinate.watcher.screensDidLock) then
    hasBeenMutedBeforeLock = hs.audiodevice.defaultOutputDevice():muted()
    hs.audiodevice.defaultOutputDevice():setMuted(true)
    hs.spotify.pause()
  elseif (not hasBeenMutedBeforeLock and eventType == hs.caffeinate.watcher.screensDidUnlock) then
    hasBeenMutedBeforeLock = false
    hs.audiodevice.defaultOutputDevice():setMuted(false)
  end
end

hs.caffeinate.watcher.new(sleepWatch):start()
