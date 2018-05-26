--  SimpleArmory Helper Addon (by Marko)
--
local toJSON = newencoder(); -- initialize json encoder
local _, SimpleArmory = ...

SimpleArmory = LibStub("AceAddon-3.0"):NewAddon(
    SimpleArmory, "SimpleArmory", "AceConsole-3.0",
    "AceEvent-3.0"
)

function SimpleArmory:OnInitialize()
    SimpleArmory:RegisterChatCommand('sa', 'ParseCommand')
    SimpleArmory:RegisterChatCommand('simplearmory', 'ParseCommand')
    SimpleArmory:RegisterChatCommand('rl', 'ReloadUI') -- elvui provides this, but I load only this addon while developing and its nice to have
end

function SimpleArmory:OnDisable()
end

function SimpleArmory:ReloadUI()
    ReloadUI()
end

function SimpleArmory:ParseCommand(args)
    local command, commandArg1 = self:GetArgs(args, 2)
    if not command then
        SimpleArmory:PrintUsage()
    else 
        if command == "toys" then
            SimpleArmory:ExportToys()
        else
            SimpleArmory:PrintUsage()
        end 
    end
    
end

function SimpleArmory:PrintUsage()
    SimpleArmory:Print("USAGE")
end 

function SimpleArmory:ExportToys()
    local output = SimpleArmory:GetAllToys()

    SATECopyFrame:Show()
    SATECopyFrameScroll:Show()
    SATECopyFrameScrollText:Show()
    SATECopyFrameScrollText:SetText(output)
    SATECopyFrameScrollText:HighlightText()
end

function SimpleArmory:GetAllMounts()
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
            --mountObj["descriptionText"] = descriptionText;
            --mountObj["sourceText"] = sourceText;
            mountObj["isSelfMount"] = isSelfMount;
            mountObj["mountType"] = mountType;

            mountList[i] = toJSON(mountObj);
    end --for

    SimpleArmory.MountList = "[" .. table.concat(mountList,",") .. "]";
end

function SimpleArmory:GetAllPets()
    printToChat("Getting all pets from game...");

    local petList = {};
    local total, owned = C_PetJournal.GetNumPets();
    for i = 1,total do
        --local petID, speciesID, isOwned, _, _, _, _, _, _, _, creatureID = C_PetJournal.GetPetInfoByIndex(i)
        local petID, speciesID, owned, customName, level, favorite, isRevoked, speciesName, icon, petType, companionID, tooltip, description, isWild, canBattle, isTradeable, isUnique, obtainable = C_PetJournal.GetPetInfoByIndex(i);
        
        printToChat("petid: " .. petID .. " sid: " .. speciesID .. " create:" .. companionID);
    end
    printToChat("total: " .. total);
end

function SimpleArmory:GetAllToys()
    return "TEST5"
end

function printToChat(msg)
  DEFAULT_CHAT_FRAME:AddMessage(GREEN_FONT_COLOR_CODE.."SA: |r"..tostring(msg))
end 