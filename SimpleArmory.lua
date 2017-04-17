--  SimpleArmory Helper Addon (by Marko)
--
SimpleArmory = {}
SLASH_SIMPLEARMORY1 = '/sa';

local toJSON = newencoder(); -- initialize json encoder
local frame = CreateFrame("Frame")
SimpleArmory.Frame = frame
frame:Hide()

local function OnSlashCommand()
    GetAllMounts();
end 

local function OnLoad()
    -- hookup slash commands
    SlashCmdList["SIMPLEARMORY"] = OnSlashCommand;
end

local function OnEvent(self, event, ...)
    if (event == "CHAT_MSG_ADDON") then
    elseif (event == "PLAYERREAGENTBANKSLOTS_CHANGED") then
    end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function(self, event, arg1)
    if (arg1 == "SimpleArmory") then
        frame:UnregisterEvent("ADDON_LOADED")
        OnLoad();

        -- hook up all other events
        frame:SetScript("OnEvent", OnEvent)
        frame:RegisterEvent("CHAT_MSG_ADDON")
    end
end)

function GetAllMounts()
    printToChat("Getting all mounts from game...");

    local mountList = {};
    local mountIDs = C_MountJournal.GetMountIDs();
    for i, id in pairs(mountIDs) do
            local creatureName, spellID, icon, active, isUsable, sourceType, isFavorite, isFactionSpecific, faction, hideOnChar, isCollected, mountID = C_MountJournal.GetMountInfoByID(id)
            local mountObj = {}

            mountObj["name"] = creatureName;
            mountObj["spellID"] = spellID;

            mountList[i] = toJSON(mountObj);
    end --for

    SimpleArmory.MountList = "[" .. table.concat(mountList,",") .. "]";
end

function printToChat(msg)
  DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."SA: |r"..tostring(msg))
end 