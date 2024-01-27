PLUGIN.name = "Character Limit"
PLUGIN.description = ""
PLUGIN.author = "Unknown"

local overrideCharLimit = {
  ["founder"] = 10,
  ["superadmin"] = 10,
  ["user"] = 3,
  ["user"] = 2,
}

hook.Add("GetMaxPlayerCharacter", "returnRankCharLimit", function(ply)
    local rank = ply:GetNWString("usergroup", nil)
    local defchars = ix.config.Get("maxCharacters", 1)

    if not rank then return defchars end
  for group,slots in pairs(overrideCharLimit) do
    if rank == group then
      return slots
    end
  end

  return defchars
end)