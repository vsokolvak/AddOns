local mod = LootMaster:NewModule("EPGPLootmaster_Options")

--local LootMasterML = false

function mod:OnEnable()
  local options = {
    name = "EPGPLootMaster сервера FreedomWoW UA",
    type = "group",
    get = function(i) return LootMaster.db.profile[i[#i]] end,
    set = function(i, v) LootMaster.db.profile[i[#i]] = v end,
    args = {
        
        global = {
            order = 1,
            type = "group",
            hidden = function(info) return not LootMasterML end,
            name = "Загальна конфігурація",
            
                args = {
                
                help = {
                    order = 0,
                    type = "description",
                    name = "EPGPLootMaster розроблений для розподілу здобичі за системою EP/GP. Даний аддон допомагає швидко і без помилок розподілити лут, що зареєстрований в системі EP/GP.",
                },
                
                
                
                no_ml = {
                    order = 2,
                    type = "description",
                    hidden = function(info) return LootMasterML end,
                    name = "\r\n\r\n|cFFFF8080WARNING: Alot of settings have been hidden because the EPGPLootmaster 'ML' module has been disabled. Please enabled it from the addon configuration screen.|r",
                },
                
                config_group = {
                    order = 12,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Загальна конфігурація",
                    args = {
                        
                        use_epgplootmaster = {
                            order = 2,
                            type = "select",
			                width = "double",
                            set = function(i, v) 
                                LootMaster.db.profile.use_epgplootmaster = v;
                                if v == 'enabled' then
                                    LootMasterML:EnableTracking();
                                elseif v == 'disabled' then
                                    LootMasterML:DisableTracking();
                                else
                                    LootMasterML.current_ml = nil;
                                    LootMasterML:GROUP_UPDATE();
                                end                               
                                
                            end,
                            name = "Використання EPGPLootmaster",
                            desc = "Включення EPGPLootmaster дозволено чи ні.",
                            values = {
                                ['enabled'] = 'Завжди використовувати EPGPLootmaster',
                                ['disabled'] = 'Ніколи не використовувати EPGPLootmaster',
                                ['ask'] = 'Запитувати щоразу'
                            },
                        },
                        
                        loot_timeout = {
                            order = 14,
                            type = "select",
			                width = "double",
                            name = "Час розподілу луту",
                            desc = "Встановлює кількість часу, відведеного гравцям для голосування.",
                            values = {
                                [0] = 'No timeout',
                                [10] = '10 секунд',
                                [15] = '15 секунд',
                                [20] = '20 секунд',
                                [30] = '30 секунд',
                                [40] = '40 секунд',
                                [50] = '50 секунд',
                                [60] = '1 хвилина',
                                [90] = '1 хв. 30 сек.',
                                [150] = '2 хв. 30 сек.',
                                [300] = '5 хв',
                            },
                        }, 
                        
                        --[[defaultMainspecGP = {
                            order = 15.1,
                            type = "input",                    
                            name = "Default mainspec GP",
                            desc = "Fill this field to override the GP value for mainspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultMainspecGPPercentage = false;
                                    LootMaster.db.profile.defaultMainspecGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultMainspecGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultMainspecGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultMainspecGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultMinorUpgradeGP = {
                            order = 15.2,
                            type = "input",                    
                            name = "Default minor upgrade GP",
                            desc = "Fill this field to override the GP value for minor upgrade mainspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultMinorUpgradeGPPercentage = false;
                                    LootMaster.db.profile.defaultMinorUpgradeGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultMinorUpgradeGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultMinorUpgradeGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultMinorUpgradeGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultOffspecGP = {
                            order = 15.3,
                            type = "input",                    
                            name = "Default offspec GP",
                            desc = "Fill this field to override the GP value for offspec loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultOffspecGPPercentage = false;
                                    LootMaster.db.profile.defaultOffspecGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultOffspecGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultOffspecGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultOffspecGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },
                        
                        defaultGreedGP = {
                            order = 15.4,
                            type = "input",                    
                            name = "Default greed GP",
                            desc = "Fill this field to override the GP value for greed loot.",
                            width = 'normal',
                            validate = function(data, value) if value=='' then return true end; if not strmatch(value, '^%s*%d+%s-%%?%s*$') then return false else return true end end,
                            set = function(i, v) 
                                
                                if v == '' or not v then
                                    v = ''
                                    LootMaster.db.profile.defaultGreedGPPercentage = false;
                                    LootMaster.db.profile.defaultGreedGPValue = nil;
                                else
                                    value, perc = strmatch(v, '^%s*(%d+)%s-(%%?)%s*$')
                                    LootMaster.db.profile.defaultGreedGPPercentage = (perc~=nil and perc~='');
                                    LootMaster.db.profile.defaultGreedGPValue = tonumber(value);
                                end                               
                                LootMaster.db.profile.defaultGreedGP = v;
                            end,
                            usage = "\r\nEmpty: use normal GP value"..
                                    "\r\n50%: use 50% of normal GP value"..
                                    "\r\n25: all items are worth 25 GP"
                        },]]
                        
                        ignoreResponseCorrections = {
                            type = "toggle",
                            order = 17,
                            width = 'full',
                            name = "Прийняти лише першу примітку до пункту.",
                            desc = "Зазвичай кандидати можуть надіслати багаторазові повідомлення в пм за лутання боса, щоб змінити вибір розподілу луту. Наприклад вони спочатку вибрали Основний спек, але пізніше вирішили змінити на Невелике покращення, щоб лут дістався тому хто потребує його більше. Якщо Ви поставите цю функцію, лише перша відповідь буде врахована.",
                        },
                        
                        allowCandidateNotes = {
                            type = "toggle",
                            order = 18,
                            width = 'full',
                            name = "Дозволить кандидатам додавати примітки до кожного пункту.",
                            desc = "Використовуйте цю функцію, якщо ви хочете, щоб кандидати надсилали вам повідомлення. Примітка відображається як символ на вашому інтерфейсі розподілу луту. Ви можете зняти галочку, якщо це уповільнює розподіл лута.",
                        },
                        
                        filterEPGPLootmasterMessages = {
                            type = "toggle",
                            order = 19,
                            width = 'full',
                            name = "Фільтрувати пм повідомлення луту гравців.",
                            desc = "У EPGPLootmaster є хороша система, якою можуть користуватися навіть ті, у кого немає EPGPLootmaster. Вони можуть надсилати фрази Main/Greed/Offspec. Це працює через шепіт чи через повідомлення в рейд чат. Дозвольте фільтрацію повідомлень.",
                        },
                        
                        audioWarningOnSelection = {
                            type = "toggle",
                            order = 20,
                            width = 'full',
                            name = "Програти аудіо попередження про початок розділу луту.",
                            desc = "Гратиме чутне попередження, коли відкриється меню голосування і вимагатиме Вашого рішення.",
                        },
                    }
                },
                
                buttons_group = {
                    order = 12.5,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Кнопки вибору",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "Це дозволяє Вам формувати кнопки вибору на інтерфейсах Ваших людей. Будь ласка, переконайтеся, що кнопки вибору відповідають значенням сортування, що використовуються нижче. Можете налаштувати кількість кнопок, їх колір та відсоток нарахувань.",
                        },
                        
                        buttonNum = {
                            type = "range",
                            width = 'full',
                            order = 1,
                            name = "Кількість кнопок розподілення луту:",
                            min = 1,
                            max = EPGPLM_MAX_BUTTONS,
                            step = 1,
                            desc = "Визначте, скільки кнопок Ви хочете бачити при розролі луту. Ви повинні сформувати мінімум 1 кнопку і знати, що кнопка пропуску буде завжди включеною.",
                        },
                        
                        
                        button1 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 1 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.1,
                            name = "button1",
                            desc = "Налаштувати цю обрану кнопку.",
                        },
                        
                        button2 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 2 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.2,
                            name = "button2",
                            desc = "Налаштувати цю обрану кнопку.",
                        },
                        
                        button3 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 3 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.3,
                            name = "button3",
                            desc = "Налаштувати цю обрану кнопку.",
                        },
                        
                        button4 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 4 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.4,
                            name = "button4",
                            desc = "Налаштувати цю обрану кнопку.",
                        },
                        
                        button5 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 5 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.5,
                            name = "button5",
                            desc = "Налаштувати цю обрану кнопку.",
                        },
                        
                        button6 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 6 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.6,
                            name = "button6",
                            desc = "Налаштувати цю обрану кнопку.",
                        },
                        
                        button7 = {
                            type = "input",
                            width = 'full',
                            hidden = function(info) return LootMaster.db.profile.buttonNum < 7 end,
                            dialogControl = "EPGPLMButtonConfigWidget",
                            order = 1.7,
                            name = "button7",
                            desc = "Налаштувати цю обрану кнопку.",
                        },
                        
                        btnTestPopup = {
                            order = 3,
                            type = "execute",
                            width = 'full',
                            name = "Відкрити тестове вікно розподілу лута",
                            desc = "Відкриває тестове вікно, у такий спосіб ви можете бачити те, як це буде виглядати в решти гравців. Після тестування натисніть кнопку закрити вікно.",
                            func = function()
                                local lootLink
                                for i=1, 20 do
                                  lootLink = GetInventoryItemLink("player", i)
                                  if lootLink then break end
                                end
                                if not lootLink then return end
                                
                                ml = LootMasterML        
                                local loot = ml:GetLoot(lootLink)
                                local added = false
                                if not loot then
                                    local lootID = ml:AddLoot(lootLink, true)
                                    loot = ml:GetLoot(lootID)
                                    loot.announced = false
                                    loot.manual = true
                                    added = true
                                end
                                if not loot then return self:Print('Unable to register loot.') end          
                                ml:AddCandidate(loot.id, UnitName('player'))
                                ml:AnnounceLoot(loot.id)
                                for i=1, LootMaster.db.profile.buttonNum do
                                  ml:AddCandidate(loot.id, 'Button ' .. i)
                                  ml:SetCandidateResponse(loot.id, 'Button ' .. i, LootMaster.RESPONSE['button'..i], true)
                                end
                                ml:ReloadMLTableForLoot(loot.link)
                            end
                        },
                    },
                },
                
                auto_hiding_group = {
                    order = 13,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Автоприховання луту",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "Це дозволяє управляти автоматичними функціями приховування EPGPLootmaster.",
                        },
                                
                        hideOnSelection = {
                            type = "toggle",
                            order = 16,
                            width = 'full',
                            name = "Приховати вікно поділу луту, коли голосування відкривається.",
                            desc = "Відмітьте, щоб автоматично приховувати Основний Інтерфейс Поділу луту, коли ви зобов'язані проголосувати за лут.",
                        },
                        
                        hideMLOnCombat = {
                            type = "toggle",
                            order = 17,
                            width = 'full',
                            name = "Приховує розподіл луту, якщо починається бій.",
                            desc = "Відмітьте, щоб автоматично приховувати вікно Розподілу лута, коли починається бій. Вікно автоматично відкриється знову, коли ви вийдете з бою.",
                        },
                        
                        hideSelectionOnCombat = {
                            type = "toggle",
                            order = 18,
                            width = 'full',
                            name = "Приховує голосування за лут, якщо починається бій.",
                            desc = "Відмітьте, щоб автоматично приховувати вікно голосування за лут, коли починається бій. Вікно автоматично відкриється знову, коли ви вийдете з бою.",
                        },
                    },
                },
                
                auto_announce_group = {
                    order = 14,
                    type = "group",
                    guiInline = true,
                    hidden = function(info) return not LootMasterML end,
                    name = "Автоматичне оголошення",
                    args = {
                        
                        help = {
                            order = 0,
                            type = "description",
                            name = "EPGP Lootmaster автоматично оголосить про розподіл луту здобичі.",
                        },
                                
                        auto_announce_threshold = {
                            order = 13,
                            type = "select",
                            width = 'full',
                            hidden = function(info) return not LootMasterML end,
                            name = "Авто поріг оголошеннь",
                            desc = "Встановлює автоматичний поріг оголошення про розподіл луту. Будь-який предмет, який має рівну або вищу якість, буде автоматично оголошуватись учасникам рейду.",
                            values = {
                                [0] = 'Never auto announce',
                                [2] = ITEM_QUALITY2_DESC,
                                [3] = ITEM_QUALITY3_DESC,
                                [4] = ITEM_QUALITY4_DESC,
                                [5] = ITEM_QUALITY5_DESC,
                            },
                        },
                    },
                },
                
                
                AutoLootGroup = {
            
                            type = "group",
                            order = 16,
                            guiInline = true,
                            name = "Автоматичний лут",
                            desc = "Auto looting of items",
                            hidden = function(info) return not LootMasterML end,
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "EPGP Lootmaster дозволяє вам автоматично надсилати предмети BoU та BoE певному учаснику, не задаючи питань.",
                                },
                                
                                AutoLootThreshold = {
                                    order = 1,
                                    type = "select",
                                    width = 'full',
                                    hidden = function(info) return not LootMasterML end,
                                    name = "Автоматичний поріг розподілу (тільки предметів BoE та BoU)",
                                    desc = "Встановлює автоматичний поріг розподілу. Будь-який розподіл BoE та BoU, який має нижчу або рівну якість, буде надіслане автоматично кандидату нижче.",
                                    values = {
                                        [0] = 'Never auto loot',
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                AutoLooter = {
                                    type = "select",
                                    style = 'dropdown',
                                    order = 2,
                                    width = 'full',
                                    name = "Ім'я кандидата за умовчанням (з урахуванням регістру):",
                                    desc = "Будь ласка, введіть тут ім'я кандидата за замовчуванням, щоб він отримував BoE та BoU.",
                                    disabled = function(info) return (LootMaster.db.profile.AutoLootThreshold or 0)==0 end,
                                    values = function()
                                        local names = {}
                                        local name;
                                        local num = GetNumRaidMembers()
                                        if num>0 then
                                            -- we're in raid
                                            for i=1, num do 
                                                name = GetRaidRosterInfo(i)
                                                names[name] = name
                                            end
                                        else
                                            num = GetNumPartyMembers()
                                            if num>0 then
                                                -- we're in party
                                                for i=1, num do 
                                                    names[UnitName('party'..i)] = UnitName('party'..i)
                                                end
                                                names[UnitName('player')] = UnitName('player')
                                            else
                                                -- Just show everyone in guild.
                                                local num = GetNumGuildMembers(true);
                                                for i=1, num do repeat
                                                    name = GetGuildRosterInfo(i)
                                                    names[name] = name
                                                until true end     
                                            end                                   
                                        end
                                        sort(names)
                                        return names;
                                    end
                                },
                            }
                },
            
        
        
                MonitorGroup = {
                            type = "group",
                            order = 17,
                            guiInline = true,
                            hidden = function(info) return not LootMasterML end,
                            name = "Контроль",
                            desc = "Надішліть та отримайте повідомлення контролю від РЛ і див. те, що вибрав інший рейдер.",
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "EPGP Lootmaster дозволяє Вам надсилати повідомлення іншим користувачам у Вашому рейді. Це покаже їм той самий інтерфейс розподілу луту як у РЛ, дозволяючи їм допомогти з розподілом луту.",
                                },
                
                                monitor = {
                                    type = "toggle",
                                    set = function(i, v)
                                        LootMaster.db.profile[i[#i]] = v;
                                        if LootMasterML and LootMasterML.UpdateUI then
                                            LootMasterML.UpdateUI( LootMasterML );
                                        end
                                    end,
                                    order = 1,
                                    width = 'full',
                                    name = "Прислухатися до розподілу луту, що надходить",
                                    desc = "Відмітьте, щоб відображати оновлення розподілу лута. Ця функція дозволяє Вам бачити, що робить майстер луту, таким чином ви можете допомогти прийняти рішення про розподіл луту.",
                                    disabled = false,
                                },
                                
                                monitorIncomingThreshold = {
                                    order = 2,
                                    width = 'normal',
                                    type = "select",
                                    name = "Розприділяти рівне і вище",
                                    desc = "Бачити вікно розподілу лута рейду предметів, що відповідають цьому порогу або вище.",
                                    disabled = function(info) return not LootMaster.db.profile.monitor end,
                                    values = {
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                monitorSend = {
                                    type = "toggle",
                                    order = 3.1,
                                    width = 'full',
                                    name = "Надсилати вікно розподілу луту всьому рейду",
                                    desc = "Чи хотіли б ви надсилати інтерактивні оновлення розподілу луту. Це дозволяє іншому члену рейду бачити, що майтер луту взаємодіє з гравцями і вони можуть допомогти в прийнятті рішень про розподіл луту. Ви будете надсилати повідомлення, тільки якщо ви будете майстром луту.",
                                    disabled = false,
                                },
                                
                                monitorSendAssistantOnly = {
                                    type = "toggle",
                                    order = 3.2,
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    width = 'full',
                                    name = "Надсилати вікно розподілу луту тільки помічникам рейд лідера",
                                    desc = "Надсилає повідомлення розподілу лута один за одним помічникам рейд лідера. Залишіть поле порожнім якщо хочете, щоб всі бачили розподіл луту. Зняття галочки також веде до прискорення відкриття розподілу луту.",
                                },
                                
                                hideResponses = {
                                    type = "toggle",
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    order = 3.3,
                                    width = 'full',
                                    name = "Приховувати відповіді до завершення голосування",
                                    desc = "Ця опція приховає відповіді від гравців на екрані, поки гравець все ще робить свій вибір для розподілу луту. Це буде перешкоджати тому, щоб гравці робили вибір, заснований на відповідях інших людей. Це запобігає 'обману' і прискорює процес голосування, тому що люди припинять чекати тих, хто проголосував.",
                                },
                                
                                monitorThreshold = {
                                    order = 4,
                                    width = 'normal',
                                    type = "select",
                                    name = "Надсилати рівний або вище",
                                    desc = "Надсилати повідомлення розподілу луту які відповідають цьому порогу або вище.",
                                    disabled = function(info) return not LootMaster.db.profile.monitorSend end,
                                    values = {
                                        [2] = ITEM_QUALITY2_DESC,
                                        [3] = ITEM_QUALITY3_DESC,
                                        [4] = ITEM_QUALITY4_DESC,
                                        [5] = ITEM_QUALITY5_DESC,
                                    },
                                },
                                
                                hint = {
                                    order = 5,
                                    width = 'normal',
                                    hidden = function(info) return not LootMaster.db.profile.monitorSend end,
                                    type = "description",
                                    name = "  Тільки предмети BoE та BoU будуть фільтровані be\r\n. Предмети BoP будуть завжди\r\n надсилатись в повідомленні.",
                                },
                            }
                },
                
                ExtraFunctionGroup = {
                            type = "group",
                            order = 18,
                            guiInline = true,
                            hidden = function(info) return not LootMasterML end,
                            name = "Додаткові функції",
                            args = {
                                
                                help = {
                                    order = 0,
                                    type = "description",
                                    name = "Деякі додаткові функції, які могли б стати в нагоді.",
                                },
                                btnVersionCheck = {
                                  order = 1000,
                                  type = "execute",
                                  name = "Перевірка версії",
                                  desc = "Відображає результат перевірки версії аддона.",
                                  func = function()
                                           LootMaster:ShowVersionCheckFrame()
                                         end
                                },
                                
                                btnRaidInfoCheck = {
                                  order = 2000,
                                  type = "execute",
                                  name = "Перевірка рейда",
                                  desc = "Перевірка чи гравці знаходяться в рейдовому підземеллі.",
                                  func = function()
                                           LootMasterML:ShowRaidInfoLookup()
                                         end
                                }
                                
                                
                                
                
                                
                            }
                }
            },
        },
    },
  }

  local config = LibStub("AceConfig-3.0")
  local dialog = LibStub("AceConfigDialog-3.0")

  config:RegisterOptionsTable("EPGPLootMaster-Bliz", options)
  dialog:AddToBlizOptions("EPGPLootMaster-Bliz", "EPGPLootMaster", nil, 'global')
  --dialog:AddToBlizOptions("EPGPLootMaster-Bliz", "Monitor", "EPGPLootMaster", 'MonitorGroup')
  
end