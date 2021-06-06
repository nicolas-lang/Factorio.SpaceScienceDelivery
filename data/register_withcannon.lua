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
					,subgroup = item.subgroup
					,order=item.order
				}
				data:extend({newItem})
				se_delivery_cannon_recipes[newItem.name] = {name=newItem.name,type="item"}
			end
		end
	end
	log(txt)
end