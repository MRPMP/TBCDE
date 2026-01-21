local function CreateDisenchantByID()
    local macroName = "DE_IDs"
    -- Initialize with the Disenchant command
    local body = "/cast Disenchant\n"
    local MAX_LENGTH = 255

    print("|cFF00FFFF[MacroTool]:|r Building macro using item IDs...")

    -- Use a table to track IDs we've already added to avoid duplicates
    local addedItems = {}

    for b = 0, NUM_BAG_SLOTS do
        local numSlots = C_Container.GetContainerNumSlots(b)
        for s = 1, numSlots do
            local itemInfo = C_Container.GetContainerItemInfo(b, s)

            if itemInfo and itemInfo.itemID then
                local id = itemInfo.itemID

                -- Only add if it's a unique ID and not already in the macro
                if not addedItems[id] then
                    -- The macro format: /use item:ID
                    local nextLine = "/use item:" .. id .. "\n"

                    -- Check if adding this fits in the 255 limit
                    if (#body + #nextLine) <= MAX_LENGTH then
                        body = body .. nextLine
                        addedItems[id] = true
                    else
                        -- Stop adding once we hit the character limit
                        break
                    end
                end
            end
        end
    end

    local macroIndex = GetMacroIndexByName(macroName)
    if macroIndex > 0 then
        EditMacro(macroIndex, macroName, "INV_MISC_QUESTIONMARK", body)
        print("|cFF00FF00[MacroTool]:|r Updated '" .. macroName .. "' with item IDs.")
    else
        CreateMacro(macroName, "INV_MISC_QUESTIONMARK", body, 1)
        print("|cFF00FF00[MacroTool]:|r Created '" .. macroName .. "' with item IDs.")
    end
end

SLASH_DEIDS1 = "/makede"
SlashCmdList["DEIDS"] = CreateDisenchantByID