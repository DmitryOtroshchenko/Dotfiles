require("modules.window_management")
require("modules.sound")

hs.application.enableSpotlightForNameSearches(true)

-- Reload hs.
hs.hotkey.bind(
  {"cmd", "alt", "ctrl"}, "R",
  function()
    hs.reload()
  end
)

-- Hotkey kitty.
local app_man = require("modules.appman")
hs.hotkey.bind({"cmd"}, "escape", app_man:toggle("kitty"))


local log = hs.logger.new("root", "debug")

local menu_bar = hs.menubar.new()
local PlaybackStateIcons = {
  [hs.spotify.state_playing]=" ",
  [hs.spotify.state_paused]="•",
  [hs.spotify.state_stopped]="■"
}
-- Important: if not assigned to a variable, timers get garbage collected.
SpotifyStatusTimer = hs.timer.doEvery(
  0.5,
  function()
    local menuBarText = ""
    -- Update spotify status.
    if (hs.spotify.isRunning()) then
      local unknown = "UNKNOWN"
      local playbackIcon = PlaybackStateIcons[hs.spotify.getPlaybackState()] or " "
      local artist = hs.spotify.getCurrentArtist() or unknown
      local track = hs.spotify.getCurrentTrack() or unknown
      menuBarText = playbackIcon .. " " .. artist .. ' - ' .. track
    end
    -- Update CPU usage.
    local cpuLoad = math.ceil(hs.host.cpuUsage()["overall"]["active"])
    if (cpuLoad >= 0) then
      menuBarText = menuBarText .. "  " .. cpuLoad .. "%"
    end
    -- Update
    menu_bar:setTitle(menuBarText)
  end
)
