
local PlaybackStateIcons = {
  [hs.spotify.state_playing]=" ",
  [hs.spotify.state_paused]="•",
  [hs.spotify.state_stopped]="■"
}

function renderSpotifyStatus()
  -- if (hs.spotify.isRunning()) then
  --   local unknown = "UNKNOWN"
  --   local playbackIcon = PlaybackStateIcons[hs.spotify.getPlaybackState()] or " "
  --   local artist = hs.spotify.getCurrentArtist() or unknown
  --   local track = hs.spotify.getCurrentTrack() or unknown
  --   return hs.styledtext.new(
  --     playbackIcon .. " " .. artist .. ' - ' .. track,
  --     {font={name="Source Code Pro"}}
  --   )
  -- end
  return ""
end

function renderCpuAlert(loadThreshold)
  loadThreshold = loadThreshold or 75
  assert(loadThreshold >= 0 and loadThreshold <= 100)
  local cpuLoad = math.ceil(hs.host.cpuUsage()["overall"]["active"])
  if (cpuLoad >= 75) then
    local cpuLoadRepr = tostring(cpuLoad)
    if (cpuLoadRepr:len() < 2) then
      cpuLoadRepr = " " .. cpuLoadRepr
    end
    return hs.styledtext.new(
      "CPU = " .. cpuLoadRepr .. "%",
      {
        font={name="Source Code Pro"},
        color=hs.drawing.color.hammerspoon.osx_red
      }
    )
  end
  return ""
end

function renderMenuWidgets(widgets)
  local menuBarText = hs.styledtext.new("")
  for _, widgetFunc in pairs(widgets) do
    local widgetText = widgetFunc() or ""
    if (type(widgetText) == "string") then
      widgetText = hs.styledtext.new(widgetText)
    end
    menuBarText = menuBarText .. widgetText
  end
  return menuBarText
end

function spacer(nSpaces)
  nSpaces = nSpaces or 2
  assert(not nSpaces or nSpaces >= 0)
  return (" "):rep(nSpaces)
end

function buildMenuBar()
  local main = hs.menubar.new():setClickCallback(hs.spotify.playpause)
  main:setMenu(
    {
      { title = "Next", fn = hs.spotify.next },
      { title = "Prev", fn = hs.spotify.previous },
    }
  )
  return main
end

local MenuBar = buildMenuBar()

local MenuBarWidgets = {
  renderCpuAlert,
  spacer,
  renderSpotifyStatus
}
-- Important: if not assigned to a variable, timers get garbage collected.
MenuRefreshTimer = hs.timer.doEvery(
  0.5,
  function() MenuBar:setTitle(renderMenuWidgets(MenuBarWidgets)) end
)
