local L = AceLibrary("AceLocale-2.2"):new("Elephant")
local Elephant, self = Elephant, Elephant

function Elephant:ChangeLog(index)
	self.db.char.currentlogindex = index
	self.tempConf.currentline = #self.db.char.logs[index].logs
	self:ShowCurrentLog()
end

function Elephant:ShowCurrentLog()	
	self.gui.scrollingMessageFrame:Clear()
	
	self:SetObjectColorWithCurrentLogColor(self.gui.titleInfoTab)
	self:SetObjectColorWithCurrentLogColor(self.gui.titleInfoCurrentLine)
	self:SetObjectColorWithCurrentLogColor(self.gui.scrollingMessageFrame)
	self.gui.titleInfoTab:SetText("< " .. self.db.char.logs[self.db.char.currentlogindex].name .. " >")
	self:SetTitleInfoCurrentLine()
	self:UpdateCurrentLogButtons()
	
	local i
	for i = self.tempConf.currentline-self.defaultConf.scrollmaxlines, self.tempConf.currentline do
		if self.db.char.logs[self.db.char.currentlogindex].logs[i] then
			self.gui.scrollingMessageFrame:AddMessage(self:GetLiteralMessage(self.db.char.logs[self.db.char.currentlogindex].logs[i]))
		end
	end
	
	--[[ Updating message catchers button ]]
	for _,v in pairs(self.db.profile.events) do
		if v.channels and v.channels[self.db.char.currentlogindex] then
			if self.gui.elephantButtonCatchOptions:IsEnabled() == 0 then
				self.gui.elephantButtonCatchOptions:Enable()
			end
			return
		end
	end
	
	if self.gui.elephantButtonCatchOptions:IsEnabled() == 1 then
		self.gui.elephantButtonCatchOptions:Disable()
	end
end

