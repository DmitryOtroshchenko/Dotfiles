require("common")

local std = require("std")
local func = require("std.functional")

function chooseAudioOutputDevice()
    local defaultDeviceUid = hs.audiodevice.defaultOutputDevice():uid()
    local filteredDevices = func.filter(
        function (device)
            return device:name() ~= "ZoomAudioDevice"
        end,
        std.ielems,
        hs.audiodevice.allOutputDevices()
    )
    local choices =
        func.map(
            function (device)
                local flags = (device:uid() == defaultDeviceUid) and "*" or " "
                if device:muted() then
                    flags = flags .. " [M]"
                end
                return {
                    text = hs.styledtext.new(
                        flags .. " " .. device:name(),
                        {
                            font = {size = 18, name = "Source Code Pro"},
                            color = hs.drawing.color.definedCollections.hammerspoon.white
                        }
                    ),
                    uid = device:uid()
                }
            end,
            std.ielems,
            filteredDevices
        )
    local onChoice = function (choice)
        if choice == nil then return end
        hs.audiodevice.findDeviceByUID(choice["uid"]):setDefaultOutputDevice()
    end
    hs.chooser.new(onChoice):choices(choices):show()
end
