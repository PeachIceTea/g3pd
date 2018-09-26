-- Copyright 2018 Jonas Thiem

local bit = require("bit")

-- Data
local partyAddress = 0x020244EC
local numberedSprites

local numberPNG = io.open("./sprites/1.png", "rb+")
if numberPNG ~= nil then
    vba.print("Using numbered sprites.")
    numberedSprites = true
    numberPNG:flush()
else
    vba.print("Using named sprites.")
    numberedSprites = false
end

local pkmNameDB = {"Bulbasaur", "Ivysaur", "Venusaur", "Charmander", "Charmeleon", "Charizard",
    "Squirtle", "Wartortle", "Blastoise", "Caterpie", "Metapod", "Butterfree",
    "Weedle", "Kakuna", "Beedrill", "Pidgey", "Pidgeotto", "Pidgeot", "Rattata", "Raticate",
    "Spearow", "Fearow", "Ekans", "Arbok", "Pikachu", "Raichu", "Sandshrew", "Sandslash",
    "NidoranF", "Nidorina", "Nidoqueen", "NidoranM", "Nidorino", "Nidoking",
    "Clefairy", "Clefable", "Vulpix", "Ninetales", "Jigglypuff", "Wigglytuff",
    "Zubat", "Golbat", "Oddish", "Gloom", "Vileplume", "Paras", "Parasect", "Venonat", "Venomoth",
    "Diglett", "Dugtrio", "Meowth", "Persian", "Psyduck", "Golduck", "Mankey", "Primeape",
    "Growlithe", "Arcanine", "Poliwag", "Poliwhirl", "Poliwrath", "Abra", "Kadabra", "Alakazam",
    "Machop", "Machoke", "Machamp", "Bellsprout", "Weepinbell", "Victreebel", "Tentacool", "Tentacruel",
    "Geodude", "Graveler", "Golem", "Ponyta", "Rapidash", "Slowpoke", "Slowbro",
    "Magnemite", "Magneton", "Farfetch'd", "Doduo", "Dodrio", "Seel", "Dewgong", "Grimer", "Muk",
    "Shellder", "Cloyster", "Gastly", "Haunter", "Gengar", "Onix", "Drowzee", "Hypno",
    "Krabby", "Kingler", "Voltorb", "Electrode", "Exeggcute", "Exeggutor", "Cubone", "Marowak",
    "Hitmonlee", "Hitmonchan", "Lickitung", "Koffing", "Weezing", "Rhyhorn", "Rhydon", "Chansey",
    "Tangela", "Kangaskhan", "Horsea", "Seadra", "Goldeen", "Seaking", "Staryu", "Starmie",
    "Mr. Mime", "Scyther", "Jynx", "Electabuzz", "Magmar", "Pinsir", "Tauros", "Magikarp", "Gyarados",
    "Lapras", "Ditto", "Eevee", "Vaporeon", "Jolteon", "Flareon", "Porygon", "Omanyte", "Omastar",
    "Kabuto", "Kabutops", "Aerodactyl", "Snorlax", "Articuno", "Zapdos", "Moltres",
    "Dratini", "Dragonair", "Dragonite", "Mewtwo", "Mew",
    
    "Chikorita", "Bayleef", "Meganium", "Cyndaquil", "Quilava", "Typhlosion",
    "Totodile", "Croconaw", "Feraligatr", "Sentret", "Furret", "Hoothoot", "Noctowl",
    "Ledyba", "Ledian", "Spinarak", "Ariados", "Crobat", "Chinchou", "Lanturn", "Pichu", "Cleffa",
    "Igglybuff", "Togepi", "Togetic", "Natu", "Xatu", "Mareep", "Flaaffy", "Ampharos", "Bellossom",
    "Marill", "Azumarill", "Sudowoodo", "Politoed", "Hoppip", "Skiploom", "Jumpluff", "Aipom",
    "Sunkern", "Sunflora", "Yanma", "Wooper", "Quagsire", "Espeon", "Umbreon", "Murkrow", "Slowking",
    "Misdreavus", "Unown", "Wobbuffet", "Girafarig", "Pineco", "Forretress", "Dunsparce", "Gligar",
    "Steelix", "Snubbull", "Granbull", "Qwilfish", "Scizor", "Shuckle", "Heracross", "Sneasel",
    "Teddiursa", "Ursaring", "Slugma", "Magcargo", "Swinub", "Piloswine", "Corsola", "Remoraid", "Octillery",
    "Delibird", "Mantine", "Skarmory", "Houndour", "Houndoom", "Kingdra", "Phanpy", "Donphan",
    "Porygon2", "Stantler", "Smeargle", "Tyrogue", "Hitmontop", "Smoochum", "Elekid", "Magby", "Miltank",
    "Blissey", "Raikou", "Entei", "Suicune", "Larvitar", "Pupitar", "Tyranitar", "Lugia", "Ho-Oh", "Celebi",

    "Treecko", "Grovyle", "Sceptile", "Torchic", "Combusken", "Blaziken", "Mudkip", "Marshtomp", "Swampert",
    "Poochyena", "Mightyena", "Zigzagoon", "Linoone", "Wurmple", "Silcoon", "Beautifly", "Cascoon", "Dustox",
    "Lotad", "Lombre", "Ludicolo", "Seedot", "Nuzleaf", "Shiftry", "Nincada", "Ninjask", "Shedinja", "Taillow", 
    "Swellow", "Shroomish", "Breloom", "Spinda", "Wingull", "Pelipper", "Surskit", "Masquerain", "Wailmer", 
    "Wailord", "Skitty", "Delcatty", "Kecleon", "Baltoy", "Claydol", "Nosepass", "Torkoal", "Sableye", "Barboach", 
    "Whiscash", "Luvdisc", "Corphish", "Crawdaunt", "Feebas", "Milotic", "Carvanha", "Sharpedo", "Trapinch", 
    "Vibrava", "Flygon", "Makuhita", "Hariyama", "Electrike", "Manectric", "Numel", "Camerupt", "Spheal", 
    "Sealeo", "Walrein", "Cacnea", "Cacturne", "Snorunt", "Glalie", "Lunatone", "Solrock", "Azurill", "Spoink", 
    "Grumpig", "Plusle", "Minun", "Mawile", "Meditite", "Medicham", "Swablu", "Altaria", "Wynaut", "Duskull", 
    "Dusclops", "Roselia", "Slakoth", "Vigoroth", "Slaking", "Gulpin", "Swalot", "Tropius", "Whismur", "Loudred", 
    "Exploud", "Clamperl", "Huntail", "Gorebyss", "Absol", "Shuppet", "Banette", "Seviper", "Zangoose", "Relicanth", 
    "Aron", "Lairon", "Aggron", "Castform", "Volbeat", "Illumise", "Lileep", "Cradily", "Anorith", "Armaldo", 
    "Ralts", "Kirlia", "Gardevoir", "Bagon", "Shelgon", "Salamence", "Beldum", "Metang", "Metagross", "Regirock", 
    "Regice", "Registeel", "Kyogre", "Groudon", "Rayquaza", "Latias", "Latios", "Jirachi", "Deoxys", "Chimecho"
}

