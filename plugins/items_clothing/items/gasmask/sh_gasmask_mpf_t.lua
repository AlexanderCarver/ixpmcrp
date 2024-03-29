ITEM.name = "Титановая маска"
ITEM.description = "Сверхзащищенная титановая маска Гражданской Обороны, оснащенная визором."
ITEM.model = Model("models/vintagethief/items/cca/mask_02.mdl")
ITEM.rarity = 2
ITEM.bodyGroups = {
	[4] = 3,
	[6] = 1
}
ITEM.Filters = {
	["filter_epic"] = true,
	["filter_good"] = true,
	["filter_medium"] = true,
	["filter_standard"] = false
}
ITEM.Stats = {
	[HITGROUP_GENERIC] = 0,
	[HITGROUP_HEAD] = 15,
	[HITGROUP_CHEST] = 0,
	[HITGROUP_STOMACH] = 0,
	[4] = 0,
	[5] = 0,
}
ITEM.WeaponSkillBuff = 5
ITEM.CPMask = true
ITEM.visorLevel = 2