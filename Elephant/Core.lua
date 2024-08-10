local L = AceLibrary("AceLocale-2.2"):new("Elephant")

--[[ Bindings ]]
BINDING_HEADER_ELEPHANT = "Elephant"
BINDING_NAME_TOGGLE = L['toggle']

--[[ Popup dialogs ]]
StaticPopupDialogs['ELEPHANT_CLEARALL'] = {
	text			= L['clearallpopup'][1],
	button1			= L['clearallpopup'][2],
	button2			= L['clearallpopup'][3],
	OnAccept		= function ()
		Elephant:ClearAllLogs()
	end,
	timeout			= 0,
	whileDead		= 1,
	hideOnEscape	= 1,
	showAlert		= 1,
}
StaticPopupDialogs['ELEPHANT_EMPTY'] = {
	text			= L['emptypopup'][1],
	button1			= L['emptypopup'][2],
	button2			= L['emptypopup'][3],
	OnAccept		= function ()
		Elephant:EmptyCurrentLog()
	end,
	timeout			= 0,
	whileDead		= 1,
	hideOnEscape	= 1,
	showAlert		= 1,
}
StaticPopupDialogs['ELEPHANT_RESET'] = {
	text			= L['resetpopup'][1],
	button1			= L['resetpopup'][2],
	button2			= L['resetpopup'][3],
	OnAccept		= function ()
		Elephant:Reset()
	end,
	timeout			= 0,
	whileDead		= 1,
	hideOnEscape	= 1,
	showAlert		= 1,
}

--[[ Creating AddOn ]]
Elephant				= AceLibrary("AceAddon-2.0"):new("AceDB-2.0", "AceConsole-2.0", "AceEvent-2.0", "FuBarPlugin-2.0")
local Elephant, self	= Elephant, Elephant

--[[ Cloning function, used for tables ]]
function Elephant:clone(o)
	local new = {}
	local i, v = next(o, nil)
	while i do
		if type(v)=="table" then
			v=self:clone(v)
		end
		new[i] = v
		i, v = next(o, i)
	end
	return new
end

--[[ Registering database ]]
Elephant:RegisterDB("ElephantDB", "ElephantDBPerChar")

