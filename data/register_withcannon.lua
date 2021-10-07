local data = _G.data
local se_delivery_cannon_recipes = _G.se_delivery_cannon_recipes
local data_util = require("data_util")
--=================================================================================================
local newItem
for _, item in pairs (data.raw["tool"]) do
	local txt = item.name
	if item.name ~= "basic-tech-card" then
		local recipe = data_util.getRecipe(item.name)
		if recipe then
			txt = txt .. ",recipe found"
			if recipe.category ~= "space-manufacturing" then
				txt = txt .. ",non-space"
				newItem = {
					 type = "item"
					,name = "crate-of-" .. item.name
					,icon = item.icon or item.icons[0]
					,icon_size = item.icon_size
					,stack_size = 200
					,subgroup = item.subgroup or "other"
					,order = item.order or ("zzz[" .. item.name .. "]")
				}
				--ensure the item has a order tag on the subgroup as SE requires this
				local item_subgroup = data.raw["item-subgroup"][item.subgroup]
				item_subgroup.order = item_subgroup.order or ("zzz[" .. item_subgroup.name .. "]")
				--ensure the item also has a order tag on the group
				local item_group = data.raw["item-group"][item_subgroup.group]
				item_group.order = item_group.order or ("zzz[" .. item_group.name .. "]")
				data:extend({newItem})
				se_delivery_cannon_recipes[newItem.name] = {name=newItem.name,type="item"}
			end
		end
	end
	log(txt)
end