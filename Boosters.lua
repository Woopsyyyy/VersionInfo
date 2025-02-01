-- Factory items
local factoryItems = {
    Metal = 267176888,
    Wood = 2090874750,
    Plastic = -1270634091
}

-- Booster codes
local boosters = {
    Jp = {1692935226, 1692935227, 1692935228},
    Thief = {1147903624, 1147903625},
    Dud = {91798751, 91798752, 91798753},
    Pump = {1965976282, 1965976283, 1965976284},
    Vamp = {1736317036, 1736317037, 1736317038},
    Umbrella = {1587235432, 1587235433, 1587235434},
    Freeze = {924894801, 924894802, 924894803}
}

-- Show main menu
function mainMenu()
    local options = {"Jp", "Thief", "Dud", "Pump", "Vamp", "Umbrella", "Freeze"}
    local choice = gg.choice(options, nil, "Select a Booster:")
    
    if choice == nil then
        return
    end
    
    local selectedBooster = options[choice]
    boosterMenu(selectedBooster)
end

-- Show booster menu (I, II, III)
function boosterMenu(booster)
    local levels = {}
    
    -- Get available levels for the selected booster
    if booster == "Jp" or booster == "Dud" or booster == "Pump" or booster == "Vamp" or booster == "Umbrella" or booster == "Freeze" then
        levels = {"I", "II", "III"}
    elseif booster == "Thief" then
        levels = {"I", "II"}
    end
    
    local choice = gg.choice(levels, nil, "Select Booster Level:")
    
    if choice == nil then
        return
    end
    
    local selectedLevel = levels[choice]
    factoryMenu(booster, selectedLevel)
end

-- Show factory items menu
function factoryMenu(booster, level)
    local items = {}
    for item, code in pairs(factoryItems) do
        table.insert(items, item)
    end
    
    local choice = gg.choice(items, nil, "Select Factory Item to Apply to " .. booster .. " Level " .. level)
    
    if choice == nil then
        return
    end
    
    local selectedItem = items[choice]
    applyBooster(booster, level, selectedItem)
end

-- Apply the selected factory item to the booster level
function applyBooster(booster, level, item)
    local itemCode = factoryItems[item]
    
    -- Map "I", "II", "III" to 1, 2, 3
    local levelIndex = {I = 1, II = 2, III = 3}
    local boosterCodeIndex = levelIndex[level]  -- This should be 1, 2, or 3
    
    local boosterCode = boosters[booster][boosterCodeIndex]
    
    if boosterCode == nil then
        gg.toast("Invalid booster level selected")
        return
    end
    
    -- Search for the item and apply the booster code
    gg.searchNumber(itemCode, gg.TYPE_DWORD)
    local results = gg.getResults(10)
    for i, result in ipairs(results) do
        result.value = boosterCode
    end
    gg.editAll(boosterCode, gg.TYPE_DWORD)
    gg.toast("Applied " .. item .. " to " .. booster .. " Level " .. level)
end

-- Start the script
mainMenu()
