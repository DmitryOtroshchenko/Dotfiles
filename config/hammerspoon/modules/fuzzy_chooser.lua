local string = require("std.string")
local io = require("std.io")

FuzzyChooser = {}
FuzzyChooser.__index = FuzzyChooser

function FuzzyChooser:create(items)
  local obj = {}
  setmetatable(obj, FuzzyChooser)

  obj.items = items
  obj.appChooser = hs.chooser
    .new(function (choice) obj:_queryAccepted(choice) end)
    :choices(FuzzyChooser:_appTableToChoices(items))
    :queryChangedCallback(function (q) obj:_queryChanged(q) end)

  return obj
end

function FuzzyChooser:showAppChooser(query)
  self.appChooser:query(query or ""):show()
end

function FuzzyChooser:_queryChanged(newQuery)
  local itemsStr = ""
  for _, item in pairs(self.items) do
    itemsStr = itemsStr .. "\n" .. item["text"]
  end
  itemsStr = string.trim(itemsStr)

  local skCommand = "printf \'"..itemsStr.."\' | /usr/local/bin/sk -f \'"..newQuery.."\' | sort"
  local skOutput = string.split(io.shell(skCommand), '\n')
  local filteredItems = {}
  for _, skLine in ipairs(skOutput) do
    if #skLine > 0 then
      filteredItems[#filteredItems+1] = self:_skToChoice(skLine)
    end
  end
  self.appChooser:choices(filteredItems)
end

function FuzzyChooser:_queryAccepted(choice)
  pp(choice)
  if (choice ~= nil) then
    local app = self.items[choice["hotkey"]]
    pcall(app.action)
  end
end

function FuzzyChooser:_appTableToChoices(apps)
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

function FuzzyChooser:_skToChoice(sk)
  local scoreAndChoice = string.split(sk, '\t')
  return {
    ["text"] = scoreAndChoice[2]
  }
end
