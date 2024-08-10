local L = AceLibrary("AceLocale-2.2"):new("Elephant")

L:RegisterTranslations("frFR", function() return {
	--[[ Common messages ]]
	['chatlog']				= "Enreg. le chat",
	['chatlog_desc']		= "Enregistre le chat (pas le journal de combat) vers Logs\\WoWChatLog.txt.\n\nNote: Si cette option est activée, l'enregistrement vers le fichier sera automatiquement rétabli à l'entrée en jeu.",
	['combatlog']			= "Enreg. le journal de combat",
	['combatlog_desc']		= "Enregistre le journal de combat vers Logs\\WoWCombatLog.txt.\n\nNote: Si cette option est activée, l'enregistrement vers le fichier sera automatiquement rétabli à l'entrée en jeu.",
	['disabled']			= "Désactivé",
	['enabled']				= "Activé",
	['enableddefault']		= "Logger nouv. chats",
	['enableddefault_desc']	= "Débute automatiquelent le log quand vous rejoinez un nouveau canal de discussion.",
	['noprat']				= "Vous avez choisi d'utiliser le formatage de Prat pour les logs mais Prat n'est pas chargé.Les messages seront enregistrés au format d'Elephant.",
	['reset']				= "Réinitialisation",
	['reset_desc']			= "Options de réinitialisation.",
	['toggle']				= "Afficher/Cacher Elephant",
	['toggle_desc']			= "Affiche ou cache la fenêtre principale.",
	
	--[[ Options menu elements ]]
	['activate']			= "Activer",
	['activate_desc']		= "Autorise Elephant à contrôler l'enregistrement vers des fichiers. En désactivant cette option, vous laisserez le statut d'enregistrement actuel intact.\n\nAttention: vous ne devriez pas laisser deux addons différent contrôler l'enregistrement vers des fichiers.",
	['clearallhelp']		= "Vider tous les logs",
	['clearallhelp_desc']	= "Supprimer tous les logs enregistrés.",
	['files']				= "Enregistrement vers fichier",
	['files_desc']			= "Options pour enregistrer les logs vers des fichiers.",
	['Filters']				= FILTERS,
	['Filters_desc']		= "Les filtres sont utilisés pour éviter l'enregistrement de canaux spécifiques.",
	['filterusage']			= "Nom exact du canal. Vous pouvez aussi utiliser des jokers (*). Ex: <AceComm*>",
	['filtererror']			= "Filtre erroné: '%s'. Les filtres ne peuvent contenir que des lettres et des jokers (*).",
	['filterregex']			= "^[%a%*]+$",
	['forcetimestamp']		= "Forcer l'heure dans les logs",
	['forcetimestamp_desc']	= "Ajoute l'heure dans les logs si Prat est utilisé. Ceci est utile lorsque vous voulez voir l'heure dans les logs mais que vous ne les affichez pas dans la fenêtre de discussion\n\nCette option n'est disponible que si vous utilisez Prat et que vous enregistrez les logs dans ce format.",
	['newfilter_desc']		= "Créer un nouveau filtre.",
	['deletefilter_desc']	= "Supprime un filtre précédemment créé.",
	['logs']				= "Logs",
	['logs_desc']			= "Options des logs.",
	['maxlogwords']			= "Taille de log max",
	['maxlogwords_desc']	= "Taille maximale de chaque log.",
	['prat']				= "Enregistre les logs au format de Prat",
	['prat_desc']			= "Entregistre les logs de la même façon que Prat. Les logs enregistrés de cette façon ne peuvent pas être rétablis vers le style par défaut d'Elephant.\n\nCette option n'est disponible que si vous avez Prat d'activé.",
	['resethelp']			= "Configuration",
	['resethelp_desc']		= "Réinitialise la configuration et les canaux de discussion.",
	['resetloc']			= "Position",
	['resetloc_desc']		= "Réinitialise la position de la fenêtre principale d'Elephant.",
	['showbutton']			= "Afficher boutton",
	['showbutton_desc']		= "Affiche un bouton au-dessus des boutons par défaut de la fenêtre de discussion, qui permet de basculer l'affichage d'Elephant.",
	
	--[[ Main/Copy frame elements ]]
	-- Main
	['catchers']	= {
		[1]	= "Messages à enregistrer",
		[2]	= "Que faut-il sauver dans ce log?",
		[3]	= "Les types de messages en gris ne",
		[4]	= "peuvent être désactivés."
	},
	['clearall']	= "Tout vider",
	['copy']		= "Copier",
	['Disable']		= DISABLE,
	['Empty']		= EMPTY,
	['Enable']		= ENABLE,
	['maxlog']		= "Log max: %s lignes.",
	['move']		= {
		[1]	= "Clic droit pour bouger Elephant",
		[2]	= "Clic central pour réinit. la position d'Elephant.",
	},
	['nblines']		= "Lignes: %s",
	['scroll']	= {
		['bottom']		= {
			[1]	= "Atteindre le bas",
		},
		['linedown']	= {
			[1]	= "Descendre d'une ligne",
		},
		['lineup']		= {
			[1]	= "Monter d'une ligne",
		},
		['pagedown']	= {
			[1]	= "Descendre d'une page",
		},
		['pageup']		= {
			[1]	= "Monter d'une page",
		},
		['top']			= {
			[1]	= "Atteindre le haut",
		},
	},
	
	-- Copy
	['bbAndText']		= "BB/Texte",
	['copywindow']		= "Fenêtre de copie",
	['itemLinkSite']	= "http://fr.wowhead.com/?item=",
	
	--[[ Special log messages ]]
	['logstartedon']	= "Log commencé le %s à %s.",
	['logstopped']		= "Log arrêté.",
	['monstersay']		= "%s says",
	['monsteryell']		= "%s crie",
	['whisperfrom']		= "%s chuchote",
	['whisperto']		= "A %s",
	
	--[[ Addon messages ]]
	['clearallconfirm']		= "Tous les logs ont été vidé",
	['combatlogdisabled']	= "Cette fonction est désactivée",
	['deleteconfirm']		= "Chat supprimé: %s",
	['emptyconfirm']		= "Chat vidé: %s",
	['lootmethod']			= {
		['freeforall']		= ERR_SET_LOOT_FREEFORALL,
		['group']			= ERR_SET_LOOT_GROUP,
		['master']			= ERR_SET_LOOT_MASTER,
		['needbeforegreed']	= ERR_SET_LOOT_NBG,
		['roundrobin']		= ERR_SET_LOOT_ROUNDROBIN,
	},
	['masterlooterchanged']	=  ERR_NEW_LOOT_MASTER_S,
	['resetconfirm']		= "Paramètres et chats réinitialisés",
	
	--[[ Tooltips ]]
	['togglebuttontooltip']		= {
		[1]	= "Clic gauche pour afficher/cacher Elephant",
		[2]	= "Clic central pour réinit. le bouton.",
		[3]	= "Clic droit pour bouger le bouton.",
	},
	['toggletooltip']			= "Clic gauche pour afficher/cacher Elephant.",
	
	--[[ Popup windows ]]
	['clearallpopup']	= {
		[1]	= "Ceci va vider tous les logs.",
		[2]	= "Ok",
		[3]	= "Annuler",
	},
	['emptypopup']		= {
		[1]	= "Ceci videra le log en cours.",
		[2]	= "Ok",
		[3]	= "Annuler",
	},
	['resetpopup']		= {
		[1]	= "Ceci réinitialisera tous les paramêtres et chats.",
		[2]	= "Ok",
		[3]	= "Annuler",
	},
	
	--[[ Default chat names to be displayed ]]
	['chatnames']	= {
		['combat']		= "Combat",
		['custom']		= "Chats personnalisés",
		['general']		= "Chats généraux",
		['guild']		= CHAT_MSG_GUILD,
		['loot']		= CHAT_MSG_LOOT,
		['misc']		= "Divers",
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
		['commerce']	= {
			['name']	= "Commerce",
			['string']	= "commerce",
		},
		['défenselocale']		= {
			['name']	= "DéfenseLocale",
			['string']	= "défenselocale",
		},
		['défenseuniverselle']	= {
			['name']	= "DéfenseUniverselle",
			['string']	= "défenseuniverselle",
		},
		['général']				= {
			['name']	= "Général",
			['string']	= "général",
		},
		['recherchedegroupe']		= {
			['name']	= "Recherche de groupe",
			['string']	= "recherchedegroupe",
		},
		['recrutementdeguilde']	= {
			['name']	= "RecrutementDeGuilde",
			['string']	= "recrutementdeguilde",
		},
	},
	
	--[[ Custom chats special log messages ]]
	['customchat']	= {
		['join']	= "Vous rejoignez un canal.",
		['leave']	= "Vous quittez un canal.",
	},
} end)