local DruidTalentGuide = CreateFrame("Frame", "DruidTalentGuide", UIParent)
DruidTalentGuide:SetWidth(220)  
DruidTalentGuide:SetHeight(160)
DruidTalentGuide:SetPoint("CENTER", UIParent, "CENTER", 0, 0)
DruidTalentGuide:SetBackdrop({
    bgFile = "Interface/Tooltips/UI-Tooltip-Background",  
    edgeFile = "Interface/Tooltips/UI-Tooltip-Border",    
    tile = true,                                         
    tileSize = 16,                                     
    edgeSize = 16,                                       
    insets = { left = 4, right = 4, top = 4, bottom = 4 } 
})
DruidTalentGuide:SetBackdropColor(0, 0, 0, 0.8)
DruidTalentGuide:SetBackdropBorderColor(1, 1, 1, 1)  
DruidTalentGuide:EnableMouse(true)
DruidTalentGuide:SetMovable(true)
DruidTalentGuide:RegisterForDrag("LeftButton")
DruidTalentGuide:SetScript("OnDragStart", function() DruidTalentGuide:StartMoving() end)
DruidTalentGuide:SetScript("OnDragStop", function() DruidTalentGuide:StopMovingOrSizing() end)

-- Sample talent order (Level -> {Talent Name, Icon Path})
local talentOrder = {
    [10] = {"Nature's Grasp", "Interface\\Icons\\spell_nature_natureswrath"},
    [11] = {"Ferocity Rank 1", "Interface\\Icons\\ability_hunter_pet_hyena"},
    [12] = {"Ferocity Rank 2", "Interface\\Icons\\ability_hunter_pet_hyena"},
    [13] = {"Ferocity Rank 3", "Interface\\Icons\\ability_hunter_pet_hyena"},
    [14] = {"Ferocity Rank 4", "Interface\\Icons\\ability_hunter_pet_hyena"},
    [15] = {"Ferocity Rank 5", "Interface\\Icons\\ability_hunter_pet_hyena"},
    [16] = {"Brutal Impact Rank 1", "Interface\\Icons\\ability_druid_bash"},
    [17] = {"Brutal Impact Rank 2", "Interface\\Icons\\ability_druid_bash"},
    [18] = {"Thick Hide Rank 1", "Interface\\Icons\\inv_misc_pelt_bear_03"},
    [19] = {"Thick Hide Rank 2", "Interface\\Icons\\inv_misc_pelt_bear_03"},
    [20] = {"Thick Hide Rank 3", "Interface\\Icons\\inv_misc_pelt_bear_03"},
    [21] = {"Feline Swiftness Rank 1", "Interface\\Icons\\spell_nature_spiritwolf"},
    [22] = {"Feline Swiftness Rank 2", "Interface\\Icons\\spell_nature_spiritwolf"},
    [23] = {"Feral Charge", "Interface\\Icons\\ability_hunter_pet_bear"},
    [24] = {"Sharpened Claws Rank 1", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [25] = {"Sharpened Claws Rank 2", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [26] = {"Sharpened Claws Rank 3", "Interface\\Icons\\inv_misc_monsterclaw_04"},
    [27] = {"Predatory Strikes Rank 1", "Interface\\Icons\\ability_hunter_pet_cat"},
    [28] = {"Predatory Strikes Rank 2", "Interface\\Icons\\ability_hunter_pet_cat"},
    [29] = {"Predatory Strikes Rank 3", "Interface\\Icons\\ability_hunter_pet_cat"},
    [30] = {"Blood Frenzy Rank 1", "Interface\\Icons\\ability_ghoulfrenzy"},
    [31] = {"Faerie Fire (Feral)", "Interface\\Icons\\spell_nature_faeriefire"},
    [32] = {"Blood Frenzy Rank 2", "Interface\\Icons\\ability_ghoulfrenzy"},
    [33] = {"Savage Fury Rank 1", "Interface\\Icons\\ability_druid_ravage"},
    [34] = {"Savage Fury Rank 2", "Interface\\Icons\\ability_druid_ravage"},
    [35] = {"Thick Hide Rank 4", "Interface\\Icons\\inv_misc_pelt_bear_03"},
    [36] = {"Heart of the Wild Rank 1", "Interface\\Icons\\spell_holy_blessingofagility"},
    [37] = {"Heart of the Wild Rank 2", "Interface\\Icons\\spell_holy_blessingofagility"},
    [38] = {"Heart of the Wild Rank 3", "Interface\\Icons\\spell_holy_blessingofagility"},
    [39] = {"Heart of the Wild Rank 4", "Interface\\Icons\\spell_holy_blessingofagility"},
    [40] = {"Heart of the Wild Rank 5", "Interface\\Icons\\spell_holy_blessingofagility"},
    [41] = {"Leader of the Pack", "Interface\\Icons\\spell_nature_unyeildingstamina"},
    [42] = {"Improved Nature's Grasp Rank 1", "Interface\\Icons\\spell_nature_natureswrath"},
    [43] = {"Improved Nature's Grasp Rank 2", "Interface\\Icons\\spell_nature_natureswrath"},
    [44] = {"Improved Nature's Grasp Rank 3", "Interface\\Icons\\spell_nature_natureswrath"},
    [45] = {"Improved Nature's Grasp Rank 4", "Interface\\Icons\\spell_nature_natureswrath"},
    [46] = {"Natural Weapons Rank 1", "Interface\\Icons\\inv_staff_01"},
    [47] = {"Natural Weapons Rank 2", "Interface\\Icons\\inv_staff_01"},
    [48] = {"Natural Weapons Rank 3", "Interface\\Icons\\inv_staff_01"},
    [49] = {"Natural Weapons Rank 4", "Interface\\Icons\\inv_staff_01"},
    [50] = {"Natural Weapons Rank 5", "Interface\\Icons\\inv_staff_01"},
    [51] = {"Omen of Clarity", "Interface\\Icons\\spell_nature_crystalball"},
    [52] = {"Natural Shapeshifter Rank 1", "Interface\\Icons\\spell_nature_wispsplode"},
    [53] = {"Natural Shapeshifter Rank 2", "Interface\\Icons\\spell_nature_wispsplode"},
    [54] = {"Natural Shapeshifter Rank 3", "Interface\\Icons\\spell_nature_wispsplode"},
    [55] = {"Furor Rank 1", "Interface\\Icons\\spell_holy_blessingofstamina"},
    [56] = {"Furor Rank 2", "Interface\\Icons\\spell_holy_blessingofstamina"},
    [57] = {"Furor Rank 3", "Interface\\Icons\\spell_holy_blessingofstamina"},
    [58] = {"Furor Rank 4", "Interface\\Icons\\spell_holy_blessingofstamina"},
    [59] = {"Furor Rank 5", "Interface\\Icons\\spell_holy_blessingofstamina"},
    [60] = {"Thick Hide Rank 5", "Interface\\Icons\\inv_misc_pelt_bear_03"}
}

local function UpdateTalentDisplay()
    local level = UnitLevel("player")
    
    for i = 1, 3 do
        local talentLevel = level + (i - 1)
        local talentInfo = talentOrder[talentLevel]
        
        if talentInfo then
            local talentName, iconPath = unpack(talentInfo)
            
            if not DruidTalentGuide["Talent" .. i] then
                local talentFrame = CreateFrame("Frame", nil, DruidTalentGuide)
                talentFrame:SetWidth(190)
                talentFrame:SetHeight(30)
                talentFrame:SetPoint("TOP", DruidTalentGuide, "TOP", 0, -((i - 1) * 35))

                local levelText = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                levelText:SetPoint("LEFT", talentFrame, "LEFT", 0, -20)
                levelText:SetText("lvl " .. talentLevel .. " :")

                local icon = talentFrame:CreateTexture(nil, "ARTWORK")
                icon:SetWidth(30)
                icon:SetHeight(30)
                icon:SetPoint("LEFT", levelText, "RIGHT", 5, -5)
                icon:SetTexture(iconPath)

                local text = talentFrame:CreateFontString(nil, "OVERLAY", "GameFontNormal")
                text:SetPoint("LEFT", icon, "RIGHT", 8, 0)  
                text:SetWidth(120)  
                text:SetJustifyH("LEFT")
                text:SetText(talentName)

                talentFrame.levelText = levelText
                talentFrame.icon = icon
                talentFrame.text = text
                DruidTalentGuide["Talent" .. i] = talentFrame
            else
                local talentFrame = DruidTalentGuide["Talent" .. i]
                talentFrame.levelText:SetText("lvl " .. talentLevel .. " :")
                talentFrame.icon:SetTexture(iconPath)
                talentFrame.text:SetText(talentName)
            end
        end
    end
end

-- Event handling for level-up updates
DruidTalentGuide:RegisterEvent("PLAYER_LEVEL_UP")
DruidTalentGuide:RegisterEvent("PLAYER_ENTERING_WORLD")
DruidTalentGuide:SetScript("OnEvent", function(self, event, ...) 
    UpdateTalentDisplay()
    if event == "PLAYER_LEVEL_UP" or event == "PLAYER_ENTERING_WORLD" then
        UpdateTalentDisplay()
    end 
end)

-- Initial update
UpdateTalentDisplay()
