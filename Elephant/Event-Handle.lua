local L = AceLibrary("AceLocale-2.2"):new("Elephant")
local Elephant, self = Elephant, Elephant

function Elephant:HandleMessage(event, prat_msg)
	if not self.db.profile.prat and prat_msg then return end
	if not self.db.profile.events[event] then return end
	
	local msg, msg2
	--[[ Channels ]]
	if event == "CHAT_MSG_CHANNEL" or event == "CHAT_MSG_CHANNEL_NOTICE" then
		local larg9 = string.lower(arg9)
		local cIndex
		for k,v in pairs(L['generalchats']) do
			if (larg9 == k) or string.find(larg9, k .. " - ") then
				cIndex = k
				break
			end
		end
		if cIndex == nil then cIndex = larg9 end
		
		if self:IsFiltered(cIndex) then return end
		
		if event == "CHAT_MSG_CHANNEL" then
			if not self.db.char.logs[cIndex].enabled then return end
			
			local msg
			if prat_msg then
				msg = {
					['time'] = self:Prat_CaptureTime(),
					['prat'] = prat_msg
				}
			else
				msg = {
					['time'] = time(),
					['arg1'] = arg1,
					['arg6'] = arg6,
					['arg9'] = arg9
				}
				if arg2 ~= "" then
					msg['arg2'] = arg2
				end
			end
			self:CaptureNewMessage(msg, cIndex)
		end
		
		if event == "CHAT_MSG_CHANNEL_NOTICE" then
			local larg9 = string.lower(arg9)
			local cIndex
			for k,v in pairs(L['generalchats']) do
				if (larg9 == k) or string.find(larg9, k .. " - ") then
					cIndex = k
					break
				end
			end
			if cIndex == nil then cIndex = larg9 end
			
			if arg1 == "YOU_JOINED" then
				self:InitCustomStructure(cIndex, arg9)
				
				if not self.db.char.logs[cIndex].enabled then return end
				
				self:CaptureNewMessage( { ['type'] = "SYSTEM", ['arg1'] = L['customchat']['join'] } , cIndex)
				if self.db.char.currentlogindex == cIndex then
					self:UpdateCurrentLogButtons()
				end
			end
			if arg1 == "YOU_LEFT" then
				if not self.db.char.logs[cIndex] then return end
				if not self.db.char.logs[cIndex].enabled then return end
				
				self:CaptureNewMessage( { ['type'] = "SYSTEM", ['arg1'] = L['customchat']['leave'] } , cIndex)
				self:CaptureNewMessage( { ['arg1'] = " " } , cIndex)
				if self.db.char.currentlogindex == cIndex then
					self:UpdateCurrentLogButtons()
					self:ForceCurrentLogDeleteButtonStatus(true)
				end
			end
		end
	--[[ Default messages ]]
	else
		if prat_msg then
			msg = {
				['time'] = self:Prat_CaptureTime(),
				['prat'] = prat_msg,
				['type'] = self.db.profile.events[event].type
			}
		else
			msg = {
				['time'] = time(),
				['type'] = self.db.profile.events[event].type,
				['arg1'] = arg1
			}
			
			if	event == "CHAT_MSG_BATTLEGROUND" or
				event == "CHAT_MSG_BATTLEGROUND_LEADER" or
				event == "CHAT_MSG_WHISPER" or
				event == "CHAT_MSG_WHISPER_INFORM" or
				event == "CHAT_MSG_MONSTER_WHISPER" or
				event == "CHAT_MSG_RAID" or
				event == "CHAT_MSG_RAID_LEADER" or
				event == "CHAT_MSG_RAID_WARNING" or
				event == "CHAT_MSG_PARTY" or
				event == "CHAT_MSG_PARTY_LEADER" or
				event == "CHAT_MSG_SAY" or
				event == "CHAT_MSG_MONSTER_SAY" or
				event == "CHAT_MSG_YELL" or
				event == "CHAT_MSG_MONSTER_YELL" or
				event == "CHAT_MSG_OFFICER" or
				event == "CHAT_MSG_GUILD" or
				event == "CHAT_MSG_EMOTE" or
				event == "CHAT_MSG_MONSTER_EMOTE" or
				event == "CHAT_MSG_BN_WHISPER" or
				event == "CHAT_MSG_BN_WHISPER_INFORM" or
				event == "CHAT_MSG_ACHIEVEMENT" or
				event == "CHAT_MSG_GUILD_ACHIEVEMENT"
			then
				msg.arg2 = arg2
			end
			
			if event == "CHAT_MSG_WHISPER" then
				msg.arg6 = arg6
			end
			
			if event == "PARTY_LOOT_METHOD_CHANGED" then
				local method, masterloot_party, masterloot_raid = GetLootMethod()
				
				if method ~= self.defaultConf.lootmethod then
					self.defaultConf.lootmethod = method
					msg.arg1 = L['lootmethod'][method]
				end
				
				if masterloot_party or masterloot_raid then
					local player
					if UnitInRaid("player") then
						player = GetRaidRosterInfo(masterloot_raid)
					else
						if masterloot_party > 0 then
							player = UnitName("party" .. masterloot_party)
						else
							player = UnitName("player")
						end
					end
					
					if player ~= self.defaultConf.masterlooter then
						self.defaultConf.masterlooter = player
						
						msg2 = {
							['time'] = time(),
							['type'] = self.db.profile.events[event].type,
							['arg1'] = format(L['masterlooterchanged'], player)
						}
					end
				else
					self.defaultConf.masterlooter = nil
				end
			end
		end

		local k
		for k in pairs(self.db.profile.events[event].channels) do
			if self.db.profile.events[event].channels[k] ~= 0 and self.db.char.logs[k].enabled then
				self:CaptureNewMessage(msg, k)
				if msg2 ~= nil then
					self:CaptureNewMessage(msg2, k)
				end
			end
		end
	end
end

function Elephant:RegisterEventsRefresh()
	self:UnregisterAllEvents()
	
	if Prat	and self.db.profile.prat then
		Prat.RegisterChatEvent(Prat, Prat.Events.POST_ADDMESSAGE, function(_, _, _, event, text) self:HandleMessage(event, text) end)
		return
	else
		if not Prat and self.db.profile.prat then
			self:Print("|cffff0000" .. L['noprat'] .. "|r")
		end
		
		local k,v
		for k,v in pairs(self.db.profile.events) do
			self:RegisterEvent(k, function() self:HandleMessage(k) end)
		end
	end
end

function Elephant:Prat_CaptureTime()
	if self.db.profile.forcetimestamp then
		return time()
	else
		return nil
	end
end