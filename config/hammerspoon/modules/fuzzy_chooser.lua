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
  local skCommand = "/usr/local/bin/fd | /usr/local/bin/sk -f \'"..newQuery.."\' | sort"
  local skResult = osExecute(skCommand)
  local newChoices = {}
  for _, skLine in ipairs(skResult.output) do
    if #skLine > 0 then
      newChoices[#newChoices+1] = self:_skToChoice(skLine)
    end
  end
  self.appChooser:choices(newChoices)
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
  local scoreAndChoice = split(sk, '\t')
  return {
    ["text"] = scoreAndChoice[2]
  }
end
