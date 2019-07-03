local game = require "SetGameInHere"

if game == 0 or game == nil then 
    vba.print("Please read the readme file and set the game in \"SetGameInHere.lua\".")
else
    local bit = require("bit")

    -- Data
    local addresses = {0x020244EC, 0x02024284, 0x02024284}
    local partyAddress =  addresses[game]

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

    local darkRisingDB = {"BULBASAUR", "IVYSAUR", "VENUSAUR", "CHARMANDER", "CHARMELEON", "CHARIZARD", "SQUIRTLE", "WARTORTLE", "BLASTOISE", "CATERPIE", "METAPOD", "BUTTERFREE", "VENIPEDE", "WHIRLIPEDE", "SCOLIPEDE", "PIDGEY", "PIDGEOTTO", "PIDGEOT", "BLITZLE", "ZEBSTRIKA", "RUFFLET", "BRAVIARY", "EKANS", "ARBOK", "PIKACHU", "RAICHU", "ZORUA", "ZOROARK", "SOLOSIS", "DUOSION", "REUNICLUS", "LITWICK", "LAMPENT", "CHANDELURE", "SNOVER", "ABOMASNOW", "VULPIX", "NINETALES", "YAMASK", "COFAGRIGUS", "ZUBAT", "GOLBAT", "GOTHITA", "GOTHORITA", "GOTHITELLE", "PATRAT", "WATCHOG", "MINCCINO", "CINCINNO", "DRILBUR", "EXCADRILL", "MIENFOO", "MIENSHAO", "HIPPOPOTAS", "HIPPOWDON", "PAWNIARD", "BISHARP", "GROWLITHE", "ARCANINE", "POLIWAG", "POLIWHIRL", "POLIWRATH", "ABRA", "KADABRA", "ALAKAZAM", "MACHOP", "MACHOKE", "MACHAMP", "STARLY", "STARAVIA", "STARAPTOR", "TENTACOOL", "TENTACRUEL", "GEODUDE", "GRAVELER", "GOLEM", "PONYTA", "RAPIDASH", "SLOWPOKE", "SLOWBRO", "MAGNEMITE", "MAGNETON", "AXEW", "FRAXURE", "HAXORUS", "DWEBBLE", "CRUSTLE", "CROAGUNK", "TOXICROAK", "SHELLDER", "CLOYSTER", "GASTLY", "HAUNTER", "GENGAR", "ONIX", "BRONZOR", "BRONZONG", "SCRAGGY", "SCRAFTY", "RIOLU", "LUCARIO", "EXEGGCUTE", "EXEGGUTOR", "DARUMAKA", "DARMANITAN", "HITMONLEE", "HITMONCHAN", "LICKITUNG", "KOFFING", "WEEZING", "RHYHORN", "RHYDON", "CHANSEY", "TANGELA", "KANGASKHAN", "HORSEA", "SEADRA", "DUCKLETT", "SWANNA", "STARYU", "STARMIE", "SPIRITOMB", "SCYTHER", "JYNX", "ELECTABUZZ", "MAGMAR", "PINSIR", "TAUROS", "MAGIKARP", "GYARADOS", "LAPRAS", "DITTO", "EEVEE", "VAPOREON", "JOLTEON", "FLAREON", "PORYGON", "TIRTOUGA", "CARRACOSTA", "ARCHEN", "ARCHEOPS", "AERODACTYL", "SNORLAX", "ALOMOMOLA", "DURANT", "ZEN MODE", "DRATINI", "DRAGONAIR", "DRAGONITE", "AUDINO", "MEW", "CHIKORITA", "BAYLEEF", "MEGANIUM", "CYNDAQUIL", "QUILAVA", "TYPHLOSION", "TOTODILE", "CROCONAW", "FERALIGATR", "MUNNA", "MUSHARNA", "BUIZEL", "FLOATZEL", "JOLTIK", "GALVANTULA", "SPINARAK", "ARIADOS", "CROBAT", "CHINCHOU", "LANTURN", "PICHU", "SHELLOS", "GASTRODON", "TOGEPI", "TOGETIC", "DRIFLOON", "DRIFTBLIM", "TIMBURR", "GURDURR", "CONKELDURR", "EMOLGA", "BOUFFALANT", "THROH", "SAWK", "POLITOED", "ROGGENROLA", "BOLDORE", "GIGALITH", "AIPOM", "COTTONEE", "WHIMSICOTT", "YANMA", "FRILLISH", "JELLICENT", "ESPEON", "UMBREON", "MURKROW", "SLOWKING", "MISDREAVUS", "UNOWN", "WOBBUFFET", "GALLADE", "PINECO", "FORRETRESS", "RHYPERIOR", "GLIGAR", "STEELIX", "SKORUPI", "DRAPION", "GLISCOR", "SCIZOR", "TANGROWTH", "HERACROSS", "SNEASEL", "TEDDIURSA", "URSARING", "CUBCHOO", "BEARTIC", "SWINUB", "PILOSWINE", "GIBLE", "GABITE", "GARCHOMP", "DELIBIRD", "TOGEKISS", "SKARMORY", "HOUNDOUR", "HOUNDOOM", "KINGDRA", "PHANPY", "DONPHAN", "PORYGON2", "MUNCHLAX", "DRUDDIGON", "TYROGUE", "HITMONTOP", "SMOOCHUM", "ELEKID", "MAGBY", "MILTANK", "BLISSEY", "RAIKOU", "ENTEI", "SUICUNE", "LARVITAR", "PUPITAR", "TYRANITAR", "LUGIA", "HO-OH", "CELEBI", "HEATMOR", "SEISMITOAD", "SIGILYPH", "CRYOGONAL", "KLINKLANG", "RESHIRAM", "ZEKROM", "MELOETTA", "AMPHAROS", "VANILLUXE", "LANDORUS-T", "COBALION", "PIKACHU!!!", "GIRATINA", "DIALGA", "PALKIA", "REGIGIGAS", "CRESSELIA", "MEWTWO", "KYUREM W", "KYUREM B", "KYUREM", "CONARP", "BLAZARD", "GENESECT", "TREECKO", "GROVYLE", "SCEPTILE", "TORCHIC", "COMBUSKEN", "BLAZIKEN", "MUDKIP", "MARSHTOMP", "SWAMPERT", "TURTWIG", "GROTLE", "TORTERRA", "TEPIG", "PIGNITE", "EMBOAR", "SNIVY", "SERVINE", "SERPERIOR", "LOTAD", "LOMBRE", "LUDICOLO", "SEEDOT", "NUZLEAF", "SHIFTRY", "YANMEGA", "AMBIPOM", "SHEDINJA", "TAILLOW", "SWELLOW", "SHROOMISH", "BRELOOM", "TYNAMO", "EELEKTRIK", "EELEKTROSS", "PIPLUP", "PRINPULP", "EMPOLEON", "MAMOSWINE", "SANDILE", "KROKOROK", "KROOKODILE", "BALTOY", "CLAYDOL", "NOSEPASS", "TORKOAL", "SABLEYE", "OSHAWOTT", "DEWOTT", "SAMUROTT", "CORPHISH", "CRAWDAUNT", "FEEBAS", "MILOTIC", "CARVANHA", "SHARPEDO", "TRAPINCH", "VIBRAVA", "FLYGON", "KARRABLAST", "ESCAVALIER", "SHELMET", "ACCELLGOR", "ELECTIVIRE", "MAGMORTAR", "SPHEAL", "SEALEO", "WALREIN", "CACNEA", "CACTURNE", "SNORUNT", "GLALIE", "GLACEON", "LEAFEON", "HONCHKROW", "SPOINK", "GRUMPIG", "LARVESTA", "VOLCARONA", "ROSERADE", "PORYGON-Z", "MAGNEZONE", "SWABLU", "ALTARIA", "WYNAUT", "DUSKULL", "DUSCLOPS", "ROSELIA", "SLAKOTH", "VIGOROTH", "SLAKING", "CHIMCHAR", "MONFERNO", "INFERNAPE", "GOLETT", "GOLURK", "DUSKNOIR", "DEINO", "ZWEILOUS", "HYDREIGON", "ABSOL", "FERROSEED", "FERROTHORN", "FROSLASS", "WEAVILE", "MISMAGIUS", "ARON", "LAIRON", "AGGRON", "CASTFORM", "LICKILICKY", "PROBOPASS", "SHIELDON", "BASTIODON", "CRANIDOS", "RAMPARDOS", "RALTS", "KIRLIA", "GARDEVOIR", "BAGON", "SHELGON", "SALAMENCE", "BELDUM", "METANG", "METAGROSS", "TORNADUS", "THUNDURUS", "LANDORUS", "KYOGRE", "GROUDON", "RAYQUAZA", "VICTINI", "KELDEO", "JIRACHI", "DEOXYS", "SHAYMIN"}

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
    if game == 3 then pkmNameDB = darkRisingDB end

    local prevParty = {0, 0, 0, 0, 0, 0}
    local party = {0, 0, 0, 0, 0, 0}
    local originalParty = {0, 0, 0, 0, 0, 0}

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
                if speci > 251 and not game == 3 then 
                    speci = speci - 25
                end

                party[i] = speci
            else
                party[i] = 0
            end     
        end
        if originalParty[1] == 0 then copyArray(party, originalParty) end
    end

    local firstRead = true
    local function didPartyChange()
        if firstRead then
            return {true, true, true, true, true, true, true}
        end
        if party[1] == 0 then return {true} end
        
        local r = {false, false, false, false, false, false, false}
        
        for i = 1, 6, 1 do
            if party[i] ~= originalParty[i] then
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

    local changeTimer = 0
    local function update()
        readParty()

        local changeMap = didPartyChange()
        if changeMap[1] then
            changeTimer = changeTimer + 1
        else
            changeTimer = 0
        end

        if changeTimer == 120 or firstRead then
            copyArray(party, originalParty)
            for i = 1, 6, 1 do
                if changeMap[i + 1] then
                    local id = originalParty[i]
                    local pngPath
                    if id == 0x19C then
                        pngPath = "./sprites/egg.png"
                    elseif id == 0 then
                        pngPath = "./sprites/0.png"
                    else
                        pngPath = getPNGPath(id)
                    end

                    local newPNG = io.open(pngPath, "rb")
                    if newPNG == nil then
                        vba.print(getPNGPath(originalParty[i]) .. " is missing.")
                    end
                        
                    local newData = newPNG:read("*a")
                    newPNG:flush()
                    
                    local oldPNG = io.open("./party/p" .. tostring(i) .. ".png", "wb")
                    oldPNG:write(newData)
                    oldPNG:flush()

                end
            end
            changeTimer = 0
            firstRead = false
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
    vba.print("g3pd 1.1 loaded <3")
end