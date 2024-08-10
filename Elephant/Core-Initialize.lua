local L = AceLibrary("AceLocale-2.2"):new("Elephant")
local Elephant, self = Elephant, Elephant

function Elephant:OnInitialize()
	local Fonts = {
		['GameFontNormal'] = {
			['Font'] = { GameFontNormal:GetFont() },
			['TextColor'] = { GameFontNormal:GetTextColor() },
		},
		['GameFontNormalSmall'] = {
			['Font'] = { GameFontNormalSmall:GetFont() },
			['TextColor'] = { GameFontNormalSmall:GetTextColor() },
		},
		['ChatFontNormal'] = {
			['Font'] = { ChatFontNormal:GetFont() },
			['TextColor'] = { ChatFontNormal:GetTextColor() },
		}
	}
	
	--[[ Creating gui pointers holder ]]
	self.gui = {}
	
	--[[ Only one getglobal() to copy frame ]]
	self.gui.copyFrame = getglobal("ElephantCopyFrame")
	self.gui.copyFrame:SetBackdrop ( {
		bgFile = "Interface/ChatFrame/ChatFrameBackground",
		edgeFile = [[Interface\AddOns\Elephant\roth]],
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 },
	} )
	self.gui.copyFrame:SetBackdropColor(0.0, 0.0, 0.0, 0.45)
	
	--[[ General frame ]]
	self.gui.mainFrame = CreateFrame("Frame", "ElephantFrame", UIParent)
	self.gui.mainFrame:EnableMouse(true)
	self.gui.mainFrame:SetMovable(true)
	self.gui.mainFrame:SetToplevel(true)
	self.gui.mainFrame:SetWidth(600)
	self.gui.mainFrame:SetHeight(580)
	self.gui.mainFrame:SetPoint("TOP", UIParent, "TOP", self.defaultConf.position.x, self.defaultConf.position.y)
	self.gui.mainFrame:SetBackdrop ( {
		bgFile = "Interface/ChatFrame/ChatFrameBackground",
		edgeFile = [[Interface\AddOns\Elephant\roth]],
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 },
	} )
	self.gui.mainFrame:SetBackdropColor(0.0, 0.0, 0.0, 0.45)
	self.gui.mainFrame:SetScript("OnShow", function()
		self.gui.copyFrame:Hide()
		PlaySound("SPELLBOOKOPEN")
	end)
	self.gui.mainFrame:SetScript("OnHide", function()
		PlaySound("SPELLBOOKCLOSE")
		self.dropdowns.customChats:Close()
		self.dropdowns.generalChats:Close()
		self.dropdowns.miscChats:Close()
	end)
	self.gui.mainFrame:SetScript("OnMouseDown", function(args)
		if arg1 == "RightButton" then
			self.gui.mainFrame:StartMoving()
		end
		if arg1 == "MiddleButton" then
			self:ResetPosition()
		end
	end)
	self.gui.mainFrame:SetScript("OnMouseUp", function() self.gui.mainFrame:StopMovingOrSizing() end)
	
	local elephantTitle = self.gui.mainFrame:CreateTexture("ElephantTitle", "ARTWORK")
	elephantTitle:SetTexture("Interface/BUTTONS/UI-DialogBox-Button-Up")
	elephantTitle:SetWidth(128)
	elephantTitle:SetHeight(42)
	elephantTitle:SetPoint("TOP", 0, 12)
	
	local elephantTitleText = self.gui.mainFrame:CreateFontString()
	elephantTitleText:SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	elephantTitleText:SetTextColor(Fonts.GameFontNormal.TextColor[1], Fonts.GameFontNormal.TextColor[2], Fonts.GameFontNormal.TextColor[3], Fonts.GameFontNormal.TextColor[4])
	elephantTitleText:SetPoint("TOP", elephantTitle, "TOP", 0, -8)
	elephantTitleText:SetText("Elephant r" .. tonumber((string.gsub("$Revision: 102 $", "^.-(%d+).-$", "%1"))))
	
	local elphantTitleOverFrame = CreateFrame("Frame", "ElephantTitleOverFrame", self.gui.mainFrame)
	elphantTitleOverFrame:SetWidth(128)
	elphantTitleOverFrame:SetHeight(30)
	elphantTitleOverFrame:SetPoint("TOP", 0, 12)
	elphantTitleOverFrame:SetScript("OnEnter", function() self:PlaceTooltip(L['move'], "ANCHOR_RIGHT") end)
	elphantTitleOverFrame:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elphantTitleOverFrame:EnableMouse(true)
	elphantTitleOverFrame:SetScript("OnMouseDown", function(args)
		if arg1 == "RightButton" then
			self.gui.mainFrame:StartMoving()
		end
		if arg1 == "MiddleButton" then
			self:ResetPosition()
		end
	end)
	elphantTitleOverFrame:SetScript("OnMouseUp", function() self.gui.mainFrame:StopMovingOrSizing() end)
	
	local elephantTitleInfoFrame = CreateFrame("Frame", "ElephantTitleInfoFrame", self.gui.mainFrame)
	elephantTitleInfoFrame:SetAllPoints(self.gui.mainFrame)
	
	self.gui.titleInfoMaxLog = elephantTitleInfoFrame:CreateFontString()
	self.gui.titleInfoMaxLog:SetFont(Fonts.GameFontNormalSmall.Font[1], Fonts.GameFontNormalSmall.Font[2])
	self.gui.titleInfoMaxLog:SetTextColor(self.defaultConf.colors.maxlog.r, self.defaultConf.colors.maxlog.g, self.defaultConf.colors.maxlog.b, self.defaultConf.colors.maxlog.a)
	self.gui.titleInfoMaxLog:SetPoint("TOPRIGHT", self.gui.mainFrame, "TOPRIGHT", -60, -15)
	
	self.gui.titleInfoTab = elephantTitleInfoFrame:CreateFontString()
	self.gui.titleInfoTab:SetFont(Fonts.GameFontNormalSmall.Font[1], Fonts.GameFontNormalSmall.Font[2])
	self.gui.titleInfoTab:SetTextColor(self.defaultConf.colors.tab.r, self.defaultConf.colors.tab.g, self.defaultConf.colors.tab.b, self.defaultConf.colors.tab.a)
	self.gui.titleInfoTab:SetPoint("TOPLEFT", self.gui.mainFrame, "TOPLEFT", 35, -15)
	self.gui.titleInfoTab:SetText("< >")
	
	self.gui.titleInfoCurrentLine = elephantTitleInfoFrame:CreateFontString()
	self.gui.titleInfoCurrentLine:SetFont(Fonts.GameFontNormalSmall.Font[1], Fonts.GameFontNormalSmall.Font[2])
	self.gui.titleInfoCurrentLine:SetTextColor(self.defaultConf.colors.currentline.r, self.defaultConf.colors.currentline.g, self.defaultConf.colors.currentline.b, self.defaultConf.colors.currentline.a)
	self.gui.titleInfoCurrentLine:SetPoint("TOPLEFT", self.gui.mainFrame, "TOPLEFT", 175, -15)
	self.gui.titleInfoCurrentLine:SetText("0 / 0")
	
	self.gui.scrollingMessageFrame = CreateFrame("ScrollingMessageFrame", "ElephantScrollingMessageFrame", self.gui.mainFrame)
	self.gui.scrollingMessageFrame:SetFading(false)
	self.gui.scrollingMessageFrame:SetMaxLines(self.defaultConf.scrollmaxlines)
	self.gui.scrollingMessageFrame:SetWidth(525)
	self.gui.scrollingMessageFrame:SetHeight(500)
	self.gui.scrollingMessageFrame:SetPoint("TOPLEFT", 30, -30)
	self.gui.scrollingMessageFrame:EnableMouseWheel(true)
	self.gui.scrollingMessageFrame:CreateFontString()
	self.gui.scrollingMessageFrame:SetFont(Fonts.ChatFontNormal.Font[1], Fonts.ChatFontNormal.Font[2])
	self.gui.scrollingMessageFrame:SetJustifyH("LEFT")
	self.gui.scrollingMessageFrame:SetScript("OnHyperlinkClick", function(args) SetItemRef(arg1, arg2, arg3) end)
	self.gui.scrollingMessageFrame:SetScript("OnMouseWheel", function(args)
		if arg1 > 0 then self:Scroll(-self.defaultConf.scrollmouse) end
		if arg1 < 0 then self:Scroll(self.defaultConf.scrollmouse) end
	end)
	
	local elephantScrollingMessageFrameTexture = CreateFrame("Frame", "ElephantScrollingMessageFrameTexture", self.gui.mainFrame)
	elephantScrollingMessageFrameTexture:SetWidth(535)
	elephantScrollingMessageFrameTexture:SetHeight(510)
	elephantScrollingMessageFrameTexture:SetPoint("TOPLEFT", self.gui.mainFrame, "TOPLEFT", 25, -28)
	elephantScrollingMessageFrameTexture:SetBackdrop ( {
		bgFile = "Interface/ChatFrame/ChatFrameBackground",
		edgeFile = "Interface/Tooltips/UI-Tooltip-Border",
		tile = true,
		tileSize = 16,
		edgeSize = 16,
		insets = { left = 5, right = 5, top = 5, bottom = 5 },
	} )
	elephantScrollingMessageFrameTexture:SetBackdropColor( 0.0, 0.0, 0.0, 0.5 )
	
	local elephantButtonScrollBottom = CreateFrame("Button", "ElephantButtonScrollBottom", self.gui.mainFrame)
	elephantButtonScrollBottom:SetNormalTexture("Interface/PaperDollInfoFrame/UI-Character-SkillsPageDown-Up")
	elephantButtonScrollBottom:SetPushedTexture("Interface/PaperDollInfoFrame/UI-Character-SkillsPageDown-Down")
	elephantButtonScrollBottom:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	elephantButtonScrollBottom:SetWidth(32)
	elephantButtonScrollBottom:SetHeight(32)
	elephantButtonScrollBottom:SetPoint("BOTTOMLEFT", self.gui.scrollingMessageFrame, "BOTTOMRIGHT", 4, 0)
	elephantButtonScrollBottom:SetScript("OnEnter", function() self:SetTooltip(L['scroll']['bottom']) end)
	elephantButtonScrollBottom:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonScrollBottom:SetScript("OnClick", function()
		PlaySound("igChatBottom")
		self.tempConf.currentline = #self.db.char.logs[self.db.char.currentlogindex].logs
		self:ShowCurrentLog()
	end)
	
	local elephantButtonScrollPageDown = CreateFrame("Button", "ElephantButtonScrollPageDown", self.gui.mainFrame)
	elephantButtonScrollPageDown:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Up")
	elephantButtonScrollPageDown:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
	elephantButtonScrollPageDown:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	elephantButtonScrollPageDown:SetWidth(32)
	elephantButtonScrollPageDown:SetHeight(32)
	elephantButtonScrollPageDown:SetPoint("BOTTOM", elephantButtonScrollBottom, "TOP", 1, -5)
	elephantButtonScrollPageDown:SetScript("OnEnter", function() self:SetTooltip(L['scroll']['pagedown']) end)
	elephantButtonScrollPageDown:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonScrollPageDown:SetScript("OnClick", function()
		PlaySound("igChatScrollDown")
		self:Scroll(self.defaultConf.scrollpage)
	end)
	
	local elephantButtonScrollDown = CreateFrame("Button", "ElephantButtonScrollDown", self.gui.mainFrame)
	elephantButtonScrollDown:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Disabled")
	elephantButtonScrollDown:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollDown-Down")
	elephantButtonScrollDown:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	elephantButtonScrollDown:SetWidth(32)
	elephantButtonScrollDown:SetHeight(32)
	elephantButtonScrollDown:SetPoint("BOTTOM", elephantButtonScrollPageDown, "TOP", 0, -5)
	elephantButtonScrollDown:SetScript("OnEnter", function() self:SetTooltip(L['scroll']['linedown']) end)
	elephantButtonScrollDown:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonScrollDown:SetScript("OnClick", function()
		PlaySound("igChatScrollDown")
		self:Scroll(1)
	end)
	elephantButtonScrollDown:SetScript("OnUpdate", function()
		if elephantButtonScrollDown:GetButtonState() == "PUSHED" then
			self:Scroll(1)
		end
	end)
	
	local elephantButtonScrollUp = CreateFrame("Button", "ElephantButtonScrollUp", self.gui.mainFrame)
	elephantButtonScrollUp:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Disabled")
	elephantButtonScrollUp:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Down")
	elephantButtonScrollUp:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	elephantButtonScrollUp:SetWidth(32)
	elephantButtonScrollUp:SetHeight(32)
	elephantButtonScrollUp:SetPoint("BOTTOM", elephantButtonScrollDown, "TOP", 0, -5)
	elephantButtonScrollUp:SetScript("OnEnter", function() self:SetTooltip(L['scroll']['lineup']) end)
	elephantButtonScrollUp:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonScrollUp:SetScript("OnClick", function()
		PlaySound("igChatScrollUp")
		self:Scroll(-1)
	end)
	elephantButtonScrollUp:SetScript("OnUpdate", function()
		if elephantButtonScrollUp:GetButtonState() == "PUSHED" then
			self:Scroll(-1)
		end
	end)
	
	local elephantButtonScrollPageUp = CreateFrame("Button", "ElephantButtonScrollPageUp", self.gui.mainFrame)
	elephantButtonScrollPageUp:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Up")
	elephantButtonScrollPageUp:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-ScrollUp-Down")
	elephantButtonScrollPageUp:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	elephantButtonScrollPageUp:SetWidth(32)
	elephantButtonScrollPageUp:SetHeight(32)
	elephantButtonScrollPageUp:SetPoint("BOTTOM", elephantButtonScrollUp, "TOP", 0, -5)
	elephantButtonScrollPageUp:SetScript("OnEnter", function() self:SetTooltip(L['scroll']['pageup']) end)
	elephantButtonScrollPageUp:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonScrollPageUp:SetScript("OnClick", function()
		PlaySound("igChatScrollUp")
		self:Scroll(-self.defaultConf.scrollpage)
	end)
	
	local elephantButtonScrollTop = CreateFrame("Button", "ElephantButtonScrollTop", self.gui.mainFrame)
	elephantButtonScrollTop:SetNormalTexture("Interface/PaperDollInfoFrame/UI-Character-SkillsPageUp-Up")
	elephantButtonScrollTop:SetPushedTexture("Interface/PaperDollInfoFrame/UI-Character-SkillsPageUp-Down")
	elephantButtonScrollTop:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	elephantButtonScrollTop:SetWidth(32)
	elephantButtonScrollTop:SetHeight(32)
	elephantButtonScrollTop:SetPoint("BOTTOM", elephantButtonScrollPageUp, "TOP", -1, -5)
	elephantButtonScrollTop:SetScript("OnEnter", function() self:SetTooltip(L['scroll']['top']) end)
	elephantButtonScrollTop:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonScrollTop:SetScript("OnClick", function()
		PlaySound("igChatBottom")
		self.tempConf.currentline = #self.db.char.logs[self.db.char.currentlogindex].logs
		if self.tempConf.currentline > 1 then
			self.tempConf.currentline = 1
		end
		self:ShowCurrentLog()
	end)
	
	self.gui.elephantButtonCatchOptions = CreateFrame("Button", "ElephantButtonCatchOptions", self.gui.mainFrame)
	self.gui.elephantButtonCatchOptions:SetNormalTexture("Interface/ChatFrame/UI-ChatIcon-Chat-Up")
	self.gui.elephantButtonCatchOptions:SetPushedTexture("Interface/ChatFrame/UI-ChatIcon-Chat-Down")
	self.gui.elephantButtonCatchOptions:SetHighlightTexture("Interface/Buttons/UI-Common-MouseHilight")
	self.gui.elephantButtonCatchOptions:SetDisabledTexture("Interface/ChatFrame/UI-ChatIcon-Chat-Disabled")
	self.gui.elephantButtonCatchOptions:SetWidth(32)
	self.gui.elephantButtonCatchOptions:SetHeight(32)
	self.gui.elephantButtonCatchOptions:SetPoint("TOPLEFT", self.gui.scrollingMessageFrame, "TOPRIGHT", 5, 0)
	self.gui.elephantButtonCatchOptions:SetScript("OnEnter", function() self:SetTooltip(L['catchers']) end)
	self.gui.elephantButtonCatchOptions:SetScript("OnLeave", function() self:UnsetTooltip() end)
	self.dropdowns.catchOptions:Register(self.gui.elephantButtonCatchOptions,
		'children', function(...)
			self:DropdownCatchOptionsInitialize(...)
		end,
		'point', function()
			return "TOPRIGHT"
		end,
		'relativePoint', function()
			return "TOPLEFT"
		end
	)
	self.gui.elephantButtonCatchOptions:SetScript("OnClick", function()
		self.dropdowns.catchOptions:Open(self.gui.elephantButtonCatchOptions)
	end)
	
	local elephantButtonTabs = {}
	elephantButtonTabs.elephantButtonWhisperTab = CreateFrame("Button", "ElephantButtonWhisperTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonWhisperTab:SetNormalTexture("Interface/Minimap/Tracking/None")
	--elephantButtonTabs.elephantButtonWhisperTab:SetPushedTexture("Interface/Icons/Ability_Stealth")
	elephantButtonTabs.elephantButtonWhisperTab:SetHighlightTexture("Interface/Minimap/Tracking/None")
	elephantButtonTabs.elephantButtonWhisperTab:SetWidth(23)
	elephantButtonTabs.elephantButtonWhisperTab:SetHeight(23)
	elephantButtonTabs.elephantButtonWhisperTab:SetPoint("TOP", self.gui.elephantButtonCatchOptions, "BOTTOM", 0, -5)
	elephantButtonTabs.elephantButtonWhisperTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['whisper'], self:GetEnabledMsg(self.db.char.logs[self.defaultConf.defaultindexes.whisper].enabled), format(L['nblines'], #self.db.char.logs[self.defaultConf.defaultindexes.whisper].logs)} ) end)
	elephantButtonTabs.elephantButtonWhisperTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonTabs.elephantButtonWhisperTab:SetScript("OnClick", function() self:ChangeLog(self.defaultConf.defaultindexes.whisper) end)
	
	elephantButtonTabs.elephantButtonRaidTab = CreateFrame("Button", "ElephantButtonRaidTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonRaidTab:SetNormalTexture("Interface/Minimap/Tracking/Ammunition")
	--elephantButtonTabs.elephantButtonRaidTab:SetPushedTexture("Interface/Icons/INV_Misc_Head_Dragon_01")
	elephantButtonTabs.elephantButtonRaidTab:SetHighlightTexture("Interface/Minimap/Tracking/Ammunition")
	elephantButtonTabs.elephantButtonRaidTab:SetWidth(23)
	elephantButtonTabs.elephantButtonRaidTab:SetHeight(23)
	elephantButtonTabs.elephantButtonRaidTab:SetPoint("TOP", elephantButtonTabs.elephantButtonWhisperTab, "BOTTOM")
	elephantButtonTabs.elephantButtonRaidTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['raid'], self:GetEnabledMsg(self.db.char.logs[self.defaultConf.defaultindexes.raid].enabled), format(L['nblines'], #self.db.char.logs[self.defaultConf.defaultindexes.raid].logs)} ) end)
	elephantButtonTabs.elephantButtonRaidTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonTabs.elephantButtonRaidTab:SetScript("OnClick", function() self:ChangeLog(self.defaultConf.defaultindexes.raid) end)
	
	elephantButtonTabs.elephantButtonPartyTab = CreateFrame("Button", "ElephantButtonPartyTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonPartyTab:SetNormalTexture("Interface/GroupFrame/UI-Group-LeaderIcon")
	--elephantButtonTabs.elephantButtonPartyTab:SetPushedTexture("Interface/Icons/Spell_Holy_PrayerofSpirit")
	elephantButtonTabs.elephantButtonPartyTab:SetHighlightTexture("Interface/GroupFrame/UI-Group-LeaderIcon")
	elephantButtonTabs.elephantButtonPartyTab:SetWidth(23)
	elephantButtonTabs.elephantButtonPartyTab:SetHeight(23)
	elephantButtonTabs.elephantButtonPartyTab:SetPoint("TOP", elephantButtonTabs.elephantButtonRaidTab, "BOTTOM")
	elephantButtonTabs.elephantButtonPartyTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['party'], self:GetEnabledMsg(self.db.char.logs[self.defaultConf.defaultindexes.party].enabled), format(L['nblines'], #self.db.char.logs[self.defaultConf.defaultindexes.party].logs)} ) end)
	elephantButtonTabs.elephantButtonPartyTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonTabs.elephantButtonPartyTab:SetScript("OnClick", function() self:ChangeLog(self.defaultConf.defaultindexes.party) end)
	
	elephantButtonTabs.elephantButtonSayTab = CreateFrame("Button", "ElephantButtonSayTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonSayTab:SetNormalTexture("Interface/GossipFrame/GossipGossipIcon")
	--elephantButtonTabs.elephantButtonSayTab:SetPushedTexture("Interface/Icons/INV_Misc_Bomb_04")
	elephantButtonTabs.elephantButtonSayTab:SetHighlightTexture("Interface/GossipFrame/GossipGossipIcon")
	elephantButtonTabs.elephantButtonSayTab:SetWidth(23)
	elephantButtonTabs.elephantButtonSayTab:SetHeight(23)
	elephantButtonTabs.elephantButtonSayTab:SetPoint("TOP", elephantButtonTabs.elephantButtonPartyTab, "BOTTOM")
	elephantButtonTabs.elephantButtonSayTab:SetScript("OnEnter", function() self:SetTooltip( {L.chatnames.say, self:GetEnabledMsg(self.db.char.logs[self.defaultConf.defaultindexes.say].enabled), format(L['nblines'], #self.db.char.logs[self.defaultConf.defaultindexes.say].logs)} ) end)
	elephantButtonTabs.elephantButtonSayTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonTabs.elephantButtonSayTab:SetScript("OnClick", function() self:ChangeLog(self.defaultConf.defaultindexes.say) end)
	
	elephantButtonTabs.elephantButtonYellTab = CreateFrame("Button", "ElephantButtonYellTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonYellTab:SetNormalTexture("Interface/Buttons/UI-GuildButton-MOTD-Up")
	--elephantButtonTabs.elephantButtonYellTab:SetPushedTexture("Interface/Icons/Spell_Fire_Incinerate")
	elephantButtonTabs.elephantButtonYellTab:SetHighlightTexture("Interface/Buttons/UI-GuildButton-MOTD-Up")
	elephantButtonTabs.elephantButtonYellTab:SetWidth(23)
	elephantButtonTabs.elephantButtonYellTab:SetHeight(23)
	elephantButtonTabs.elephantButtonYellTab:SetPoint("TOP", elephantButtonTabs.elephantButtonSayTab, "BOTTOM")
	elephantButtonTabs.elephantButtonYellTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['yell'], self:GetEnabledMsg(self.db.char.logs[self.defaultConf.defaultindexes.yell].enabled), format(L['nblines'], #self.db.char.logs[self.defaultConf.defaultindexes.yell].logs)} ) end)
	elephantButtonTabs.elephantButtonYellTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonTabs.elephantButtonYellTab:SetScript("OnClick", function() self:ChangeLog(self.defaultConf.defaultindexes.yell) end)
	
	elephantButtonTabs.elephantButtonOfficerTab = CreateFrame("Button", "ElephantButtonOfficerTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonOfficerTab:SetNormalTexture("Interface/GossipFrame/AvailableQuestIcon")
	--elephantButtonTabs.elephantButtonOfficerTab:SetPushedTexture("Interface/Icons/Spell_Nature_EnchantArmor")
	elephantButtonTabs.elephantButtonOfficerTab:SetHighlightTexture("Interface/GossipFrame/AvailableQuestIcon")
	elephantButtonTabs.elephantButtonOfficerTab:SetWidth(23)
	elephantButtonTabs.elephantButtonOfficerTab:SetHeight(23)
	elephantButtonTabs.elephantButtonOfficerTab:SetPoint("TOP", elephantButtonTabs.elephantButtonYellTab, "BOTTOM")
	elephantButtonTabs.elephantButtonOfficerTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['officer'], self:GetEnabledMsg(self.db.char.logs[self.defaultConf.defaultindexes.officer].enabled), format(L['nblines'], #self.db.char.logs[self.defaultConf.defaultindexes.officer].logs)} ) end)
	elephantButtonTabs.elephantButtonOfficerTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonTabs.elephantButtonOfficerTab:SetScript("OnClick", function() self:ChangeLog(self.defaultConf.defaultindexes.officer) end)
	
	elephantButtonTabs.elephantButtonGuildTab = CreateFrame("Button", "ElephantButtonGuildTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonGuildTab:SetNormalTexture("Interface/Minimap/Tracking/Food")
	--elephantButtonTabs.elephantButtonGuildTab:SetPushedTexture("Interface/Icons/INV_Shirt_GuildTabard_01")
	elephantButtonTabs.elephantButtonGuildTab:SetHighlightTexture("Interface/Minimap/Tracking/Food")
	elephantButtonTabs.elephantButtonGuildTab:SetWidth(23)
	elephantButtonTabs.elephantButtonGuildTab:SetHeight(23)
	elephantButtonTabs.elephantButtonGuildTab:SetPoint("TOP", elephantButtonTabs.elephantButtonOfficerTab, "BOTTOM")
	elephantButtonTabs.elephantButtonGuildTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['guild'], self:GetEnabledMsg(self.db.char.logs[self.defaultConf.defaultindexes.guild].enabled), format(L['nblines'], #self.db.char.logs[self.defaultConf.defaultindexes.guild].logs)} ) end)
	elephantButtonTabs.elephantButtonGuildTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	elephantButtonTabs.elephantButtonGuildTab:SetScript("OnClick", function() self:ChangeLog(self.defaultConf.defaultindexes.guild) end)
	
	--[[ Custom chats & dropdown ]]
	elephantButtonTabs.elephantButtonCustomTab = CreateFrame("Button", "ElephantButtonCustomTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonCustomTab:SetNormalTexture("Interface/Cursor/Interact")
	--elephantButtonTabs.elephantButtonCustomTab:SetPushedTexture("Interface/Icons/Trade_Engineering")
	elephantButtonTabs.elephantButtonCustomTab:SetHighlightTexture("Interface/Cursor/Interact")
	elephantButtonTabs.elephantButtonCustomTab:SetWidth(23)
	elephantButtonTabs.elephantButtonCustomTab:SetHeight(23)
	elephantButtonTabs.elephantButtonCustomTab:SetPoint("TOP", elephantButtonTabs.elephantButtonGuildTab, "BOTTOM", 0, -25)
	elephantButtonTabs.elephantButtonCustomTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['custom']} ) end)
	elephantButtonTabs.elephantButtonCustomTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	self.dropdowns.customChats:Register(elephantButtonTabs.elephantButtonCustomTab,
		'children', function()
			self:DropdownCustomChatsInitialize()
		end,
		'point', function()
			return "TOPRIGHT"
		end,
		'relativePoint', function()
			return "TOPLEFT"
		end
	)
	elephantButtonTabs.elephantButtonCustomTab:SetScript("OnClick", function()
		self.dropdowns.customChats:Open(elephantButtonTabs.elephantButtonCustomTab)
	end)
	
	--[[ General chats & dropdown ]]
	elephantButtonTabs.elephantButtonGeneralTab = CreateFrame("Button", "ElephantButtonGeneralTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonGeneralTab:SetNormalTexture("Interface/Cursor/Speak")
	--elephantButtonTabs.elephantButtonGeneralTab:SetPushedTexture("Interface/Icons/Spell_Shadow_SoulGem")
	elephantButtonTabs.elephantButtonGeneralTab:SetHighlightTexture("Interface/Cursor/Speak")
	elephantButtonTabs.elephantButtonGeneralTab:SetWidth(23)
	elephantButtonTabs.elephantButtonGeneralTab:SetHeight(23)
	elephantButtonTabs.elephantButtonGeneralTab:SetPoint("TOP", elephantButtonTabs.elephantButtonCustomTab, "BOTTOM")
	elephantButtonTabs.elephantButtonGeneralTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['general']} ) end)
	elephantButtonTabs.elephantButtonGeneralTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	self.dropdowns.generalChats:Register(elephantButtonTabs.elephantButtonGeneralTab,
		'children', function()
			self:DropdownGeneralChatsInitialize()
		end,
		'point', function()
			return "TOPRIGHT"
		end,
		'relativePoint', function()
			return "TOPLEFT"
		end
	)
	elephantButtonTabs.elephantButtonGeneralTab:SetScript("OnClick", function()
		self.dropdowns.generalChats:Open(elephantButtonTabs.elephantButtonGeneralTab)
	end)
	
	--[[ Misc. dropdown ]]
	elephantButtonTabs.elephantButtonMiscTab = CreateFrame("Button", "ElephantButtonMiscTab", self.gui.mainFrame)
	elephantButtonTabs.elephantButtonMiscTab:SetNormalTexture("Interface/Cursor/Innkeeper")
	--elephantButtonTabs.elephantButtonMiscTab:SetPushedTexture("Interface/Icons/Spell_Frost_WindWalkOn")
	elephantButtonTabs.elephantButtonMiscTab:SetHighlightTexture("Interface/Cursor/Innkeeper")
	elephantButtonTabs.elephantButtonMiscTab:SetWidth(23)
	elephantButtonTabs.elephantButtonMiscTab:SetHeight(23)
	elephantButtonTabs.elephantButtonMiscTab:SetPoint("TOP", elephantButtonTabs.elephantButtonGeneralTab, "BOTTOM")
	elephantButtonTabs.elephantButtonMiscTab:SetScript("OnEnter", function() self:SetTooltip( {L['chatnames']['misc']} ) end)
	elephantButtonTabs.elephantButtonMiscTab:SetScript("OnLeave", function() self:UnsetTooltip() end)
	self.dropdowns.miscChats:Register(elephantButtonTabs.elephantButtonMiscTab,
		'children', function()
			self:DropdownMiscChatsInitialize()
		end,
		'point', function()
			return "TOPRIGHT"
		end,
		'relativePoint', function()
			return "TOPLEFT"
		end
	)
	elephantButtonTabs.elephantButtonMiscTab:SetScript("OnClick", function()
		self.dropdowns.miscChats:Open(elephantButtonTabs.elephantButtonMiscTab)
	end)
	
	self.gui.buttonDelete = CreateFrame("Button", "ElephantButtonDelete", self.gui.mainFrame, OptionsButtonTemplate)
	self.gui.buttonDelete:SetNormalTexture("Interface/Buttons/UI-DialogBox-Button-Up")
	self.gui.buttonDelete:SetPushedTexture("Interface/Buttons/UI-DialogBox-Button-Down")
	self.gui.buttonDelete:SetHighlightTexture("Interface/Buttons/UI-DialogBox-Button-Highlight")
	self.gui.buttonDelete:SetDisabledTexture("Interface/Buttons/UI-DialogBox-Button-Disabled")
	self.gui.buttonDelete:SetWidth(75)
	self.gui.buttonDelete:SetHeight(33)
	self.gui.buttonDelete:SetPoint("BOTTOMLEFT", self.gui.mainFrame, 20, 5)
	self.gui.buttonDelete:SetFontString(self.gui.buttonDelete:CreateFontString())
	self.gui.buttonDelete:GetFontString():SetPoint("TOP", self.gui.buttonDelete, "TOP", 0, -5)
	self.gui.buttonDelete:GetFontString():SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	self.gui.buttonDelete:GetFontString():SetText(DELETE)
	self.gui.buttonDelete:SetScript("OnClick", function()
		self:DeleteCurrentLog()
		self:ChangeLog(self.defaultConf.defaultlogindex)
		self:ShowCurrentLog()
	end)
	
	self.gui.buttonEnable = CreateFrame("Button", "ElephantButtonEnable", self.gui.mainFrame, OptionsButtonTemplate)
	self.gui.buttonEnable:SetNormalTexture("Interface/Buttons/UI-DialogBox-Button-Up")
	self.gui.buttonEnable:SetPushedTexture("Interface/Buttons/UI-DialogBox-Button-Down")
	self.gui.buttonEnable:SetHighlightTexture("Interface/Buttons/UI-DialogBox-Button-Highlight")
	self.gui.buttonEnable:SetWidth(75)
	self.gui.buttonEnable:SetHeight(33)
	self.gui.buttonEnable:SetPoint("BOTTOM", self.gui.mainFrame, 0, 5)
	self.gui.buttonEnable:SetFontString(self.gui.buttonEnable:CreateFontString())
	self.gui.buttonEnable:GetFontString():SetPoint("TOP", self.gui.buttonEnable, "TOP", 0, -5)
	self.gui.buttonEnable:GetFontString():SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	self.gui.buttonEnable:GetFontString():SetText(ENABLE)
	self.gui.buttonEnable:SetScript("OnClick", function() self:ToggleEnableCurrentLog() end)
	
	local elephantButtonEmpty = CreateFrame("Button", "ElephantButtonEmpty", self.gui.mainFrame, OptionsButtonTemplate)
	elephantButtonEmpty:SetNormalTexture("Interface/Buttons/UI-DialogBox-Button-Up")
	elephantButtonEmpty:SetPushedTexture("Interface/Buttons/UI-DialogBox-Button-Down")
	elephantButtonEmpty:SetHighlightTexture("Interface/Buttons/UI-DialogBox-Button-Highlight")
	elephantButtonEmpty:SetWidth(75)
	elephantButtonEmpty:SetHeight(33)
	elephantButtonEmpty:SetPoint("RIGHT", self.gui.buttonEnable, "LEFT")
	elephantButtonEmpty:SetFontString(elephantButtonEmpty:CreateFontString())
	elephantButtonEmpty:GetFontString():SetPoint("TOP", elephantButtonEmpty, "TOP", 0, -5)
	elephantButtonEmpty:GetFontString():SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	elephantButtonEmpty:GetFontString():SetText(L['Empty'])
	elephantButtonEmpty:SetScript("OnClick", function() StaticPopup_Show("ELEPHANT_EMPTY") end)
	
	self.gui.buttonCopy = CreateFrame("Button", "ElephantButtonCopy", self.gui.mainFrame, OptionsButtonTemplate)
	self.gui.buttonCopy:SetNormalTexture("Interface/Buttons/UI-DialogBox-Button-Up")
	self.gui.buttonCopy:SetPushedTexture("Interface/Buttons/UI-DialogBox-Button-Down")
	self.gui.buttonCopy:SetHighlightTexture("Interface/Buttons/UI-DialogBox-Button-Highlight")
	self.gui.buttonCopy:SetDisabledTexture("Interface/Buttons/UI-DialogBox-Button-Disabled")
	self.gui.buttonCopy:SetWidth(75)
	self.gui.buttonCopy:SetHeight(33)
	self.gui.buttonCopy:SetPoint("LEFT", self.gui.buttonEnable, "RIGHT")
	self.gui.buttonCopy:SetFontString(self.gui.buttonCopy:CreateFontString())
	self.gui.buttonCopy:GetFontString():SetPoint("TOP", self.gui.buttonCopy, "TOP", 0, -5)
	self.gui.buttonCopy:GetFontString():SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	self.gui.buttonCopy:GetFontString():SetText(L['copy'])
	self.gui.buttonCopy:SetScript("OnClick", function() self:ShowCopyWindow() end)
	
	local elephantButtonClose = CreateFrame("Button", "ElephantButtonClose", self.gui.mainFrame, OptionsButtonTemplate)
	elephantButtonClose:SetNormalTexture("Interface/Buttons/UI-DialogBox-Button-Up")
	elephantButtonClose:SetPushedTexture("Interface/Buttons/UI-DialogBox-Button-Down")
	elephantButtonClose:SetHighlightTexture("Interface/Buttons/UI-DialogBox-Button-Highlight")
	elephantButtonClose:SetWidth(75)
	elephantButtonClose:SetHeight(33)
	elephantButtonClose:SetPoint("BOTTOMRIGHT", -20, 5)
	elephantButtonClose:SetFontString(elephantButtonClose:CreateFontString())
	elephantButtonClose:GetFontString():SetPoint("TOP", elephantButtonClose, "TOP", 0, -5)
	elephantButtonClose:GetFontString():SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	elephantButtonClose:GetFontString():SetText(CLOSE)
	elephantButtonClose:SetScript("OnClick", function() self:Toggle() end)
	
	self:SetTitleInfoMaxLog()
	
	self.gui.mainFrame:Hide()
	
	--[[ Copy window ]]
	local elephantCopyFrameTitleText = getglobal("ElephantCopyFrameTitleText")
	local elephantCopyFrameScrollFrame = getglobal("ElephantCopyFrameScrollFrame")
	local elephantCopyFrameScrollFrameTexture = getglobal("ElephantCopyFrameScrollFrameTexture")
	self.gui.copyFrameScrollFrameEditBox = getglobal("ElephantCopyFrameScrollFrameEditBox")
	local elephantCopyFrameButtonHide = getglobal("ElephantCopyFrameButtonHide")
	self.gui.elephantCopyFrameButtonBBCode = getglobal("ElephantCopyFrameButtonBBCode")
	
	self.gui.copyFrame:EnableMouse()
	self.gui.copyFrame:SetPoint("TOP", self.defaultConf.copyposition.x, self.defaultConf.copyposition.y)
	self.gui.copyFrame:SetScript("OnEnter", function()
		elephantCopyFrameScrollFrame:UpdateScrollChildRect()
	end)
	
	elephantCopyFrameTitleText:SetText(L['copywindow'])
	
	self.gui.copyFrameScrollFrameEditBox:SetAutoFocus(false)
	self.gui.copyFrameScrollFrameEditBox:SetScript("OnEnter", function()
		elephantCopyFrameScrollFrame:UpdateScrollChildRect()
		self.gui.copyFrameScrollFrameEditBox:SetFocus()
	end)
	self.gui.copyFrameScrollFrameEditBox:SetScript("OnLeave", function()
		self.gui.copyFrameScrollFrameEditBox:ClearFocus()
	end)
	
	elephantCopyFrameScrollFrameTexture:SetBackdropColor(0.0, 0.0, 0.0, 0.45)
	
	elephantCopyFrameButtonHide:GetFontString():SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	elephantCopyFrameButtonHide:GetFontString():SetTextColor(Fonts.ChatFontNormal.TextColor[1], Fonts.ChatFontNormal.TextColor[2], Fonts.ChatFontNormal.TextColor[3], Fonts.ChatFontNormal.TextColor[4])
	elephantCopyFrameButtonHide:GetFontString():SetText(CLOSE)
	elephantCopyFrameButtonHide:SetScript("OnClick", function() self.gui.copyFrame:Hide() end)
	
	self.gui.elephantCopyFrameButtonBBCode:GetFontString():SetFont(Fonts.GameFontNormal.Font[1], Fonts.GameFontNormal.Font[2], "OUTLINE")
	self.gui.elephantCopyFrameButtonBBCode:GetFontString():SetTextColor(Fonts.ChatFontNormal.TextColor[1], Fonts.ChatFontNormal.TextColor[2], Fonts.ChatFontNormal.TextColor[3], Fonts.ChatFontNormal.TextColor[4])
	self.gui.elephantCopyFrameButtonBBCode:GetFontString():SetText(L['bbAndText'])
	
	--[[ Elephant button ]]
	if self.db.profile.button == true then
		self:CreateButton()
	end
	
	--[[ Creating own slashcommands ]]
	local options = {
		type = 'group',
		args = {
			toggle = {
				type = 'execute',
				name = L['toggle'],
				desc = L['toggle_desc'],
				func = function()
					self:Toggle()
				end,
			},
			togglebutton = {
				type = 'toggle',
				name = L['showbutton'],
				desc = L['showbutton_desc'],
				get = function()
					return self.db.profile.button
				end,
				set = function()
					self:ToggleButton()
				end,
			},
			prat = {
				type = 'toggle',
				name = L['prat'],
				desc = L['prat_desc'],
				get = function()
					return self.db.profile.prat
				end,
				set = function(v)
					self.db.profile.prat = v
					self:RegisterEventsRefresh()
				end,
				disabled = function()
					return not Prat
				end,
			},
			forcetimestamp = {
				type = 'toggle',
				name = L['forcetimestamp'],
				desc = L['forcetimestamp_desc'],
				get = function()
					return self.db.profile.forcetimestamp
				end,
				set = function(v)
					self.db.profile.forcetimestamp = v
				end,
				disabled = function()
					return (not Prat) or (not self.db.profile.prat)
				end,
			},
			filters = {
				type = 'group',
				name = L['Filters'],
				desc = L['Filters_desc'],
				args = {
					add = {
						type = 'text',
						name = NEW,
						desc = L['newfilter_desc'],
						get = false,
						set = function(arg1)
							if string.match(arg1, L['filterregex']) == nil then
								self:Print(format(L['filtererror'], arg1))
							else
								self:AddFilter(arg1)
							end
						end,
						usage = L['filterusage'],
					},
					delete = {
						type = 'text',
						name = DELETE,
						desc = L['deletefilter_desc'],
						get = false,
						set = function(arg1)
							self:DeleteFilter(arg1)
						end,
						validate = self.db.profile.filters,
					},
				},
			},
			log = { -- Command to enter
				type = 'group',
				name = L['logs'], -- Display name (i.e. the one displayed by the FuBar)
				desc = L['logs_desc'], -- Description of the item
				args = {
					clearall = {
						type = 'execute',
						name = L['clearallhelp'],
						desc = L['clearallhelp_desc'],
						func = function()
							StaticPopup_Show("ELEPHANT_CLEARALL")
						end,
					},
					default = {
						type = 'toggle',
						name = L['enableddefault'],
						desc = L['enableddefault_desc'],
						get = function()
							return self.db.profile.defaultlog
						end,
						set = function(isEnabled)
							self.db.profile.defaultlog = isEnabled
						end,
					},
					max = {
						type = 'range',
						name = L['maxlogwords'],
						desc = L['maxlogwords_desc'],
						min = self.defaultConf.minlogsize,
						max = self.defaultConf.maxlogsize,
						step = 1,
						get = function()
							return self.db.profile.maxlog
						end,
						set = function(nb)
							self:ChangeMaxLog(nb)
						end,
					},
					files = {
						type = 'group',
						name = L['files'],
						desc = L['files_desc'],
						args = {
							activate = {
								type = 'toggle',
								name = L['activate'],
								desc = L['activate_desc'],
								get = function()
									return self.db.profile.activate_log
								end,
								set = function(nv)
									self.db.profile.activate_log = nv
									self:ChatLogEnable(self.db.profile.chatlog)
									self:CombatLogEnable(self.db.profile.combatlog)
								end,
							},
							chat = {
								type = 'toggle',
								name = L['chatlog'],
								desc = L['chatlog_desc'],
								get = function()
									return self.db.profile.chatlog
								end,
								set = function(isEnabled)
									self.db.profile.chatlog = isEnabled
									self:ChatLogEnable(isEnabled)
								end,
								hidden = function()
									return not self.db.profile.activate_log
								end,
							},
							combat = {
								type = 'toggle',
								name = L['combatlog'],
								desc = L['combatlog_desc'],
								get = function()
									return self.db.profile.combatlog
								end,
								set = function(isEnabled)
									self.db.profile.combatlog = isEnabled
									self:CombatLogEnable(isEnabled)
								end,
								hidden = function()
									return not self.db.profile.activate_log
								end,
							},
						},
					},
				},
			},
			reset = {
				type = 'group',
				name = L['reset'],
				desc = L['reset_desc'],
				args = {
					all = {
						type = 'execute',
						name = L['resethelp'],
						desc = L['resethelp_desc'],
						func = function()
							StaticPopup_Show("ELEPHANT_RESET")
						end,
					},
					position = {
						type = 'execute',
						name = L['resetloc'],
						desc = L['resetloc_desc'],
						func = function()
							self:ResetPosition()
						end,
					},
				},
			},
		}
	}
	self:RegisterChatCommand( {"/elephant"}, options )
	self.OnMenuRequest = options
	
	--[[ Miscelleaneous elements status at loading ]]
	self:ChatLogEnable(self.db.profile.chatlog)
	self:CombatLogEnable(self.db.profile.combatlog)
	
	--[[ Checks & creates default log structures ]]
	self:InitDefaultLogStructures()
	self:AddHeaderToStructures()
end

function Elephant:OnEnable()
	--[[ Registering events ]]
	self:RegisterEventsRefresh()
	
	--[[ Displays default log ]]
	if not self.db.char.logs[self.db.char.currentlogindex] then
		self.db.char.currentlogindex = self.defaultConf.defaultlogindex
	end
	self.tempConf.currentline = #self.db.char.logs[self.db.char.currentlogindex].logs
	self:ShowCurrentLog()
end