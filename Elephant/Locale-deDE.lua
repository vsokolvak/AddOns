local L = AceLibrary("AceLocale-2.2"):new("Elephant")

--[[
Umlautersetzung: Unicode for Gemrman Umlauts
ä->\195\164; ö->\195\182; ü->\195\188; ß->\195\159
]]

L:RegisterTranslations("deDE", function() return {
	--[[ Common messages ]]
	['chatlog']				= "Chat in Datei speichern",
	['chatlog_desc']		= "Logs the chat (not the combat log) to Logs\\WoWChatLog.txt.\n\nNote: If this option is activated, the file logging will automatically be enabled back at login.",
	['combatlog']			= "Kampflog in Datei speichern",
	['combatlog_desc']		= "Logs the combat chat to Logs\\WoWCombatLog.txt.\n\nNote: If this option is activated, the file logging will automatically be enabled back at login.",
	['disabled']			= "Ausgeschaltet",
	['enabled']				= "Eingeschaltet",
	['enableddefault']		= "Logge neue Channels.",
	['enableddefault_desc']	= "Automaticaly starts logging when you join a new channel.",
	['noprat']				= "You choose to use Prat's formatting for logs but Prat is not loaded. Messages will be logged with Elephant's formatting.",
	['reset']				= "Zur\195\188cksetzen",
	['toggle']				= "Elephant \195\182ffnen/schlie\195\159en",
	['toggle_desc']			= "Shows or hides the main window.",
	
	--[[ Options menu elements ]]
	['activate']			= "Activate",
	['activate_desc']		= "Let Elephant control file logging. Disabling this option will leave the current logging status unchanged.\n\nWarning: You shouldn't let two different addons control the file logging.",
	['clearallhelp']		= "L\195\182scht alle Logs",
	['clearallhelp_desc']	= "Clears all the saved logs.",
	['Filters']				= FILTERS,
	['files_desc']			= "Options to save the logs into files.",
	['filterusage']			= "Exact channel name. You can also use wildcards (*). Ex: <AceComm*>",
	['filtererror']			= "Cannot add filter '%s'. Filter must contain only letters and wildcards (*).",
	['filterregex']			= "^[%a%*]+$",
	['newfilter_desc']		= "Creates a new filter.",
	['deletefilter_desc']	= "Deletes a previously created filter.",
	['logs']				= "Logs",
	['logs_desc']			= "Logging options.",
	['maxlogwords']			= "Maximale Logl/195/164nge",
	['maxlogwords_desc']	= "Maximum size of each log.",
	['prat']				= "Save logs with Prat formatting",
	['prat_desc']			= "Saves the logs the same way than Prat. Logs saved with this option enabled cannot be brought back to Elephant's default logging style.\n\nThis option is only available if you have Prat currently enabled.",
	['resethelp']			= "Setzt alle Einstellungen und Chats zur\195\188ck",
	['resethelp_desc']		= "Resets all settings and chats.",
	['resetloc']			= "Positionen der Fenster zur\195\188cksetzen",
	['resetloc_desc']		= "Resets Elephant's main window position.",
	['showbutton']			= "Zeige Schalter",
	['showbutton_desc']		= "Displays a button over the normal chat buttons to toggle Elephant.",
	
	--[[ Main/Copy frame elements ]]
	-- Main
	['catchers']	= {
		[1]	= "Message catchers",
		[2]	= "What should be saved in this log?",
		[3]	= "Message types in grey cannot be disabled."
	},
	['clearall']		= "Alle Leeren",
	['copy']			= "Kopieren",
	['Disable']			= DISABLE,
	['Empty']			= EMPTY,
	['Enable']			= ENABLE,
	['maxlog']			= "Maximal %s Zeilen.",
	['nblines']			= "Zeilen: %s",
	['scroll']			= {
		['bottom']		= {
			[1]	= "Zum Ende scrollen",
		},
		['linedown']	= {
			[1]	= "Eine Zeile runter scrollen",
		},
		['lineup']		= {
			[1]	= "Eine Zeile hoch scrollen",
		},
		['pagedown']	= {
			[1]	= "Eine Seite runter scrollen",
		},
		['pageup']		= {
			[1]	= "Eine Seite hoch scrollen",
		},
		['top']			= {
			[1]	= "Zum Anfang scrollen",
		},
	},
	
	-- Copy
	['copywindow']	= "Chat Kopieren",
	
	--[[ Special log messages ]]
	['logstartedon']	= "Log gestartet am %s up %s.",
	['logstopped']		= "Log gestoppt.",
	['monstersay']		= "%s sagt",
	['monsteryell']		= "%s schreit",
	['whisperfrom']		= "%s fl\195\188stert",
	['whisperto']		= "Zu %s",
	
	--[[ Addon messages ]]
	['clearallconfirm']		= "Logs geleert.",
	['combatlogdisabled']	= "Diese Funktion ist deaktiviert.",
	['deleteconfirm']		= "Chat gel\195\182scht: %s",
	['emptyconfirm']		= "Log geleert: %s",
	['lootmethod']			= {
		['freeforall']		= ERR_SET_LOOT_FREEFORALL,
		['group']			= ERR_SET_LOOT_GROUP,
		['master']			= ERR_SET_LOOT_MASTER,
		['needbeforegreed']	= ERR_SET_LOOT_NBG,
		['roundrobin']		= ERR_SET_LOOT_ROUNDROBIN,
	},
	['masterlooterchanged']	=  ERR_NEW_LOOT_MASTER_S,
	['resetconfirm']		= "Alle Einstellungen und Chats zur\195\188ckgesetzt.",
	
	--[[ Tooltips ]]
	['togglebuttontooltip']		= {
		[1]	= "Linksklicken um Elephant ein-/auszuschalten.",
		[2]	= "Mittelklicken um die Schalterposition zur\195\188ck zu setzten.",
		[3]	= "Rechtsklicken um den Schalter zu bewegen.",
	},
	['toggletooltip']			= "Linksklick, um Elephant anzuzeigen/zu verstecken.",
	
	--[[ Popup windows ]]
	['clearallpopup']	= {
		[1]	= "Dies l\195\182scht alle Logs.",
		[2]	= "Ok",
		[3]	= "Abbruch",
	},
	['emptypopup']		= {
		[1]	= "Dies leert das aktuelle Log.",
		[2]	= "Ok",
		[3]	= "Abbruch",
	},
	['resetpopup']		= {
		[1]	= "Dies setzt alle Einstellungen und Chats zur\195\188ck.",
		[2]	= "Ok",
		[3]	= "Abbruch",
	},
	
	--[[ Default chat names to be displayed ]]
	['chatnames']	= {
		['combat']	= "Kampf",
		['custom']	= "Eigene Chats",
		['general']	= "Allgemeine Chats",
		['guild']	= CHAT_MSG_GUILD,
		['loot']	= CHAT_MSG_LOOT,
		['misc']	= "Misc.",
		['officer']	= CHAT_MSG_OFFICER,
		['party']	= CHAT_MSG_PARTY,
		['raid']	= CHAT_MSG_RAID,
		['say']		= CHAT_MSG_SAY,
		['system']	= SYSTEM_MESSAGES,
		['whisper']	= WHISPER,
		['yell']	= YELL_MESSAGE,
	},
	
	--[[ General chats (= that you cannot leave) names and strings that identify them ]]
	['generalchats']	= {
		['allgemein']			= {
			['name']	= "Allgemein",
			['string']	= "allgemein",
		},
		['gildenrekrutierung']	= {
			['name']	= "Gildenrekrutierung",
			['string']	= "gildenrekrutierung",
		},
		['handel']				= {
			['name']	= "Handel",
			['string']	= "handel",
		},
		['lokaleverteidigung']	= {
			['name']	= "LokaleVerteidigung",
			['string']	= "lokaleverteidigung",
		},
		['weltverteidigung']	= {
			['name']	= "WeltVerteidigung",
			['string']	= "weltverteidigung",
		},
	},
	
	--[[ Custom chats special log messages ]]
	['customchat']	= {
		['join']	= "Channel beigetreten.",
		['leave']	= "Channel verlassen.",
	},
} end)