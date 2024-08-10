local L = AceLibrary("AceLocale-2.2"):new("Elephant")
local Elephant, self = Elephant, Elephant

function Elephant:InitDefaultLogStructures()
	local k,v
	for k,v in pairs(self.defaultConf.defaultindexes) do
		if not self.db.char.logs[v] then
			self:CreateNewLogStructure(v, self.defaultConf.defaultnames[k])
		end
	end
	
	for k,v in pairs(L['generalchats']) do
		if not self.db.char.logs[k] then
			self:CreateNewLogStructure(k, v.name)
		end
	end
end

function Elephant:InitCustomStructures()
	local channelCustomId,channelName
	local found
	local i
	-- Max: 20 channels
	for i=1,20 do
		_,channelName = GetChannelName(i)
		
		if channelName ~= nil then
			channelCustomId = string.lower(channelName)
			
			found = false
			for k,v in pairs(L['generalchats']) do
				if (channelCustomId == k) or string.find(channelCustomId, k .. " - ") then
					found = true
					break
				end
			end
			
			if not found then
				self:InitCustomStructure(string.lower(channelName), channelName)
			end
		end
	end
end

function Elephant:InitCustomStructure(id, name)
	if self.db.char.logs[id] then
		return
	end
	
	self:CreateNewLogStructure(id, name)
	if self.db.char.logs[id].enabled then
		self:AddHeaderToTable(self.db.char.logs[id])
	end
end

function Elephant:CreateNewLogStructure(index, name)
	self.db.char.logs[index] = {}
	
	self.db.char.logs[index].name = name
	self.db.char.logs[index].enabled = self.db.profile.defaultlog
	self.db.char.logs[index].logs = {}
end

function Elephant:AddHeaderToStructures(onlyGeneralChannels)
	local k, v
	
	for k,v in pairs(self.db.char.logs) do
		if v.enabled then
			if
				onlyGeneralChannels == nil or
				onlyGeneralChannels == false or (
					onlyGeneralChannels == true and (
						type(k) == "number" or
						L['generalchats'][k]
					)
				)
			then
				self:AddHeaderToTable(v)
			end
		end
		self:CheckTableSize(k)
	end
end

