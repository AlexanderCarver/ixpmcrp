Schema.name = "PMC Jackal: Dirty Money"
Schema.author = "Carver"
Schema.description = "Forging Future, SEcuring Sucess"
Schema.logo = "materials/main/server-logo.png"
Schema.color = Color(174, 174, 174, 255)

-- Schema configs
ix.config.Set("walkSpeed", 90)
ix.config.SetDefault("walkSpeed", 90)
ix.config.Set("color", Schema.color)

-- Include additional files
ix.util.Include("cl_hooks.lua")
ix.util.Include("sh_hooks.lua")
ix.util.Include("sv_hooks.lua")

ix.util.Include("meta/sh_character.lua")
ix.util.Include("meta/sh_player.lua")

ix.util.Include("libs/thirdparty/sh_netstream2.lua")

-- Animations
ix.anim.SetModelClass("models/kuge/private military contractor/pmc-5.mdl", "player")