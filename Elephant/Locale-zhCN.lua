	--Chinese Local : CWDG Translation Team 月色狼影
	--CWDG site: http://cwowaddon.com  Chinese Addon/UI download center.
	--$Rev: 79 $
	--$Date: 2008-10-22 18:42:13 +0000 (Wed, 22 Oct 2008) $

local L = AceLibrary("AceLocale-2.2"):new("Elephant")

L:RegisterTranslations("zhCN", function() return {
	--[[ Common messages ]]
	['chatlog']			= "将聊天记录保存为文件",
	['chatlog_desc']		= "将聊天记录(不包含战斗记录)保存到Logs\\WoWChatLog.txt.\n\n注意: 如果此选项已经打开, 登录游戏后将自动启用.",
	['combatlog']		= "将战斗记录保存为文件",
	['combatlog_desc']		= "保存战斗记录到Logs\\WoWCombatLog.txt.\n\n注意: 如果此选项已经打开, 登录游戏后将自动启用.",
	['disabled']		= "被禁用",
	['enabled']			= "已启用",
	['enableddefault']	= "记录新频道",
	['enableddefault_desc']	= "当加入一新频道自动开始记录内容",
	['noprat']			= "你选择使用Prat的格式记录但Prat未记录.信息将被记录成Elephant格式.",
	['reset']			= "重置",
	['reset_desc']			= "重置设置.",
	['toggle']			= "显示Elephant",
	['toggle_desc']			= "显示/隐藏面板",
	
	--[[ Options menu elements ]]
	['activate']			= "激活",
	['activate_desc']		= "让Elephant控制文件记录. 禁用此选项将离开当前记录状态.\n\n警告: 你无法同时让两个插件控制文件记录(比如Prat和Elephant)",
	['clearallhelp']		= "清除所有记录",
	['clearallhelp_desc']	= "清除所有保存的记录",
	['files']				= "文件记录",
	['files_desc']			= "保存记录文本到文件中.",
	['Filters']				= "过滤器",
	['Filters_desc']		= "过滤器用来屏蔽记录特殊的频道",
	['filterusage']			= "频道全称. 你也可以使用通配符(*). 例: <AceComm*>",
	['filtererror']			= "不能增加过滤器 ‘%s’. 过滤器只能包括非空白字符以及通配符(*).",
	['filterregex']			= "^[%S%*]+$",
	['newfilter_desc']		= "创建一个新过滤器.",
	['deletefilter_desc']	= "删除先前创建的过滤器",
	['logs']				= "日志",
	['logs_desc']			= "记录选项.",
	['maxlogwords']			= "最大记录长度",
	['maxlogwords_desc']	= "每个记录文本最大记录行数.",
	['prat']				= "保存记录为Prat格式",
	['prat_desc']			= "保存记录为Prat格式. 设置此选项后所保存的聊天记录不在为Elephant的默认保存样式.\n\n如果你使用Prat插件,此选项将被激活",
	['resethelp']			= "重置所有设置及聊天频道",
	['resethelp_desc']		= "重置所有频道和频道",
	['resetloc']			= "重置所有窗口位置",
	['resetloc_desc']		= "重置Elephant面板位置.",
	['showbutton']			= "显示按钮",
	['showbutton_desc']		= "在聊天框显示一按钮,切换Elephant.",
	
	--[[ Main/Copy frame elements ]]
	-- Main
	['catchers']	= {
		[1]	= "信息收集罐",
		[2]	= "在记录器中想保存哪些信息?",
		[3]	= "灰色的信息类型不能被禁用."
	},
	['clearall']		= "清除所有记录",
	['copy']			= "复制",
	['Disable']			= "禁用",
	['Empty']			= "清除",
	['Enable']			= "启用",
	['maxlog']			= "最大记录：%s 行。",
	['nblines']			= "行：%s",
	['scroll']			= {
		['bottom']		= {
			[1]	= "下翻到最后一页",
		},
		['linedown']	= {
			[1]	= "下翻一行",
		},
		['lineup']		= {
			[1]	= "上翻一行",
		},
		['pagedown']	= {
			[1]	= "下翻一页",
		},
		['pageup']		= {
			[1]	= "上翻一页",
		},
		['top']			= {
			[1]	= "上翻到第一页",
		},
	},
	
	-- Copy
	['copywindow']	= "复制窗口",
	
	--[[ Special log messages ]]
	['logstartedon']	= "记录开始于 %s 的 %s。",
	['logstopped']		= "记录停止。",
	['monstersay']		= "%s 说",
	['monsteryell']		= "%s 喊话",
	['whisperfrom']		= "%s 密语",
	['whisperto']		= "发送给 %s",
	
	--[[ Addon messages ]]
	['clearallconfirm']		= "所有聊天清除。",
	['combatlogdisabled']	= "战斗记录被禁用",
	['deleteconfirm']		= "聊天被删除： %s",
	['emptyconfirm']		= "聊天被清除： %s",
	['lootmethod']			= {
		['freeforall']		= ERR_SET_LOOT_FREEFORALL,
		['group']			= ERR_SET_LOOT_GROUP,
		['master']			= ERR_SET_LOOT_MASTER,
		['needbeforegreed']	= ERR_SET_LOOT_NBG,
		['roundrobin']		= ERR_SET_LOOT_ROUNDROBIN,
	},
	['masterlooterchanged']	=  ERR_NEW_LOOT_MASTER_S,
	['resetconfirm']		= "所有设置及聊天频道被重置。",
	
	--[[ Tooltips ]]
	['togglebuttontooltip']		= {
		[1]	= "左击显示Elephant界面",
		[2]	= "中键点击重置按钮位置.",
		[3]	= "右击拖动按钮.",
	},
	['toggletooltip']			= "左击显示Elephant界面.",
	
	--[[ Popup windows ]]
	['clearallpopup']	= {
		[1]	= "是否要清除所有记录？",
		[2]	= "确定",
		[3]	= "取消",
	},
	['emptypopup']		= {
		[1]	= "是否清除当前聊天记录？",
		[2]	= "确定",
		[3]	= "取消",
	},
	['resetpopup']		= {
		[1]	= "是否要重置所有设置及聊天频道？",
		[2]	= "确定",
		[3]	= "取消",
	},
	
	--[[ Default chat names to be displayed ]]
	['chatnames']	= {
		['combat']		= "战斗记录",
		['custom']		= "自定义频道",
		['general']		= "综合",
		['guild']		= CHAT_MSG_GUILD,
		['loot']		= CHAT_MSG_LOOT,
		['misc']		= "分配物品界限",
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
		['综合']		= {
			['name']	= "综合",
			['string']	= "综合",
		},
		['交易']		= {
			['name']	= "交易",
			['string']	= "交易",
		},
		['本地防务']	= {
			['name']	= "本地防务",
			['string']	= "本地防务",
		},
		['世界防务']	= {
			['name']	= "世界防务",
			['string']	= "世界防务",
		},
		['公会招募']	= {
			['name']	= "公会招募",
			['string']	= "公会招募",
		},
	},
	
	--[[ Custom chats special log messages ]]
	['customchat']	= {
		['join']	= "你加入了频道。",
		['leave']	= "你离开了频道。",
	},
} end)