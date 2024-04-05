require "ISUI/ISWorldObjectContextMenu"

ISWorldObjectContextMenu.onPutBodyInBag = function(worldobjects, player, corpse, bodyBag)

	if getDebug() then
		print(" - worldobjects: "..tostring(worldobjects))
		print(" - player: "..tostring(player))
		print(" - corpse: "..tostring(corpse))
		print(" - bodyBag: "..tostring(bodyBag))
	end

	local playerObj = getSpecificPlayer(player)
	if corpse:getSquare() and luautils.walkAdj(playerObj, corpse:getSquare(), bodyBag) then
		ISTimedActionQueue.add(ISBagCorpseAction:new(playerObj, corpse, bodyBag, 50))
	end
end


SCA_BodyBagMenu = {}
function SCA_BodyBagMenu.doMenu(player, context, worldobjects, test)
	local playerObj = getSpecificPlayer(player)
	local playerInv = playerObj:getInventory()
	if playerObj:isAsleep() then return end

	---@type IsoObject
	local isoObject = worldobjects[1]
	if isoObject then
		local square = isoObject:getSquare()
		if square then
			local body = square:getDeadBody()
			if body then
				local bodyBag = playerInv:getFirstType("BodyBag")
				if bodyBag then
					if test == true then
						return true
					end

					if playerInv:getItemCount("Base.CorpseMale")<=0 and playerInv:getItemCount("Base.CorpseFemale")<=0 then
						context:addOptionOnTop(getText("ContextMenu_BagCorpse"), worldobjects, ISWorldObjectContextMenu.onPutBodyInBag, player, body, bodyBag)
					end
				end
			end
		end
	end
end
Events.OnFillWorldObjectContextMenu.Add(SCA_BodyBagMenu.doMenu)


local ISInventoryTransferAction_transferItem = ISInventoryTransferAction.transferItem

function ISInventoryTransferAction:transferItem(item)

	ISInventoryTransferAction_transferItem(self, item)

	if getDebug() then print("self.destContainer:getType(): "..self.destContainer:getType().." "..tostring(self.destContainer)) end

	if self.destContainer:getType() == "BodyBag" then
		---@type InventoryItem
		local bodyBag = self.destContainer:getContainingItem()
		--bodyBag:visual
	end
end