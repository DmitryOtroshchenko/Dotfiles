
-- Set volume to 0 when locked.
hasBeenMutedBeforeLock = false
function sleepWatch(eventType)
  if (eventType == hs.caffeinate.watcher.screensDidLock) then
    hasBeenMutedBeforeLock = hs.audiodevice.defaultOutputDevice():muted()
    hs.audiodevice.defaultOutputDevice():setMuted(true)
    hs.spotify.pause()
  elseif (not hasBeenMutedBeforeLock and eventType == hs.caffeinate.watcher.screensDidUnlock) then
    hasBeenMutedBeforeLock = false
    hs.audiodevice.defaultOutputDevice():setMuted(false)
  end
end

sleepWatcher = hs.caffeinate.watcher.new(sleepWatch)
sleepWatcher:start()
