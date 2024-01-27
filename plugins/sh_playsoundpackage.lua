local PLUGIN = PLUGIN

PLUGIN.name = "PlaySound Package"
PLUGIN.author = "salt"
PLUGIN.description = "Adds commands to play global/local sounds from a file, a global URL stream, and an entity mounted local sound. Also adds a global stopsound."

if(SERVER)then
  util.AddNetworkString("SoundGlobal")
  util.AddNetworkString("SoundURL")

  function PLUGIN:GlobalSound(path)
      net.Start("SoundGlobal")
      net.WriteString(path)
      net.Broadcast()
  end

function PLUGIN:GlobalURL(path)
      net.Start("SoundURL")
      net.WriteString(path)
      net.Broadcast()
  end
end

if(CLIENT)then
  net.Receive("SoundURL", function()
        sound.PlayURL( net.ReadString(), "", function() end) --I'm not sure if i need 'mono' in the flag arg
  end)
  
  net.Receive("SoundGlobal", function()
        surface.PlaySound(net.ReadString())
  end)
end

ix.command.Add("playSoundLocal", {
       description = "Проиграть звук в локальной зоне.",
       adminOnly = true,
       arguments = {ix.type.string, bit.bor(ix.type.number, ix.type.optional)},
       OnRun = function (self, client, soundstring, range)
       		level = math.Clamp(range or 75, 60, 85)
            sound.Play(soundstring,client:GetPos(), level)
       end
})

ix.command.Add("attachSound", {
       description = "Проиграть звук, прикрепив его в энтити/персонажу. Звук будет играть до момента окончания дорожки.",
       adminOnly = true,
       arguments = {ix.type.string, bit.bor(ix.type.number,ix.type.optional)},
       OnRun = function (self, client, soundstring, range)
          local data = {}
          data.start = client:GetShootPos()
          data.endpos = data.start + client:GetAimVector() * 96
          data.filter = client
          local trace = util.TraceLine(data)
          local target = trace.Entity
          level = math.Clamp(range or 75, 40, 75)
          if(IsValid(target)) then
            target:EmitSound(soundstring,level)
          else
            client:EmitSound(soundstring,level)
          end
       end
})


ix.command.Add("playSoundGlobal",{
       description = "Проиграть звук в глобальной зоне.",
       arguments = ix.type.string,
       adminOnly = true,
       OnRun = function (self, client, path)
            PLUGIN:GlobalSound(path)
            for _, v in ipairs(player.GetAll()) do
                if (v:IsAdmin()) then
                    v:Notify("Администратор "..client:Name().." начал проигрывать звук в глобально.")
                end
            end
       end
})

ix.command.Add("playURL",{
  description = "Проиграть звук через URL в глобальной зоне.",
  arguments = ix.type.string,
  adminOnly = true,
  OnRun = function(self, client, path)
        PLUGIN:GlobalURL(path)
        for _, v in ipairs(player.GetAll()) do
                if (v:IsAdmin()) then
                    v:Notify("Администратор "..client:Name().." начал проигрывать звук в глобально через URL.")
                end
        end
  end
})

ix.command.Add("stopsounds",{
       description = "Остановить все звуки в игре. Аналог stopsound, но для чата.",
       adminOnly = true,
       OnRun = function (self, client)
              for k, v in pairs (player.GetAll()) do
			v:ConCommand("stopsound")
			v:Notify("Все звуки были остановлены.")
       end
end
})
