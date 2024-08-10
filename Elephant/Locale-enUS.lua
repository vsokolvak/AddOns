local L = AceLibrary("AceLocale-2.2"):new("Elephant")

L:RegisterTranslations("enUS", function() return {
	--[[ Common messages ]]
	['chatlog']				= "Log the chat to a file",
	['chatlog_desc']		= "Logs the chat (not the combat log) to Logs\\WoWChatLog.txt.\n\nNote: If this option is activated, the file logging will automatically be enabled back at login.",
	['combatlog']			= "Log the combat chat to a file",
	['combatlog_desc']		= "Logs the combat chat to Logs\\WoWCombatLog.txt.\n\nNote: If this option is activated, the file logging will automatically be enabled back at login.",
	['disabled']			= "Disabled",
	['enabled']				= "Enabled",
	['enableddefault']		= "Log new channels",
	['enableddefault_desc']	= "Automaticaly starts logging when you join a new channel.",
	['noprat']				= "You choose to use Prat's formatting for logs but Prat is not loaded. Messages will be logged with Elephant's formatting.",
	['reset']				= "Reset",
	['reset_desc']			= "Reset options.",
	['toggle']				= "Toggle",
	['toggle_desc']			= "Shows or hides the main window.",
	
	--[[ Options menu elements ]]
	['activate']			= "Activate",
	['activate_desc']		= "Let Elephant control file logging. Disabling this option will leave the current logging status unchanged.\n\nWarning: You shouldn't let two different addons control the file logging.",
	['clearallhelp']		= "Clear",
	['clearallhelp_desc']	= "Clears all the saved logs.",
	['files']				= "File logging",
	['files_desc']			= "Options to save the logs into files.",
	['Filters']				= FILTERS,
	['Filters_desc']		= "Filters are used to avoid the logging of specific channels.",
	['filterusage']			= "Exact channel name. You can also use wildcards (*). Ex: <AceComm*>",
	['filtererror']			= "Cannot add filter '%s'. Filter must contain only letters and wildcards (*).",
	['filterregex']			= "^[%a%*]+$",
	['forcetimestamp']		= "Force timestamps in logs",
	['forcetimestamp_desc']	= "Always adds timestamps in the logs if Prat is used. This is useful when you want timestamps to appear in the logs when you did not activate them in the chat.\n\nThis option is only available if you have Prat currently enabled and that you use Prat formatting.",
	['newfilter_desc']		= "Creates a new filter.",
	['deletefilter_desc']	= "Deletes a previously created filter.",
	['logs']				= "Logs",
	['logs_desc']			= "Logging options.",
	['maxlogwords']			= "Max log",
	['maxlogwords_desc']	= "Maximum size of each log.",
	['prat']				= "Prat formatting",
	['prat_desc']			= "Saves the logs the same way than Prat. Logs saved with this option enabled cannot be brought back to Elephant's default logging style.\n\nThis option is only available if you have Prat currently enabled.",
	['resethelp']			= "Settings",
	['resethelp_desc']		= "Resets all settings and chats.",
	['resetloc']			= "Position",
	['resetloc_desc']		= "Resets Elephant's main window position.",
	['showbutton']			= "Show button",
	['showbutton_desc']		= "Displays a button over the normal chat buttons to toggle Elephant.",
	
	--[[ Main/Copy frame elements ]]
	-- Main
	['catchers']	= {
		[1]	= "Message catchers",
		[2]	= "What should be saved in this log?",
		[3]	= "Message types in grey cannot be disabled."
	},
	['clearall']	= "Clear all",
	['copy']		= "Copy",
	['Disable']		= DISABLE,
	['Empty']		= EMPTY,
	['Enable']		= ENABLE,
	['maxlog']		= "Max log: %s lines.",
	['move']		= {
		[1]	= "Right-Click to move Elephant",
		[2]	= "Middle-Click to reset Elephant position.",
	},
	['nblines']		= "Lines: %s",
	['scroll']		= {
		['bottom']		= {
			[1]	= "Scroll to bottom",
		},
		['linedown']	= {
			[1]	= "Scroll one line down",
		},
		['lineup']		= {
			[1]	= "Scroll one line up",
		},
		['pagedown']	= {
			[1]	= "Scroll one page down",
		},
		['pageup']		= {
			[1]	= "Scroll one page up",
		},
		['top']			= {
			[1]	= "Scroll to top",
		},
	},
	
	-- Copy
	['bbAndText']		= "BB/Text",
	['copywindow']		= "Copy window",
	['itemLinkSite']	= "http://www.wowhead.com/?item=",
	
	--[[ Special log messages ]]
	['logstartedon']	= "Logging started on %s at %s.",
	['logstopped']		= "Logging stopped.",
	['monstersay']		= "%s says",
	['monsteryell']		= "%s yells",
	['whisperfrom']		= "%s whispers",
	['whisperto']		= "To %s",
	
	--[[ Addon messages ]]
	['clearallconfirm']		= "All chats cleared.",
	['combatlogdisabled']	= "This function is disabled.",
	['deleteconfirm']		= "Chat deleted: %s",
	['emptyconfirm']		= "Chat cleared: %s",
	['lootmethod']			= {
		['freeforall']		= ERR_SET_LOOT_FREEFORALL,
		['group']			= ERR_SET_LOOT_GROUP,
		['master']			= ERR_SET_LOOT_MASTER,
		['needbeforegreed']	= ERR_SET_LOOT_NBG,
		['roundrobin']		= ERR_SET_LOOT_ROUNDROBIN,
	},
	['masterlooterchanged']	=  ERR_NEW_LOOT_MASTER_S,
	['resetconfirm']		= "Reseted all settings and chats.",
	
	--[[ Tooltips ]]
	['togglebuttontooltip']		= {
		[1]	= "Left-Click to toggle Elephant",
		[2]	= "Middle-Click to reset button position.",
		[3]	= "Right-Click to move button.",
	},
	['toggletooltip']			= "Left-Click to toggle Elephant.",
	
	--[[ Popup windows ]]
	['clearallpopup']	= {
		[1]	= "This will clear all logs.",
		[2]	= "Ok",
		[3]	= "Cancel",
	},
	['emptypopup']		= {
		[1]	= "This will clear the current log.",
		[2]	= "Ok",
		[3]	= "Cancel",
	},
	['resetpopup']		= {
		[1]	= "This will reset all settings and chats.",
		[2]	= "Ok",
		[3]	= "Cancel",
	},
	
	--[[ Default chat names to be displayed ]]
	['chatnames']	= {
		['combat']		= "Combat",
		['custom']		= "Custom chats",
		['general']		= "General chats",
		['guild']		= CHAT_MSG_GUILD,
		['loot']		= CHAT_MSG_LOOT,
		['misc']		= "Misc.",
		['officer']		= CHAT_MSG_OFFICER,
		['party']		= CHAT_MSG_PARTY,
		['raid']		= CHAT_MSG_RAID,
		['say']			= CHAT_MSG_SAY,
		['system']		= SYSTEM_MESSAGES,
		['whisper']		= WHISPER,
		['yell']		= YELL_MESSAGE,
		['achievement']	= ACHIEVEMENTS,
	},
	
	--[[ General chats (= that you cannot leave) names and strings that identify them ]]
	['generalchats']	= {
		['localdefense']		= {
			['name']	= "Local defense",
			['string']	= "localdefense",
		},
		['lookingforgroup']		= {
			['name']	= "Looking for group",
			['string']	= "lookingforgroup",
		},
		['general']				= {
			['name']	= "General",
			['string']	= "general",
		},
		['guildrecruitment']	= {
			['name']	= "Guild recruitment",
			['string']	= "guildrecruitment",
		},
		['trade']				= {
			['name']	= "Trade",
			['string']	= "trade",
		},
		['worlddefense']		= {
			['name']	= "World defense",
			['string']	= "worlddefense",
		},
	},
	
	--[[ Custom chats special log messages ]]
	['customchat']	= {
		['join']	= "You joined channel.",
		['leave']	= "You left channel.",
	},
} end)