function Elephant:SetTitleInfoCurrentLine()
	self.gui.titleInfoCurrentLine:SetText(self.tempConf.currentline .. " / " .. #self.db.char.logs[self.db.char.currentlogindex].logs)
end

function Elephant:SetTitleInfoMaxLog()
	if self.db.char.currentlogindex == self.defaultConf.defaultindexes.combat then
		self.gui.titleInfoMaxLog:SetText( format(L['maxlog'], self.db.profile.maxcombatlog) )
	else
		self.gui.titleInfoMaxLog:SetText( format(L['maxlog'], self.db.profile.maxlog) )
	end
end

function Elephant:ShowCopyWindow()
	self.gui.mainFrame:Hide()
	
	Elephant:FillCopyWindowNormalText()
	
	self.gui.copyFrame:Show()
end

function Elephant:FillCopyWindowNormalText()
	self.gui.copyFrameScrollFrameEditBox:SetText("")
	self:SetObjectColorWithCurrentLogColor(self.gui.copyFrameScrollFrameEditBox)
	local i
	for i = self.tempConf.currentline-self.defaultConf.copywindowmaxlines, self.tempConf.currentline do
		if self.db.char.logs[self.db.char.currentlogindex].logs[i] then
			self.gui.copyFrameScrollFrameEditBox:Insert(self:GetLiteralMessage(self.db.char.logs[self.db.char.currentlogindex].logs[i]) .. "\n")
		end
	end
	
	self.gui.elephantCopyFrameButtonBBCode:SetScript("OnClick", function() Elephant:FillCopyWindowBBText() end)
end

function Elephant:FillCopyWindowBBText()
	self.gui.copyFrameScrollFrameEditBox:SetText("|r")
	self.gui.copyFrameScrollFrameEditBox:SetTextColor(0.75, 0.75, 0.75, 1.0)
	local i, msg
	for i = self.tempConf.currentline-self.defaultConf.copywindowmaxlines, self.tempConf.currentline do
		if self.db.char.logs[self.db.char.currentlogindex].logs[i] then
			msg = self:GetLiteralMessage(self.db.char.logs[self.db.char.currentlogindex].logs[i])
			msg = string.gsub(msg, "\|c%x%x(%x%x%x%x%x%x)\|Hitem:(%d-):.-|h(.-)|h|r", "[url=" .. L['itemLinkSite'] .. "%2][color=#%1]%3[/color][/url]")
			msg = string.gsub(msg, "\|c%x%x(%x%x%x%x%x%x)(.-)|r", "[color=#%1]%2[/color]")
			self.gui.copyFrameScrollFrameEditBox:Insert(msg .. "\n")
		end
	end
	
	self.gui.elephantCopyFrameButtonBBCode:SetScript("OnClick", function() Elephant:FillCopyWindowNormalText() end)
end

function Elephant:UpdateCurrentLogButtons()
	if self.db.char.logs[self.db.char.currentlogindex].enabled then
		self.gui.buttonEnable:GetFontString():SetText(L['Disable'])
	else
		self.gui.buttonEnable:GetFontString():SetText(L['Enable'])
	end
	if #self.db.char.logs[self.db.char.currentlogindex].logs > 0 then
		self.gui.buttonCopy:Enable()
	else
		self.gui.buttonCopy:Disable()
	end
	if L['generalchats'][self.db.char.currentlogindex] or (type(self.db.char.currentlogindex) == "number") then
		self.gui.buttonDelete:Disable()
	elseif GetChannelName(self.db.char.logs[self.db.char.currentlogindex].name) > 0 then
		self.gui.buttonDelete:Disable()
	else
		self.gui.buttonDelete:Enable()
	end
end

function Elephant:ForceCurrentLogDeleteButtonStatus(isEnabled)
	if isEnabled then
		self.gui.buttonDelete:Enable()
	else
		self.gui.buttonDelete:Disable()
	end
end

function Elephant:Scroll(n)
	local oldIndex = self.tempConf.currentline
	
	self.tempConf.currentline = self.tempConf.currentline+n
	if self.tempConf.currentline < 1 then
		self.tempConf.currentline = 1
	end
	if self.tempConf.currentline > #self.db.char.logs[self.db.char.currentlogindex].logs then
		self.tempConf.currentline = #self.db.char.logs[self.db.char.currentlogindex].logs
	end
	
	-- Prevent too much processing
	if oldIndex ~= self.tempConf.currentline then
		self:ShowCurrentLog()
	end
end

function Elephant:SetObjectColorWithCurrentLogColor(obj)
	local typeInfo
	
	if self.db.char.currentlogindex == self.defaultConf.defaultindexes.whisper then
		typeInfo = "WHISPER"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.raid then
		typeInfo = "RAID"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.party then
		typeInfo = "PARTY"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.say then
		typeInfo = "SAY"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.yell then
		typeInfo = "YELL"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.officer then
		typeInfo = "OFFICER"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.guild then
		typeInfo = "GUILD"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.system then
		typeInfo = "SYSTEM"
	elseif self.db.char.currentlogindex == self.defaultConf.defaultindexes.loot then
		typeInfo = "LOOT"
	else
		typeInfo = "CHANNEL"
		
		local channelId, channelName
		local i
		-- Max: 20 channels
		for i=1,20 do
			channelId,channelName = GetChannelName(i)
			
			if
				channelName ~= nil and
				string.lower(channelName) == string.lower(self.db.char.logs[self.db.char.currentlogindex].name)
			then
				typeInfo = "CHANNEL" .. channelId
				break
			end
		end
	end
	
	obj:SetTextColor(ChatTypeInfo[typeInfo].r, ChatTypeInfo[typeInfo].g, ChatTypeInfo[typeInfo].b, ChatTypeInfo[typeInfo].a)
end

function Elephant:PlaceTooltip(msg, position)
	if not (type(msg) == "table") then
		return
	end
	
	GameTooltip:SetOwner(this, position)
	for i,v in ipairs(msg) do
		if i == 1 then
			GameTooltip:SetText("|c00FFFFFF" .. v .. "|r")
		else
			GameTooltip:AddLine(v)
		end
	end
	GameTooltip:Show()
end

function Elephant:SetTooltip(msg)
	self:PlaceTooltip(msg, "ANCHOR_RIGHT")
end

function Elephant:Toggle()
	if self.gui.mainFrame:IsVisible() then
		self.gui.mainFrame:Hide()
	else
		self.gui.mainFrame:Show()
	end
end

function Elephant:ResetPosition()
	self.gui.mainFrame:ClearAllPoints()
	self.gui.mainFrame:SetPoint("TOP", self.defaultConf.position.x, self.defaultConf.position.y)
end

function Elephant:UnsetTooltip()
	if GameTooltip:IsVisible() then
		GameTooltip:Hide()
	end
end

function Elephant:ChatLogEnable(enabledStatus)
	if not self.db.profile.activate_log then
		return
	end
	
	if not (LoggingChat() == enabledStatus) then
		LoggingChat(enabledStatus)
	end
end

function Elephant:CombatLogEnable(enabledStatus)
	if not self.db.profile.activate_log then
		return
	end
	
	if not (LoggingCombat() == enabledStatus) then
		LoggingCombat(enabledStatus)
	end
end

function Elephant:CreateButton()
	self.gui.menuButton = CreateFrame("Button", "ElephantFrameMenuButton", UIParent)
	self.gui.menuButton:SetMovable(true)
	self.gui.menuButton:SetWidth(32)
	self.gui.menuButton:SetHeight(34)
	self.gui.menuButton:SetPoint("BOTTOM", ChatFrameMenuButton, "TOP")
	self.gui.menuButton:SetNormalTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Up")
	self.gui.menuButton:SetPushedTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Down")
	self.gui.menuButton:SetDisabledTexture("Interface/Buttons/UI-SpellbookIcon-NextPage-Disabled")
	self.gui.menuButton:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	self.gui.menuButton:SetScript("OnEnter", function() self:SetTooltip(L['togglebuttontooltip']) end)
	self.gui.menuButton:SetScript("OnLeave", function() self:UnsetTooltip() end)
	self.gui.menuButton:SetScript("OnClick", function() self:Toggle() end)
	self.gui.menuButton:SetScript("OnMouseDown", function(args)
		if arg1 == "RightButton" then
			self.gui.menuButton:StartMoving()
		end
		if arg1 == "MiddleButton" then
			self:ResetButtonPosition()
		end
	end)
	self.gui.menuButton:SetScript("OnMouseUp", function() self.gui.menuButton:StopMovingOrSizing() end)
end

function Elephant:ResetButtonPosition()
	self.gui.menuButton:ClearAllPoints()
	self.gui.menuButton:SetPoint("BOTTOM", ChatFrameMenuButton, "TOP")
end

function Elephant:ToggleButton()
	if not self.gui.menuButton then
		self:CreateButton()
		self.db.profile.button = true
	else
		if self.gui.menuButton:IsVisible() then
			self.gui.menuButton:Hide()
			self.db.profile.button = false
		else
			self.gui.menuButton:Show()
			self.db.profile.button = true
		end
	end
end