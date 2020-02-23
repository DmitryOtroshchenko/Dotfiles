MuteOnLock = {}
MuteOnLock.__index = MuteOnLock

function MuteOnLock:create()
  obj = {}
  setmetatable(obj, MuteOnLock)

  obj.hasBeenMutedBeforeLock = false
  obj.watcher = hs.caffeinate.watcher.new(
    function (eventType) obj:sleepWatch(eventType) end
  )
  return obj
end

function MuteOnLock:sleepWatch(eventType)
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

function MuteOnLock:enable()
  self.watcher:start()
  return self
end

function MuteOnLock:disable()
  self.watcher:stop()
  return self
end
