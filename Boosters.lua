local gg = gg

-- Define mapping addresses for items
local addresses = {
    factoryItems = {
        metal = 267176888,   -- Factory item Metal
        wood = 2090874750,   -- Factory item Wood
        plastic = -1270634091 -- Factory item Plastic
    },
    magnetism = {
        anvil = 253271711,  -- Anvil address
        fireHydrant = 860715237, -- Fire hydrant address
        binoculars = 1560176023 -- Binoculars address
    },
    mellowBellow = {
        megaphone = -1540742631, -- Megaphone address
        shuriken = -1962827238,  -- Shuriken address
        tang = 352219700       -- Tang address
    },
    shieldBuster = {
        gasoline = -916988905,  -- Gasoline address
        medkit = 226338627     -- Medkit address
    },
    doomsquack = {
        duck = 471968558       -- Duck address
    }
}

-- Function to show the main menu
function showMainMenu()
    local mainMenu = gg.choice({
        "Magnetism", 
        "Mellow Bellow", 
        "Shield Buster", 
        "Doomsquack"
    }, nil, "Select category\nPress Back to exit")

    if mainMenu == 1 then
        showMagnetismMenu()
    elseif mainMenu == 2 then
        showMellowBellowMenu()
    elseif mainMenu == 3 then
        showShieldBusterMenu()
    elseif mainMenu == 4 then
        showDoomsquackMenu() 
    end
end

-- Function to show the Magnetism menu
function showMagnetismMenu()
    local magnetismItems = gg.choice({
        "Anvil", 
        "Fire hydrant", 
        "Binoculars", 
        "Back"
    }, nil, "Select Magnetism item")

    if magnetismItems == nil then return end

    if magnetismItems == 4 then
        showMainMenu()  -- Go back to main menu
        return
    end

    if magnetismItems == 1 then
        showItemSelectionMenu("Anvil", "magnetism")
    elseif magnetismItems == 2 then
        showItemSelectionMenu("Fire hydrant", "magnetism")
    elseif magnetismItems == 3 then
        showItemSelectionMenu("Binoculars", "magnetism")
    end
end

-- Function to show the Mellow Bellow menu
function showMellowBellowMenu()
    local mellowBellowItems = gg.choice({
        "Megaphone", 
        "Shuriken", 
        "Tang", 
        "Back"
    }, nil, "Select Mellow Bellow item")

    if mellowBellowItems == nil then return end

    if mellowBellowItems == 4 then
        showMainMenu()  -- Go back to main menu
        return
    end

    if mellowBellowItems == 1 then
        showItemSelectionMenu("Megaphone", "mellowBellow")
    elseif mellowBellowItems == 2 then
        showItemSelectionMenu("Shuriken", "mellowBellow")
    elseif mellowBellowItems == 3 then
        showItemSelectionMenu("Tang", "mellowBellow")
    end
end

-- Function to show the Shield Buster menu
function showShieldBusterMenu()
    local shieldBusterItems = gg.choice({
        "Gasoline", 
        "Medkit", 
        "Back"
    }, nil, "Select Shield Buster item")

    if shieldBusterItems == nil then return end

    if shieldBusterItems == 3 then
        showMainMenu()  -- Go back to main menu
        return
    end

    if shieldBusterItems == 1 then
        showItemSelectionMenu("Gasoline", "shieldBuster")
    elseif shieldBusterItems == 2 then
        showItemSelectionMenu("Medkit", "shieldBuster")
    end
end

-- Function to show the Doomsquack menu
function showDoomsquackMenu()
    local doomsquackItems = gg.choice({
        "Duck", 
        "Back"
    }, nil, "Select Doomsquack item")

    if doomsquackItems == nil then return end

    if doomsquackItems == 2 then
        showMainMenu()  -- Go back to main menu
        return
    end

    if doomsquackItems == 1 then
        showItemSelectionMenu("Duck", "doomsquack")
    end
end

-- Function to show item selection menu for Metal, Wood, or Plastic
function showItemSelectionMenu(selectedItem, category)
    local factoryItems = gg.choice({
        "Metal", 
        "Wood", 
        "Plastic", 
        "Back"
    }, nil, "Select the factory item to modify\nPress Back to go back")

    if factoryItems == nil then return end

    if factoryItems == 4 then
        if category == "magnetism" then showMagnetismMenu() 
        elseif category == "mellowBellow" then showMellowBellowMenu() 
        elseif category == "shieldBuster" then showShieldBusterMenu() 
        elseif category == "doomsquack" then showDoomsquackMenu() end
        return
    end

    local factoryItem
    if factoryItems == 1 then factoryItem = "metal"
    elseif factoryItems == 2 then factoryItem = "wood"
    elseif factoryItems == 3 then factoryItem = "plastic" end

    modifyItem(selectedItem, factoryItem, category)
end

-- Function to modify the selected item
function modifyItem(warItem, factoryItem, category)
    local value
    if category == "magnetism" then
        if warItem == "Anvil" then value = addresses.magnetism.anvil
        elseif warItem == "Fire hydrant" then value = addresses.magnetism.fireHydrant
        elseif warItem == "Binoculars" then value = addresses.magnetism.binoculars
        end
    elseif category == "mellowBellow" then
        if warItem == "Megaphone" then value = addresses.mellowBellow.megaphone
        elseif warItem == "Shuriken" then value = addresses.mellowBellow.shuriken
        elseif warItem == "Tang" then value = addresses.mellowBellow.tang
        end
    elseif category == "shieldBuster" then
        if warItem == "Gasoline" then value = addresses.shieldBuster.gasoline
        elseif warItem == "Medkit" then value = addresses.shieldBuster.medkit
        end
    elseif category == "doomsquack" then
        if warItem == "Duck" then value = addresses.doomsquack.duck
        end
    end

    local factoryItemValue = addresses.factoryItems[factoryItem]

    -- Modify the selected factory item to the selected war item
    gg.searchNumber(factoryItemValue, gg.TYPE_DWORD)
    local results = gg.getResults(100)
    if #results > 0 then
        for i, v in ipairs(results) do
            v.value = value
        end
        gg.setValues(results)
        gg.toast(factoryItem:gsub("^%l", string.upper) .. " turned into " .. warItem .. "\nRestart your game to see the result")
    else
        gg.toast("Value not found!")
    end
end

showMainMenu()