--[[ Managing config ]]
Elephant.defaultConf = {
	--[[ Positions ]]
	position			= { x = 0, y = -150 },
	copyposition		= { x = 0, y = -175 },
	
	--[[ Log sizes / Scroll sizes ]]
	minlogsize			= 50,
	maxlogsize			= 1000,
	scrollmaxlines		= 35,
	scrollpage			= 20,
	scrollmouse			= 3,
	copywindowmaxlines	= 150,
	
	--[[ Custom colors for the main and copy frame ]]
	colors				= {
		maxlog			= { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
		tab				= { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
		currentline		= { r = 1.0, g = 1.0, b = 1.0, a = 1.0 },
		disabledchannel	= { r = 0.5, g = 0.5, b = 0.5, a = 1.0 }
	},
	
	--[[ Logs ]]
	defaultindexes		= {
		whisper		= 1,
		raid		= 2,
		party		= 3,
		say			= 4,
		yell		= 5,
		officer		= 6,
		guild		= 7,
		loot		= 8,
		system		= 9,
		achievement	= 10,
	},
	defaultnames		= {
		whisper		= L['chatnames']['whisper'],
		raid		= L['chatnames']['raid'],
		party		= L['chatnames']['party'],
		say			= L['chatnames']['say'],
		yell		= L['chatnames']['yell'],
		officer		= L['chatnames']['officer'],
		guild		= L['chatnames']['guild'],
		loot		= L['chatnames']['loot'],
		system		= L['chatnames']['system'],
		achievement	= L['chatnames']['achievement'],
	},
	defaultlogindex		= 1,
	defaultline			= 0,
	nomisc				= 7,
	
	--[[ Temp data for specific channels ]]
	lootmethod			= nil,
	masterlooter		= nil,
	
	--[[ Saved data ]]
	savedconfdefaults	= {
		chatlog			= false,
		combatlog		= false,
		defaultlog		= true,
		maxlog			= 250,
		maxcombatlog	= 500,
		button			= false,
		events			= {},
		filters			= {},
		prat			= false,
		activate_log	= false,
	},
	savedpercharconfdefaults = {
		logs			= {},
		currentlogindex	= 1,
	},
}

--[[ Registering temporary config ]]
Elephant.tempConf = {
	currentline = Elephant.defaultConf.defaultline,
}

--[[ Registering events & Default catchers ]]
Elephant.defaultConf.savedconfdefaults.events = {
	['CHAT_MSG_ACHIEVEMENT'] = {
		type = "ACHIEVEMENT",
		desc = CHAT_MSG_ACHIEVEMENT,
		channels = {
			[self.defaultConf.defaultindexes.achievement] = 0,
		}
	},
	['CHAT_MSG_BATTLEGROUND'] = {
		type = "BATTLEGROUND",
		desc = CHAT_MSG_BATTLEGROUND,
		channels = {
			[self.defaultConf.defaultindexes.raid] = -1,
		}
	},
	['CHAT_MSG_BATTLEGROUND_LEADER'] = {
		type = "BATTLEGROUND_LEADER",
		desc = CHAT_MSG_BATTLEGROUND_LEADER,
		channels = {
			[self.defaultConf.defaultindexes.raid] = -1,
		}
	},
	['CHAT_MSG_BG_SYSTEM_ALLIANCE'] = {
		type = "BG_SYSTEM_ALLIANCE",
		desc = CHAT_MSG_BG_SYSTEM_ALLIANCE,
		channels = {
			[self.defaultConf.defaultindexes.raid] = 1,
		}
	},
	['CHAT_MSG_BG_SYSTEM_HORDE'] = {
		type = "BG_SYSTEM_HORDE",
		desc = CHAT_MSG_BG_SYSTEM_HORDE,
		channels = {
			[self.defaultConf.defaultindexes.raid] = 1,
		}
	},
	['CHAT_MSG_BG_SYSTEM_NEUTRAL'] = {
		type = "BG_SYSTEM_NEUTRAL",
		desc = CHAT_MSG_BG_SYSTEM_NEUTRAL,
		channels = {
			[self.defaultConf.defaultindexes.raid] = 1,
		}
	},
	['CHAT_MSG_BN_WHISPER'] = {
		type = "BN_WHISPER",
		desc = CHAT_MSG_BN_WHISPER,
		channels = {
			[self.defaultConf.defaultindexes.whisper] = -1,
		},
	},
	['CHAT_MSG_BN_WHISPER_INFORM'] = {
		type = "BN_WHISPER_INFORM",
		desc = CHAT_MSG_BN_CONVERSATION,
		channels = {
			[self.defaultConf.defaultindexes.whisper] = -1,
		},
	},
	['CHAT_MSG_CHANNEL'] = {
		type = "CHANNEL",
	},
	['CHAT_MSG_CHANNEL_NOTICE'] = {
		type = "CHANNEL_NOTICE",
	},
	['CHAT_MSG_EMOTE'] = {
		type = "EMOTE",
		desc = CHAT_MSG_EMOTE,
		channels = {
			[self.defaultConf.defaultindexes.say] = 1,
		}
	},
	['CHAT_MSG_GUILD'] = {
		type = "GUILD",
		desc = CHAT_MSG_GUILD,
		channels = {
			[self.defaultConf.defaultindexes.guild] = -1,
		}
	},
	['CHAT_MSG_GUILD_ACHIEVEMENT'] = {
		type = "GUILD_ACHIEVEMENT",
		desc = CHAT_MSG_GUILD_ACHIEVEMENT,
		channels = {
			[self.defaultConf.defaultindexes.achievement] = -1,
			[self.defaultConf.defaultindexes.guild] = 0,
		}
	},
	['CHAT_MSG_LOOT'] = {
		type = "LOOT",
		desc = CHAT_MSG_LOOT,
		channels = {
			[self.defaultConf.defaultindexes.loot] = -1,
		}
	},
	['CHAT_MSG_MONSTER_EMOTE'] = {
		type = "MONSTER_EMOTE",
		desc = CHAT_MSG_MONSTER_EMOTE,
		channels = {
			[self.defaultConf.defaultindexes.say] = 1,
			[self.defaultConf.defaultindexes.raid] = 1,
		}
	},
	['CHAT_MSG_MONSTER_SAY'] = {
		type = "MONSTER_SAY",
		desc = CHAT_MSG_MONSTER_SAY,
		channels = {
			[self.defaultConf.defaultindexes.say] = 1,
		}
	},
	['CHAT_MSG_MONSTER_WHISPER'] = {
		type = "MONSTER_WHISPER",
		desc = CHAT_MSG_MONSTER_WHISPER,
		channels = {
			[self.defaultConf.defaultindexes.whisper] = 1,
		}
	},
	['CHAT_MSG_MONSTER_YELL'] = {
		type = "MONSTER_YELL",
		desc = CHAT_MSG_MONSTER_YELL,
		channels = {
			[self.defaultConf.defaultindexes.yell] = 1,
			[self.defaultConf.defaultindexes.raid] = 1,
		}
	},
	['CHAT_MSG_OFFICER'] = {
		type = "OFFICER",
		desc = CHAT_MSG_OFFICER,
		channels = {
			[self.defaultConf.defaultindexes.officer] = -1,
		}
	},
	['CHAT_MSG_PARTY'] = {
		type = "PARTY",
		desc = CHAT_MSG_PARTY,
		channels = {
			[self.defaultConf.defaultindexes.party] = -1,
			[self.defaultConf.defaultindexes.raid] = 0,
		}
	},
	['CHAT_MSG_PARTY_LEADER'] = {
		type = "PARTY_LEADER",
		desc = CHAT_MSG_PARTY_LEADER,
		channels = {
			[self.defaultConf.defaultindexes.party] = -1,
			[self.defaultConf.defaultindexes.raid] = 0,
		}
	},
	['CHAT_MSG_RAID'] = {
		type = "RAID",
		desc = CHAT_MSG_RAID,
		channels = {
			[self.defaultConf.defaultindexes.raid] = -1,
		}
	},
	['CHAT_MSG_RAID_LEADER'] = {
		type = "RAID_LEADER",
		desc = CHAT_MSG_RAID_LEADER,
		channels = {
			[self.defaultConf.defaultindexes.raid] = -1,
		}
	},
	['CHAT_MSG_RAID_WARNING'] = {
		type = "RAID_WARNING",
		desc = CHAT_MSG_RAID_WARNING,
		channels = {
			[self.defaultConf.defaultindexes.raid] = -1,
		}
	},
	['CHAT_MSG_SAY'] = {
		type = "SAY",
		desc = CHAT_MSG_SAY,
		channels = {
			[self.defaultConf.defaultindexes.say] = -1,
		}
	},
	['CHAT_MSG_SYSTEM'] = {
		type = "SYSTEM",
		desc = CHAT_MSG_SYSTEM,
		channels = {
			[self.defaultConf.defaultindexes.system] = -1,
		}
	},
	['CHAT_MSG_TEXT_EMOTE'] = {
		type = "TEXT_EMOTE",
		desc = CHAT_MSG_TEXT_EMOTE,
		channels = {
			[self.defaultConf.defaultindexes.say] = 1,
		}
	},
	['CHAT_MSG_WHISPER'] = {
		type = "WHISPER",
		desc = CHAT_MSG_WHISPER,
		channels = {
			[self.defaultConf.defaultindexes.whisper] = -1,
		}
	},
	['CHAT_MSG_WHISPER_INFORM'] = {
		type = "WHISPER_INFORM",
		desc = CHAT_MSG_WHISPER_INFORM,
		channels = {
			[self.defaultConf.defaultindexes.whisper] = -1,
		}
	},
	['CHAT_MSG_YELL'] = {
		type = "YELL",
		desc = CHAT_MSG_YELL,
		channels = {
			[self.defaultConf.defaultindexes.yell] = -1,
		}
	},
	['PARTY_LOOT_METHOD_CHANGED'] = {
		type = "SYSTEM",
		channels = {
			[self.defaultConf.defaultindexes.loot] = -1,
		}
	},
}

--[[ Registering database defaults: cloning objects to avoid problems ]]
Elephant:RegisterDefaults('profile', Elephant:clone(Elephant.defaultConf.savedconfdefaults))
Elephant:RegisterDefaults('char', Elephant:clone(Elephant.defaultConf.savedpercharconfdefaults))

--[[ Dropdowns ]]
Elephant.dropdowns				= {}
Elephant.dropdowns.customChats	= AceLibrary("Dewdrop-2.0")
Elephant.dropdowns.generalChats	= AceLibrary("Dewdrop-2.0")
Elephant.dropdowns.miscChats	= AceLibrary("Dewdrop-2.0")
Elephant.dropdowns.catchOptions	= AceLibrary("Dewdrop-2.0")

--[[ FuBarPlugin parameters ]]
Elephant.title					= "Elephant"
Elephant.hasIcon				= true
Elephant.cannotDetachTooltip	= true
Elephant.hasNoColor				= true
Elephant.defaultPosition		= "CENTER"
Elephant.hideWithoutStandby		= true
function Elephant:OnClick()
	self:Toggle()
end