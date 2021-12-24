local data = _G.data
local data_util = {}
--=================================================================================================
function data_util.has_value (tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end
	return false
end
--=================================================================================================
function data_util.getTechnologyForRecipe(recipe_name)
	for _, technology in pairs(data.raw.technology) do
		if (technology.enabled == true or technology.enabled == nil) and technology.effects then
			for _, effect in pairs(technology.effects) do
				if effect.type == "unlock-recipe" and effect.recipe == recipe_name then
					return technology
				end
			end
		end
	end
	return nil
end
--=================================================================================================
function data_util.getRecipe(item_name)
	for _, recipe in pairs (data.raw["recipe"]) do
		if recipe.result == item_name then
			return recipe -- take first recipe
		end
		if recipe.main_product == item_name then
			return recipe -- take first recipe
		end
		if recipe.results then
			for _, result in pairs (recipe.results) do
				local result_name = result["name"] or result[1]
				if result_name == item_name then
					return recipe -- take first recipe
				end
			end
		end
		for _, subname in pairs({"normal", "expensive"}) do
			if recipe[subname] then
				if recipe[subname].result == item_name then
					return recipe -- take first recipe
				end
				if recipe[subname].results then
					for _, result in pairs (recipe[subname].results) do
						local result_name = result["name"] or result[1]
						if result_name == item_name then
							return recipe -- take first recipe
						end
					end
				end
			end
		end
	end
end
--=================================================================================================
return data_util
