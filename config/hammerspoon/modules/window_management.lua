-- Window management.
hs.window.animationDuration = 0

local moveWindowRel = function(xr, yr, wr, hr)
  -- Move and size focused window in percentage coordinates.
  assert(
    0 <= xr and xr <= 1 and 0 <= yr and yr <= 1
    and 0 <= wr and wr <= 1 and 0 <= hr and hr <= 1,
    "Invalid window size or coordinates."
  )
  local win = hs.window.focusedWindow()
  local f = win:frame()
  local screenBbox = win:screen():frame()

  f.x = screenBbox.x + screenBbox.w * xr
  f.y = screenBbox.y + screenBbox.h * yr
  f.w = screenBbox.w * wr
  f.h = screenBbox.h * hr
  win:setFrame(f)
end

local mv = function(key, xr, yr, wr, hr)
  hs.hotkey.bind(
    {"cmd", "ctrl"}, key,
    function() moveWindowRel(xr, yr, wr, hr) end
  )
end

mv("n", 0, 0, 0.5, 1)
mv("o", 0.5, 0, 0.5, 1)
mv("e", 0, 0, 1, 0.5)
mv("i", 0, 0.5, 1, 0.5)
mv("t", 0, 0, 1, 1)
