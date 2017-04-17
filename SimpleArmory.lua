--  SimpleArmory Helper Addon (by Marko)
--
SimpleArmory = {}
SLASH_SIMPLEARMORY1 = '/sa';
SLASH_RELOADUI1 = "/rl" -- elvui provides this, but I load only this addon while developing and its nice to have

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
    SlashCmdList["RELOADUI"] = ReloadUI;
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
            local creatureDisplayID, descriptionText, sourceText, isSelfMount, mountType = C_MountJournal.GetMountInfoExtraByID(id)
            local mountObj = {}

            mountObj["name"] = creatureName;
            mountObj["spellID"] = spellID;
            mountObj["icon"] = icon;
            mountObj["active"] = active;
            mountObj["isUsable"] = isUsable;
            mountObj["sourceType"] = sourceType;
            mountObj["isFavorite"] = isFavorite;
            mountObj["isFactionSpecific"] = isFactionSpecific;
            mountObj["faction"] = faction;
            mountObj["hideOnChar"] = hideOnChar;
            mountObj["isCollected"] = isCollected;
            mountObj["mountID"] = mountID;
            mountObj["creatureDisplayID"] = creatureDisplayID;
            mountObj["descriptionText"] = descriptionText;
            mountObj["sourceText"] = sourceText;
            mountObj["isSelfMount"] = isSelfMount;
            mountObj["mountType"] = mountType;

            mountList[i] = toJSON(mountObj);
    end --for

    SimpleArmory.MountList = "[" .. table.concat(mountList,",") .. "]";
end

function printToChat(msg)
  DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."SA: |r"..tostring(msg))
end 