local translations = {
    ['enUS'] = {
        ["OddCrystal"] = "Odd Crystal",
        ["Morgan Pestle"] = "Morgan Pestle",
        ["Vision of Orgrimmar"] = "Vision of Orgrimmar",
        ["Vision of Stormwind"] = "Vision of Stormwind",
        ["Chamber of Heart"] = "Chamber of Heart",
        ["The Coreway"] = "The Coreway",
        ["Black Empire Cache"] = "Black Empire Cache"
    }
}


CVT['transl'] = translations[GetLocale()] or translations['enUS']