-- Stfu when locked.
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

SleepWatcher = hs.caffeinate.watcher.new(sleepWatch):start()
