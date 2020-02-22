
local obj = {}

obj.hasBeenMutedBeforeLock = false

function obj:sleepWatch(eventType)
  -- Set volume to 0 when locked.
  if (eventType == hs.caffeinate.watcher.screensDidLock) then
    self.hasBeenMutedBeforeLock = hs.audiodevice.defaultOutputDevice():muted()
    hs.audiodevice.defaultOutputDevice():setMuted(true)
    if (hs.spotify.isRunning()) then hs.spotify.pause() end
  elseif (not self.hasBeenMutedBeforeLock and eventType == hs.caffeinate.watcher.screensDidUnlock) then
    self.hasBeenMutedBeforeLock = false
    hs.audiodevice.defaultOutputDevice():setMuted(false)
  end
end

function obj:startWatcher()
  return hs.caffeinate.watcher.new(self.sleepWatch):start()
end

return obj
