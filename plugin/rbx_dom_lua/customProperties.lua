local CollectionService = game:GetService("CollectionService")

-- Defines how to read and write properties that aren't directly scriptable.
--
-- The reflection database refers to these as having scriptability = "Custom"
return {
	Instance = {
		Tags = {
			read = function(instance)
				return true, CollectionService:GetTags(instance)
			end,
			write = function(instance, _, value)
				local existingTags = CollectionService:GetTags(instance)

				local unseenTags = {}
				for _, tag in ipairs(existingTags) do
					unseenTags[tag] = true
				end

				for _, tag in ipairs(value) do
					unseenTags[tag] = nil
					CollectionService:AddTag(instance, tag)
				end

				for tag in pairs(unseenTags) do
					CollectionService:RemoveTag(instance, tag)
				end

				return true
			end,
		},
	},
	LocalizationTable = {
		Contents = {
			read = function(instance, key)
				return true, instance:GetContents()
			end,
			write = function(instance, key, value)
				instance:SetContents(value)
				return true
			end,
		},
	},
}
