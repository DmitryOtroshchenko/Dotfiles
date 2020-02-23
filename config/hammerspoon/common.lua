
local serpent = require("modules.serpent")

function pf(tab)
  return serpent.block(tab, {nocode = true})
end

function pp(tab)
  print(pf(tab))
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

function osExecute(cmd)
  local fileHandle = assert(io.popen(cmd, 'r'))
  local outputLines = assert(fileHandle:read('*a'))
  local returnTable = {fileHandle:close()}
  return {
    output = split(outputLines, "\n"),
    retcode = returnTable[3]
  }
end