--[[
	Should only be used if the log of this chat IS enabled
	
	@param logObject a log object
]]--
function Elephant:AddHeaderToTable(logObject)
	-- For "easier-to-read" code
	local t = logObject.logs
	
	-- If log is not empty
	if #t > 0 then
		if not logObject.hasMessage then
			-- If the log does not have a message since the last header
			-- then simply modify the last header
			self:SaveMsgToTableAtPosition(t, { ['type'] = "SYSTEM", ['arg1'] = self:GetEnableActionMsg(true) } , #t)
		else
			-- Otherwise add two lines
			self:AddMsgToTable(t, { ['arg1'] = " " } )
			self:AddMsgToTable(t, { ['arg1'] = " " } )
		end
	end

	-- If log did  save a message since the last header
	-- or log is empty
	if logObject.hasMessage or #t == 0 then
		self:AddMsgToTable(t, { ['type'] = "SYSTEM", ['arg1'] = self:GetEnableActionMsg(true) } )
	end
	
	-- Specify that no messages has been saved since the last header
	if logObject.hasMessage then
		logObject.hasMessage = false
	end
end

function Elephant:AddMsgToTable(t, msg)
	t[#t+1] = msg
end

function Elephant:SaveMsgToTableAtPosition(t, msg, position)
	t[position] = msg
end

function Elephant:CheckTableSize(index)
	local mLog
	local i=0
	
	mLog = self.db.profile.maxlog
	
	while #self.db.char.logs[index].logs > mLog do
		table.remove(self.db.char.logs[index].logs, 1)
		i = i+1
	end
	
	return i
end

function Elephant:ChangeMaxLog(nb)
	if (nb < self.defaultConf.minlogsize) then return end
	if (nb > self.defaultConf.maxlogsize) then return end
	
	self.db.profile.maxlog = nb
	
	local k
	for k in pairs(self.db.char.logs) do
		self:CheckTableSize(k)
	end
	
	if (nb < self.tempConf.currentline) then
		self.tempConf.currentline = nb
	end
	
	self:SetTitleInfoMaxLog()
	self:ShowCurrentLog()
end

function Elephant:ChangeCombatMaxLog(nb)
	if (nb < self.defaultConf.mincombatlogsize) then return end
	if (nb > self.defaultConf.maxcombatlogsize) then return end
	
	self.db.profile.maxcombatlog = nb
	
	self:CheckTableSize(self.defaultConf.defaultindexes.combat)
	
	if (nb < self.tempConf.currentline) then
		self.tempConf.currentline = nb
	end
	
	self:SetTitleInfoMaxLog()
	self:ShowCurrentLog()
end

function Elephant:EmptyCurrentLog()
	self.db.char.logs[self.db.char.currentlogindex].logs = {}
	if self.db.char.logs[self.db.char.currentlogindex].enabled then
		self:AddHeaderToTable(self.db.char.logs[self.db.char.currentlogindex])
	end
	
	self:Print( format(L['emptyconfirm'], self.db.char.logs[self.db.char.currentlogindex].name) )
	
	self.tempConf.currentline = #self.db.char.logs[self.db.char.currentlogindex].logs
	self:ShowCurrentLog()
end

function Elephant:ClearAllLogs()
	local k, v
	for k,v in pairs(self.db.char.logs) do
		v.logs = {}
		if v.enabled then
			self:AddHeaderToTable(v)
		end
	end
	
	self:Print(L['clearallconfirm'])
	
	self.tempConf.currentline = #self.db.char.logs[self.db.char.currentlogindex].logs
	self:ShowCurrentLog()
end

function Elephant:DeleteCurrentLog()
	self:DeleteLog(self.db.char.currentlogindex)
end

function Elephant:DeleteLog(index)
	self:Print( format(L['deleteconfirm'], self.db.char.logs[index].name) )
	self.db.char.logs[index] = nil
end

function Elephant:CaptureNewMessage(msg, index)
	table.insert(self.db.char.logs[index].logs, #self.db.char.logs[index].logs+1, msg)
	
	if not self.db.char.logs[index].hasMessage then
		self.db.char.logs[index].hasMessage = true
	end
	
	if self.db.char.currentlogindex == index then
		--[[ Moves the current line if it WAS at the last line ]]
		if self.tempConf.currentline == (#self.db.char.logs[index].logs-1) then
			self.tempConf.currentline = self.tempConf.currentline + 1
		end
		
		self.tempConf.currentline = self.tempConf.currentline - self:CheckTableSize(index)
		if self.tempConf.currentline < 1 then
			self.tempConf.currentline = 1
		end
		
		if self.tempConf.currentline == #self.db.char.logs[index].logs then
			--[[ Adds the message to the screen ]]
			self.gui.scrollingMessageFrame:AddMessage(self:GetLiteralMessage(msg))
		end
		--[[ Updates current line text ]]
		self:SetTitleInfoCurrentLine()
	else
		self:CheckTableSize(index)
	end
end

function Elephant:Reset()
	self:ResetSavedVariables()
	
	self:ChatLogEnable(self.db.profile.chatlog)
	self:CombatLogEnable(self.db.profile.combatlog)
	
	local k, v
	local lcname
	local found
	local channelName
	local i
	-- Max: 20 channels
	for i=1,20 do
		_,channelName = GetChannelName(i)
		
		if channelName ~= nil then
			lcname = string.lower(channelName)
			found = false
			for k,v in pairs(L['generalchats']) do
				if (lcname == k) or string.find(lcname, k .. " - ") then
					found = true
					break
				end
			end
			if not found then
				self:InitCustomStructure(lcname, channelName)
				self:CaptureNewMessage( { ['type'] = "SYSTEM", ['arg1'] = L['customchat']['join'] } , lcname)
			end
		end
	end
	
	self:InitDefaultLogStructures()
	self:InitCustomStructures()
	self:AddHeaderToStructures(true)
	self:ResetPosition()
	self:ChangeLog(self.db.char.currentlogindex)
	
	self:Print(L['resetconfirm'])
end

function Elephant:ResetSavedVariables()
	for k,v in pairs(self:clone(self.defaultConf.savedconfdefaults)) do
		self.db.profile[k] = v
	end
	for k,v in pairs(self:clone(self.defaultConf.savedpercharconfdefaults)) do
		self.db.char[k] = v
	end
end

function Elephant:ToggleEnableCurrentLog()
	self.db.char.logs[self.db.char.currentlogindex].enabled = not self.db.char.logs[self.db.char.currentlogindex].enabled
	
	if self.db.char.logs[self.db.char.currentlogindex].enabled then
		self:CaptureNewMessage( { ['arg1'] = " " } , self.db.char.currentlogindex)
		self:CaptureNewMessage( { ['arg1'] = " " } , self.db.char.currentlogindex)
	end
	self:CaptureNewMessage( { ['type'] = "SYSTEM", ['arg1'] = self:GetEnableActionMsg(self.db.char.logs[self.db.char.currentlogindex].enabled) } , self.db.char.currentlogindex)
	
	self:UpdateCurrentLogButtons()
end

function Elephant:AddFilter(arg1)
	local v
	for _,v in pairs(self.db.profile.filters) do
		if v == arg1 then
			return
		end
	end
	
	table.insert(self.db.profile.filters, arg1)
	
	local k,v
	for k,v in pairs(self.db.char.logs) do
		if type(k) ~= "number" and string.find(k, " ") == nil then
			if self:IsFiltered(k) then
				self:DeleteLog(k)
			end
		end
	end
end

function Elephant:IsFiltered(index)
	local v
	for _,v in pairs(self.db.profile.filters) do
		v = "^" .. string.gsub(string.lower(v), "%*", "%.%*") .. "$"
		if string.match(index, v) ~= nil and not L['generalchats'][index] then
			return true
		end
	end
	
	return false
end

function Elephant:DeleteFilter(arg1)
	local k,v
	for k,v in pairs(self.db.profile.filters) do
		if v == arg1 then
			self.db.profile.filters[k] = nil
			break
		end
	end
	
	local channelName
	local i
	-- Max: 20 channels
	for i=1,20 do
		_,channelName = GetChannelName(i)
		
		if
			channelName ~= nil and
			not self.db.char.logs[string.lower(channelName)] and
			not self:IsFiltered(string.lower(channelName))
		then
			self:InitCustomStructure(string.lower(channelName), channelName)
		end
	end
end

function Elephant:EnableCatcher(catch, channel)
	self.db.profile.events[catch].channels[channel] = 1
end

function Elephant:DisableCatcher(catch, channel)
	self.db.profile.events[catch].channels[channel] = 0
end