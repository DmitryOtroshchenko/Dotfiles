Sound = {}
Sound.__index = Sound

Sound.hasBeenMutedBeforeLock = false

Sound.watcher = hs.caffeinate.watcher.new(
  function (eventType) Sound:sleepWatch(eventType) end
)

function Sound:sleepWatch(eventType)
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

function Sound:enable() self.watcher:start() end

function Sound:disable() self.watcher:stop() end
