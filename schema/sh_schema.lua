Schema.name = "PMC Jackal: Dirty Money (Act I)"
Schema.author = "Carver"
Schema.description = "Forging future, securing succes."
Schema.version = "Legacy"
Schema.logo = "materials/limefruit/server-logo_new_inverted.png"
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
ix.util.Include("libs/sh_command.lua")

-- Animations
ix.anim.SetModelClass("models/humans/marine.mdl", "overwatch")