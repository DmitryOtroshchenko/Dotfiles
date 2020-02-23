
local serpent = require("serpent")

function pf(tab)
  return serpent.block(tab, {nocode = true})
end

function pp(tab)
  print(pf(tab))
end

function withself(obj, func)
  return function (...)
    return func(obj, ...)
  end
end

function split(str, delim, skipEmpty)
  local t = {}
  for substr in string.gmatch(str, "[^".. delim.. "]*") do
    if substr ~= nil and (not skipEmpty or string.len(substr) > 0) then
      table.insert(t, substr)
    end
  end
  return t
end

function trim(s)
  return s:gsub("^%s+", ""):gsub("%s+$", "")
end

function osExecute(cmd)
  local fileHandle = assert(io.popen(cmd, 'r'))
  local outputLines = assert(fileHandle:read('*a'))
  local returnTable = {fileHandle:close()}
  return {
    output = split(outputLines, "\n"),
    retcode = returnTable[3]
  }
end

function rgb256(r, g, b, alpha)
  local alpha = alpha or 1.0
  return {red = r / 256, green = g / 256, blue = b / 256, opacity = alpha}
end
