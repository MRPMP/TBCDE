local function CreateDisenchantByName()
    local macroName = "DE_Names"
    -- Initialize with the Disenchant command
    local body = "/cast Disenchant\n"
    local MAX_LENGTH = 255

    print("|cFF00FFFF[MacroTool]:|r Building macro using item names...")

    for b = 0, NUM_BAG_SLOTS do
        local numSlots = C_Container.GetContainerNumSlots(b)
        for s = 1, numSlots do
            local i = C_Container.GetContainerItemInfo(b, s)

            if i and i.hyperlink then
                local n = GetItemInfo(i.hyperlink)

                if n then
                    -- The macro format: /use Item Name
                    local nextLine = "/use " .. n .. "\n"

                    -- Check if adding this specific name fits in the 255 limit
                    if (#body + #nextLine) <= MAX_LENGTH then
                        body = body .. nextLine
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
        print("|cFF00FF00[MacroTool]:|r Updated 'DE_Names' with item names.")
    else
        CreateMacro(macroName, "INV_MISC_QUESTIONMARK", body, 1)
        print("|cFF00FF00[MacroTool]:|r Created 'DE_Names' with item names.")
    end
end

SLASH_DENAMES1 = "/makede"
SlashCmdList["DENAMES"] = CreateDisenchantByName