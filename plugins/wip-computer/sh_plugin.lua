
PLUGIN.name = "Computer"
PLUGIN.author = "Bilwin"
PLUGIN.description = "..."
PLUGIN.schema = "HL2 RP"

if (CLIENT) then
    surface.CreateFont("ixComputer.ButtonsFont", {
        font = "Roboto Bold",
        extended = true,
        size = 25,
        weight = 500,
        antialias = true
    })
end

local ix = ix or {}
ix.Computer = ix.Computer or {}
ix.Computer.Notes = {
    ["Гражданский Кодекс"] = [[
        а
    ]]
}
