-- require("common")

-- local std = require("std")
-- local func = require("std.functional")
-- local string = require("std.string")
-- local table = require("std.table")
-- local io = require("std.io")
-- local lfs = require("lfs")

-- FuzzyChooser = {}
-- FuzzyChooser.__index = FuzzyChooser
-- FuzzyChooser.delimiter = ":"

-- function FuzzyChooser:create(items)
--   local obj = {}
--   setmetatable(obj, FuzzyChooser)

--   obj.items = items
--   obj.appChooser = hs.chooser.new(withself(obj, obj._queryAccepted))
--     :choices(FuzzyChooser._appTableToChoices(items))
--     :queryChangedCallback(withself(obj, obj._queryChanged))

--   return obj
-- end

-- function FuzzyChooser:showAppChooser(query)
--   self.appChooser:query(query or ""):show()
-- end

-- function FuzzyChooser:_queryChanged(newQuery)
--   self.appChooser:choices(self._runSk(self.items, newQuery))
-- end

-- function FuzzyChooser:_queryAccepted(choice)
--   if (choice ~= nil) then
--     local app = self.items[choice["ix"]]
--     pcall(app.action)
--   end
-- end

-- function FuzzyChooser._appTableToChoices(apps)
--   return func.map(
--     function (app)
--       return { text = app["text"], subText = "[" .. app["hotkey"] .. "]" }
--     end,
--     std.ielems,
--     apps
--   )
-- end

-- function FuzzyChooser._runSk(items, query)
--   local itemsStr = func.foldl(
--     function (l, r) return l .. "\n" .. r end,
--     func.map(
--       function (ix, item) return ix .. FuzzyChooser.delimiter .. item["text"] end,
--       std.npairs,
--       items
--     )
--   )

--   local skCommand = "printf \'"..itemsStr.."\' | /usr/local/bin/sk -d\'"..FuzzyChooser.delimiter.."\' --nth=2 -f \'"..string.escape_shell(query).."\'"
--   local skOutput = string.trim(io.shell(skCommand))
--   if (#skOutput > 0) then
--     local skLines = string.split(skOutput, "\n")
--     local filteredItems = func.map(FuzzyChooser._skToChoice, std.ielems, skLines)
--     return table.sort(filteredItems, function (a, b) return a.score > b.score end)
--   end
--   return {}
-- end

-- function FuzzyChooser._skToChoice(sk)
--   local scoreAndChoice = string.split(sk, "\t")
--   local choiceIxAndText = string.split(scoreAndChoice[2], FuzzyChooser.delimiter)
--   return {
--     score = tonumber(scoreAndChoice[1]),
--     text = choiceIxAndText[2],
--     ix = tonumber(choiceIxAndText[1])
--   }
-- end

-- function tryGetAppName(fname)
--   local appSuffix = '.app'
--   if #fname < #appSuffix + 1 or fname:sub(-#appSuffix) ~= appSuffix then
--     return nil
--   end
--   return fname:sub(0, -#appSuffix - 1)
-- end

-- function listApps(path)
--   return func.map(
--     function (file)
--       if file ~= "." and file ~= ".." then
--         local abspath = path..'/'..file
--         local attr = lfs.attributes(abspath)
--         assert(type(attr) == "table")
--         local appName = tryGetAppName(file)
--         if attr.mode == "directory" and appName ~= nil then
--           return { name = appName, path = abspath }
--         end
--         return nil
--       end
--     end,
--     std.ielems,
--     lfs.dir(path)
--   )
-- end

-- function listApps2()
--   local appSearchPaths = {
--     "/Applications",
--     "/System/Applications",
--     "~/Applications",
--     -- "/Developer/Applications",
--     -- "/Applications/Xcode.app/Contents/Applications",
--     "/System/Library/PreferencePanes",
--     "/Library/PreferencePanes",
--     "~/Library/PreferencePanes",
--     "/System/Library/CoreServices/Applications",
--     "/System/Library/CoreServices/",
--     -- "/usr/local/Cellar",
--     -- "/Library/Scripts",
--     -- "~/Library/Scripts"
--   }
-- end
