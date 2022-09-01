require "TimedActions/ISBaseTimedAction"
require "TimedActions/ISInventoryTransferAction"

---@class ISBagCorpseAction : ISBaseTimedAction
ISBagCorpseAction = ISBaseTimedAction:derive("ISBagCorpseAction")

function ISBagCorpseAction:isValid()
	if self.corpseBody:getStaticMovingObjectIndex() < 0 then
		return false
	end
	return (self.character:getInventory():getItemCount("Base.CorpseMale") == 0 and self.character:getInventory():getItemCount("Base.CorpseFemale") == 0)
end

function ISBagCorpseAction:waitToStart()
	self.character:faceThisObject(self.corpseBody)
	return self.character:shouldBeTurning()
end

function ISBagCorpseAction:update()
	self.corpse:setJobDelta(self:getJobDelta())
	self.character:faceThisObject(self.corpseBody)

	self.character:setMetabolicTarget(Metabolics.MediumWork)
end

function ISBagCorpseAction:start()
	self.corpse:setJobType(getText("ContextMenu_BagCorpse"))
	self.corpse:setJobDelta(0.0)
	self:setActionAnim("Loot")
	self.character:SetVariable("LootPosition", "Low")

	self.character:reportEvent("EventLootItem")
end

function ISBagCorpseAction:stop()
	ISBaseTimedAction.stop(self)
	self.corpse:setJobDelta(0.0)
end

function ISBagCorpseAction:perform()
	forceDropHeavyItems(self.character)
	self.corpse:setJobDelta(0.0)
	self.bodyBag:getInventory():setDrawDirty(true)
	self.bodyBag:getInventory():AddItem(self.corpse)
	self.corpseBody:getSquare():removeCorpse(self.corpseBody, false)

	self.character:getInventory():Remove(self.bodyBag)
	local dropX, dropY, dropZ = ISInventoryTransferAction.GetDropItemOffset(self.character, self.character:getCurrentSquare(), self.bodyBag)
	self.character:getCurrentSquare():AddWorldInventoryItem(self.bodyBag, dropX, dropY, dropZ)
	self.character:removeFromHands(self.bodyBag)
	ISInventoryPage.renderDirty = true -- for corpses
	self.character:getEmitter():playSound("OpenBodybag")

	local pdata = getPlayerData(self.character:getPlayerNum())
	if pdata ~= nil then
		pdata.playerInventory:refreshBackpacks()
		pdata.lootInventory:refreshBackpacks()
	end

	-- needed to remove from queue / start next.
	ISBaseTimedAction.perform(self)
end

function ISBagCorpseAction:new(character, corpse, bodyBag, time)
	local o = {}
	setmetatable(o, self)
	self.__index = self
	o.character = character
	o.corpse = corpse:getItem()
	o.corpseBody = corpse
	o.bodyBag = bodyBag
	o.stopOnWalk = true
	o.stopOnRun = true
	o.maxTime = time
	o.forceProgressBar = true
	if character:isTimedActionInstant() then
		o.maxTime = 1
	end
	return o
end