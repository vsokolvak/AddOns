local L = AceLibrary("AceLocale-2.2"):new("Elephant")
local Elephant, self = Elephant, Elephant

function Elephant:DropdownCustomChatsInitialize()
	self.dropdowns.customChats:AddLine(
		'text', L['chatnames']['custom'],
		'isTitle', true
	)
	
	local index, tindex, k, v
	for index, tindex in pairs(self.db.char.logs) do
		if not (type(index) == "number") then
			if not L['generalchats'][index] then
				local textR, textG, textB = nil, nil, nil
				
				if GetChannelName(tindex.name) == 0 then
					textR = self.defaultConf.colors.disabledchannel.r
					textG = self.defaultConf.colors.disabledchannel.g
					textB = self.defaultConf.colors.disabledchannel.b
				end
				
				self.dropdowns.customChats:AddLine(
					'text', tindex.name,
					'closeWhenClicked', true,
					'func', function(arg1)
						self:ChangeLog(arg1)
					end,
					'arg1', index,
					'checked', tindex.enabled,
					'textR', textR,
					'textG', textG,
					'textB', textB
				)
			end
		end
	end
	
	self.dropdowns.customChats:AddLine()
	self.dropdowns.miscChats:AddLine(
		'text', CLOSE,
		'closeWhenClicked', true
	)
end

function Elephant:DropdownGeneralChatsInitialize()
	self.dropdowns.customChats:AddLine(
		'text', L['chatnames']['general'],
		'isTitle', true
	)
	
	local index, tindex
	for index, tindex in pairs(self.db.char.logs) do
		if type(index) == "string" then
			if L['generalchats'][index] then
				self.dropdowns.generalChats:AddLine(
					'text', tindex.name,
					'closeWhenClicked', true,
					'func', function(arg1)
						self:ChangeLog(arg1)
					end,
					'arg1', index,
					'checked', tindex.enabled
				)
			end
		end
	end
	
	self.dropdowns.generalChats:AddLine()
	self.dropdowns.miscChats:AddLine(
		'text', CLOSE,
		'closeWhenClicked', true
	)
end

function Elephant:DropdownMiscChatsInitialize()
	self.dropdowns.customChats:AddLine(
		'text', L['chatnames']['misc'],
		'isTitle', true
	)
	
	self.dropdowns.miscChats:AddLine(
		'text', L['chatnames']['achievement'],
		'closeWhenClicked', true,
		'func', function(arg1)
			self:ChangeLog(arg1)
		end,
		'arg1', self.defaultConf.defaultindexes.achievement,
		'checked', self.db.char.logs[self.defaultConf.defaultindexes.achievement].enabled
	)
	self.dropdowns.miscChats:AddLine(
		'text', L['chatnames']['loot'],
		'closeWhenClicked', true,
		'func', function(arg1)
			self:ChangeLog(arg1)
		end,
		'arg1', self.defaultConf.defaultindexes.loot,
		'checked', self.db.char.logs[self.defaultConf.defaultindexes.loot].enabled
	)
	self.dropdowns.miscChats:AddLine(
		'text', L['chatnames']['system'],
		'closeWhenClicked', true,
		'func', function(arg1)
			self:ChangeLog(arg1)
		end,
		'arg1', self.defaultConf.defaultindexes.system,
		'checked', self.db.char.logs[self.defaultConf.defaultindexes.system].enabled
	)
	
	self.dropdowns.miscChats:AddLine()
	self.dropdowns.miscChats:AddLine(
		'text', CLOSE,
		'closeWhenClicked', true
	)
end

function Elephant:DropdownCatchOptionsInitialize(level, id)
	local menu		= {}
	
	local k,v
	local c
	for k,v in pairs(self.db.profile.events) do
		if v.channels and v.desc then
			if v.sub and level == 1 then
				if v.channels[self.db.char.currentlogindex] then
					if not menu[v.sub] then
						menu[v.sub] = 1
						tinsert(menu, v.sub)
					else
						menu[v.sub] = menu[v.sub] + 1
					end
				end
			elseif (level == 2 and v.sub == id) or level == 1 then
				c = v.channels[self.db.char.currentlogindex]
				if c then
					menu[v.desc] = {
						key		= k,
						option	= c
					}
					tinsert(menu, v.desc)
				end
			end
		end
	end
	
	table.sort(menu, function(a,b) return Elephant:SortTable(a,b) end)
	
	for _,v in ipairs(menu) do
		if type(menu[v]) == "number" then
			self.dropdowns.miscChats:AddLine(
				'text', v .. " <" .. menu[v] .. ">",
				'hasArrow', true,
				'value', v
			)
		else
			if menu[v].option == -1 then
				self.dropdowns.miscChats:AddLine(
					'text', v,
					'checked', true,
					'textR', self.defaultConf.colors.disabledchannel.r,
					'textG', self.defaultConf.colors.disabledchannel.g,
					'textB', self.defaultConf.colors.disabledchannel.b
				)
			elseif menu[v].option == 0 then
				self.dropdowns.miscChats:AddLine(
					'text', v,
					'checked', false,
					'func', function(arg1, arg2)
						self:EnableCatcher(arg1, arg2)
					end,
					'arg1', menu[v].key,
					'arg2', self.db.char.currentlogindex
				)
			elseif menu[v].option == 1 then
				self.dropdowns.miscChats:AddLine(
					'text', v,
					'checked', true,
					'func', function(arg1, arg2)
						self:DisableCatcher(arg1, arg2)
					end,
					'arg1', menu[v].key,
					'arg2', self.db.char.currentlogindex
				)
			end
		end
	end
	
	self.dropdowns.miscChats:AddLine()
	self.dropdowns.miscChats:AddLine(
		'text', CLOSE,
		'closeWhenClicked', true
	)
end

function Elephant:SortTable(arg1, arg2)
	local i=1
	local j
	
	repeat
		j = string.byte(arg1, i) - string.byte(arg2, i)
		
		if j == 0 then
			i = i+1
		elseif j<0 then
			return true
		else
			return false
		end
	until string.byte(arg1, i) == nil or string.byte(arg2, i) == nil
	
	if string.byte(arg1, i) == nil then
		return true
	else
		return false
	end
end