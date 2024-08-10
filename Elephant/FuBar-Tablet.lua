local L = AceLibrary("AceLocale-2.2"):new("Elephant")
local Elephant, self = Elephant, Elephant

--[[ FuBarPlugin Tablet ]]
local tablet = AceLibrary("Tablet-2.0")
function Elephant:OnTooltipUpdate()
	local cat = tablet:AddCategory(
		'columns', 3
	)
	
	-- Normal chats
	local status
	local enColor = {
		r = 0.0,
		g = 0.0,
		b = 0.0
	}
	local v
	for v = 1, self.defaultConf.nomisc do
		status = L['disabled']
		enColor.r = 1.0
		enColor.g = 0.0
		if self.db.char.logs[v].enabled then
			status = L['enabled']
			enColor.r = 0.0
			enColor.g = 1.0
		end
		
		cat:AddLine(
			'text', self.db.char.logs[v].name,
			'text2', status,
			'text3', #self.db.char.logs[v].logs,
			'textR', 1.0,
			'textG', 1.0,
			'textB', 0.0,
			'text2R', enColor.r,
			'text2G', enColor.g,
			'text2B', enColor.b,
			'text3R', 1.0,
			'text3G', 1.0,
			'text3B', 1.0,
			'justify2', "LEFT",
			'justify3', "RIGHT"
		)
	end
	
	-- Custom chats
	cat = tablet:AddCategory(
		'text', L['chatnames']['custom'],
		'columns', 3
	)
	
	local k
	for k,v in pairs(self.db.char.logs) do
		if not (type(k) == "number") then
			if not L['generalchats'][k] then
				status = L['disabled']
				enColor.r = 1.0
				enColor.g = 0.0
				if self.db.char.logs[k].enabled then
					status = L['enabled']
					enColor.r = 0.0
					enColor.g = 1.0
				end
				
				cat:AddLine(
					'text', self.db.char.logs[k].name,
					'text2', status,
					'text3', #self.db.char.logs[k].logs,
					'textR', 1.0,
					'textG', 1.0,
					'textB', 0.0,
					'text2R', enColor.r,
					'text2G', enColor.g,
					'text2B', enColor.b,
					'text3R', 1.0,
					'text3G', 1.0,
					'text3B', 1.0,
					'justify2', "LEFT",
					'justify3', "RIGHT"
				)
			end
		end
	end
	
	--General chats
	cat = tablet:AddCategory(
		'text', L['chatnames']['general'],
		'columns', 3
	)
	
	for k,v in pairs(self.db.char.logs) do
		if not (type(k) == "number") then
			if L['generalchats'][k] then
				status = L['disabled']
				enColor.r = 1.0
				enColor.g = 0.0
				if self.db.char.logs[k].enabled then
					status = L['enabled']
					enColor.r = 0.0
					enColor.g = 1.0
				end
				
				cat:AddLine(
					'text', self.db.char.logs[k].name,
					'text2', status,
					'text3', #self.db.char.logs[k].logs,
					'textR', 1.0,
					'textG', 1.0,
					'textB', 0.0,
					'text2R', enColor.r,
					'text2G', enColor.g,
					'text2B', enColor.b,
					'text3R', 1.0,
					'text3G', 1.0,
					'text3B', 1.0,
					'justify2', "LEFT",
					'justify3', "RIGHT"
				)
			end
		end
	end
	
	-- Misc chats
	cat = tablet:AddCategory(
		'text', L['chatnames']['misc'],
		'columns', 3
	)
	
	local status
	for k, v in pairs(self.defaultConf.defaultindexes) do
		if v > (self.defaultConf.nomisc) then
			status = L['disabled']
			enColor.r = 1.0
			enColor.g = 0.0
			if self.db.char.logs[v].enabled then
				status = L['enabled']
				enColor.r = 0.0
				enColor.g = 1.0
			end
			
			cat:AddLine(
				'text', self.db.char.logs[v].name,
				'text2', status,
				'text3', #self.db.char.logs[v].logs,
				'textR', 1.0,
				'textG', 1.0,
				'textB', 0.0,
				'text2R', enColor.r,
				'text2G', enColor.g,
				'text2B', enColor.b,
				'text3R', 1.0,
				'text3G', 1.0,
				'text3B', 1.0,
				'justify2', "LEFT",
				'justify3', "RIGHT"
			)
		end
	end
	
	tablet:SetHint(L['toggletooltip'])
end