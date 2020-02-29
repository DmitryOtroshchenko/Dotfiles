require("common")

local string = require("std.string")
local table = require("std.table")
local io = require("std.io")

FuzzyChooser = {}
FuzzyChooser.__index = FuzzyChooser

function FuzzyChooser:create(items)
  local obj = {}
  setmetatable(obj, FuzzyChooser)

  obj.items = items
  obj.appChooser = hs.chooser
    .new(withself(obj, obj._queryAccepted))
    :choices(FuzzyChooser._appTableToChoices(items))
    :queryChangedCallback(withself(obj, obj._queryChanged))

  return obj
end

function FuzzyChooser:showAppChooser(query)
  self.appChooser:query(query or ""):show()
end

function FuzzyChooser:_queryChanged(newQuery)
  self.appChooser:choices(self._runSk(self.items, newQuery))
end

function FuzzyChooser:_queryAccepted(choice)
  if (choice ~= nil) then
    local app = self.items[choice["ix"]]
    pcall(app.action)
  end
end

function FuzzyChooser._appTableToChoices(apps)
  local choices = {}
  for _, app in pairs(apps) do
    choices[#choices+1] = {
      ["text"] = app["text"],
      ["subText"] = "[" .. app["hotkey"] .. "]",
      ["hotkey"] = app["hotkey"]
    }
  end
  return choices
end

function FuzzyChooser._runSk(items, query)
  local delimiter = ":"
  local itemsStr = ""
  for ix, item in pairs(items) do
    itemsStr = itemsStr .. "\n" .. tostring(ix) .. delimiter .. item["text"]
  end
  itemsStr = string.trim(itemsStr)

  local skCommand = "printf \'"..itemsStr.."\' | /usr/local/bin/sk -d\'"..delimiter.."\' --nth=2 -f \'"..string.escape_shell(query).."\'"
  local skOutput = string.split(io.shell(skCommand), '\n')
  local filteredItems = {}
  for _, skLine in ipairs(skOutput) do
    if #skLine > 0 then
      filteredItems[#filteredItems+1] = FuzzyChooser._skToChoice(skLine)
    end
  end
  table.sort(filteredItems, function (a, b) return a.score > b.score end)
  return filteredItems
end

function FuzzyChooser._skToChoice(sk)
  local scoreAndChoice = string.split(sk, "\t")
  local choiceIxAndText = string.split(scoreAndChoice[2], ":")
  return {
    score = tonumber(scoreAndChoice[1]),
    text = choiceIxAndText[2],
    ix = tonumber(choiceIxAndText[1])
  }
end