local speciesLoc = {
    0,
    0,
    0,
    0,
    0,
    0, -- 5
    12,
    12,
    24,
    36,
    24,
    36, -- 11
    12,
    12,
    24,
    36,
    24,
    36, -- 17
    12,
    12,
    24,
    36,
    24,
    36
}

-- code

local prevParty = {0, 0, 0, 0, 0, 0}
local party = {0, 0, 0, 0, 0, 0}

local function getbits(a,b,d)
    return bit.rshift(a,b) % bit.lshift(1,d)
end

local function copyArray(a, b)
    for i, v in pairs(a) do
        b[i] = v
    end
end

local function readParty()
    copyArray(party, prevParty)
    for i = 1, 6, 1 do
        local address = partyAddress + (100 * (i - 1))

        local perso = memory.readdwordunsigned(address)
        if perso ~= 0 then
            local otid = memory.readdwordunsigned(address+4)
            local key = bit.bxor(perso, otid)   

            local loc = speciesLoc[(perso % 24) + 1]
            local speci = getbits(bit.bxor(memory.readdwordunsigned(address + 32 + loc), key), 0, 16)
            if speci > 251 then 
                speci = speci - 25
            end

            party[i] = speci
        end     
    end
end

local function didPartyChange()
    if party[1] == 0 then return {false} end
    
    local r = {false, false, false, false, false, false, false}
    
    for i = 1, 6, 1 do
        if prevParty[i] ~= party[i] then
            r[1] = true
            r[i + 1] = true 
        end
    end

    return r
end

local function getPNGPath(id)
    if numberedSprites then
        return "./sprites/" .. id .. ".png"
    else
        return "./sprites/" .. tostring(pkmNameDB[id]) .. ".png"
    end
end

local function update()
    readParty()

    local changeMap = didPartyChange()
    if changeMap[1] then
        for i = 1, 6, 1 do
            if changeMap[i + 1] then
                local id = party[i]
                if id <= 0x19c then
                    local pngPath
                    if id == 0x19C then
                        pngPath = "./sprites/egg.png"
                    else
                        pngPath = getPNGPath(id)
                    end
                    local newPNG = io.open(pngPath, "rb")
                    if newPNG == nil then
                        vba.print(getPNGPath(party[i]) .. " is missing.")
                    else
                        local newData = newPNG:read("*a")
                        newPNG:flush()
                        
                        local oldPNG = io.open("./party/p" .. tostring(i) .. ".png", "wb")
                        oldPNG:write(newData)
                        oldPNG:flush()
                    end
                end
            end
        end
    end
end

local function clearPartyDisplay()
    local newPNG = io.open("./sprites/0.png", "rb+")
    if newPNG == nil then vba.print("0.png is missing in the sprites folder.") end
    local newData = newPNG:read("*a")
    newPNG:flush()

    for i = 1, 6, 1 do
        local oldPNG = io.open("./party/p" .. tostring(i) .. ".png", "wb+")
        oldPNG:write(newData)
        oldPNG:flush()
    end
end

clearPartyDisplay()
gui.register(update)
vba.print("g3pd 1.0 loaded <3")