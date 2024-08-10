local L = AceLibrary("AceLocale-2.2"):new("Elephant")

L:RegisterTranslations("ruRU", function() return {
	--[[ Common messages ]]
	['chatlog']				= "Регистрировать чат в файл",
	['chatlog_desc']		= "Регистрирует чат (не лог боя) как Логи \\WoWChatLog.txt.\n\nЗамечу: Если опция активна,то запись лога происходит автоматически.",
	['combatlog']			= "Регистрировать лог боя в чат",
	['combatlog_desc']		= "Регистрирует чат (не лог боя) как Логи \\WoWCombatLog.txt.\n\nЗамечу: Если опция активна,то запись лога происходит автоматически.",
	['disabled']			= "Включено",
	['enabled']				= "Выключено",
	['enableddefault']		= "Регистрировать новый канал",
	['enableddefault_desc']	= "Автоматически начинать регистрацию вновом канале.",
	['noprat']				= "Вы можете использовать  Prat'sформатирование для логов когда Prat не загружен. Сообщения будут форматироваться с помощью Elephant's.",
	['reset']				= "Обновить",
	['reset_desc']			= "Обновить опции.",
	['toggle']				= "Показать",
	['toggle_desc']			= "Показывает или скрывает главное окно.",
	
	--[[ Options menu elements ]]
	['activate']			= "Активировано",
	['activate_desc']		= "Позволяет Elephant контролировать запись в файл. Отключении опции оставить текущий статус лога неизменным.\n\nВнимание: Вы не должны разрешать контролировать двум разным аддонам файл лога.",
	['clearallhelp']		= "Очистить",
	['clearallhelp_desc']	= "Очищает все сохраненные логи.",
	['files']				= "Файл логов",
	['files_desc']			= "Опции для сохранения лога в файл.",
	['Filters']				= FILTERS,
	['Filters_desc']		= "Фильтры для не использования лога в определенных каналах.",
	['filterusage']			= "Точное название  канала. Вы также можете использовать (*). Ex: <AceComm*>",
	['filtererror']			= "Не может добавить фильтр '%s'. Фильтр должен содержать (*).",
	['filterregex']			= "^[%a%*]+$",
	['newfilter_desc']		= "Создает новый фильтр.",
	['deletefilter_desc']	= "Удаляяет ранее созданый фильтр.",
	['logs']				= "Логи",
	['logs_desc']			= "Опции Логов.",
	['maxlogwords']			= "Max Лог",
	['maxlogwords_desc']	= "Максимальный размер каждого лога.",
	['prat']				= "Prat форматирование",
	['prat_desc']			= "Сохраняет логи так же как и  Prat. Сохраненные опции логов разрешают в дальнейшем o Elephant's использовать его стиль по умолчанию.\n\nЭто опция возможна если у вас стоит и работает Prat.",
	['resethelp']			= "Настройки",
	['resethelp_desc']		= "Обновить все настройки и чаты.",
	['resetloc']			= "Position",
	['resetloc_desc']		= "Обновляет Elephant's позицию главного окна.",
	['showbutton']			= "Показать кнопки",
	['showbutton_desc']		= "Показывает кнопки нормального чата как кнопки Elephant.",
	
	--[[ Main/Copy frame elements ]]
	-- Main
	['catchers']	= {
		[1]	= "Ловить сообщения",
		[2]	= "Что должно быть сохранено в этом логе?",
		[3]	= "Сообщения серые они отключены."
	},
	['clearall']	= "очистить все",
	['copy']		= "Копировать",
	['Disable']		= DISABLE,
	['Empty']		= EMPTY,
	['Enable']		= ENABLE,
	['maxlog']		= "Max Лог: %s Линии.",
	['nblines']		= "Линии: %s",
	['scroll']		= {
		['bottom']		= {
			[1]	= "Листать по Кнопке",
		},
		['linedown']	= {
			[1]	= "Листать по Линии вниз",
		},
		['lineup']		= {
			[1]	= "Листать по Линии вверх",
		},
		['pagedown']	= {
			[1]	= "Листать по Странице Вперед",
		},
		['pageup']		= {
			[1]	= "Листать по Странице Назад",
		},
		['top']			= {
			[1]	= "Листать по Верху",
		},
	},
	
	-- Copy
	['copywindow']	= "Copy window",
	
	--[[ Special log messages ]]
	['logstartedon']	= "Запись начинается на %s в %s.",
	['logstopped']		= "Запись остановлена.",
	['monstersay']		= "%s сказать",
	['monsteryell']		= "%s крикнуть",
	['whisperfrom']		= "%s шепнуть",
	['whisperto']		= "К %s",
	
	--[[ Addon messages ]]
	['clearallconfirm']		= "Все чаты очищены.",
	['combatlogdisabled']	= "Эта функция отключена.",
	['deleteconfirm']		= "Чат удален: %s",
	['emptyconfirm']		= "Чат Создан: %s",
	['lootmethod']			= {
		['freeforall']		= ERR_SET_LOOT_FREEFORALL,
		['group']			= ERR_SET_LOOT_GROUP,
		['master']			= ERR_SET_LOOT_MASTER,
		['needbeforegreed']	= ERR_SET_LOOT_NBG,
		['roundrobin']		= ERR_SET_LOOT_ROUNDROBIN,
	},
	['masterlooterchanged']	=  ERR_NEW_LOOT_MASTER_S,
	['resetconfirm']		= "Обновить все настройки и чаты.",
	
	--[[ Tooltips ]]
	['togglebuttontooltip']		= {
		[1]	= "Left-Click для показа Elephant",
		[2]	= "Центр-Click для обновления позиции  кнопки.",
		[3]	= "Right-Click для того чтобы двигать кнопки.",
	},
	['toggletooltip']			= "Left-Click для показа Elephant.",
	
	--[[ Popup windows ]]
	['clearallpopup']	= {
		[1]	= "Это очистит все логи.",
		[2]	= "Ok",
		[3]	= "Отмена",
	},
	['emptypopup']		= {
		[1]	= "Это очистит все текущие логи.",
		[2]	= "Ok",
		[3]	= "Cancel",
	},
	['resetpopup']		= {
		[1]	= "Это обновит все настройки и чаты.",
		[2]	= "Ok",
		[3]	= "Отмена",
	},
	
	--[[ Default chat names to be displayed ]]
	['chatnames']	= {
		['combat']	= "Бой",
		['custom']	= "Обычный чат",
		['general']	= "Главный чат",
		['guild']	= CHAT_MSG_GUILD,
		['loot']	= CHAT_MSG_LOOT,
		['misc']	= "Скрытый.",
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
		['localdefense']		= {
			['name']	= "Местная оборона",
			['string']	= "Местная оборона",
		},
		['general']				= {
			['name']	= "Главный",
			['string']	= "Главный",
		},
		['guildrecruitment']	= {
			['name']	= "Канал Гильдии",
			['string']	= "Канал Гильдии",
		},
		['trade']				= {
			['name']	= "Торговля",
			['string']	= "Торговля",
		},
		['worlddefense']		= {
			['name']	= "Оборона Мира",
			['string']	= "Оборона Мира",
		},
	},
	
	--[[ Custom chats special log messages ]]
	['customchat']	= {
		['join']	= "Вы покинули канал.",
		['leave']	= "Вы покинули канал.",
	},
} end)