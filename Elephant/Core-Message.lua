local L = AceLibrary("AceLocale-2.2"):new("Elephant")
local Elephant, self = Elephant, Elephant

function Elephant:GetLiteralMessage(mStruct)
	local msg = ""
	
	-- Time if needed
	if mStruct['time'] then
		msg = msg .. "|cff888888" .. date("%H:%M:%S", mStruct['time']) .. "|r "
	end
	
	-- Main message color
	if mStruct['type'] then
		msg = msg .. "|c" .. self:MakeTextHexColor(ChatTypeInfo[mStruct['type']].r, ChatTypeInfo[mStruct['type']].g, ChatTypeInfo[mStruct['type']].b, ChatTypeInfo[mStruct['type']].a)
	end
	
	-- Handling Prat messages
	if mStruct['prat'] then
		msg = msg .. mStruct['prat']
	end
	
	if mStruct['arg6'] and mStruct['arg6'] ~= "" then
		msg = msg .. "<" .. mStruct['arg6'] .. ">"
	end
	
	if mStruct['arg2'] then
		if mStruct['type'] == "EMOTE" then
			msg = msg .. mStruct['arg2'] .. " "
		elseif mStruct['type'] ~= "MONSTER_EMOTE" and mStruct['type'] ~= "ACHIEVEMENT" and mStruct['type'] ~= "GUILD_ACHIEVEMENT" then
			if mStruct['type'] == "MONSTER_SAY" then
				msg = msg .. format(L['monstersay'], mStruct['arg2'])
			elseif mStruct['type'] == "MONSTER_YELL" then
				msg = msg .. format(L['monsteryell'], mStruct['arg2'])
			elseif mStruct['type'] == "MONSTER_WHISPER" then
				msg = msg .. mStruct['arg2']
			else
				local pLink = "|Hplayer:" .. mStruct['arg2'] .. "|h[" .. mStruct['arg2'] .. "]|h"
				
				if mStruct['type'] == "WHISPER_INFORM" or mStruct['type'] == "BN_WHISPER_INFORM" then
					msg = msg .. format(L['whisperto'], pLink)
				else
					msg = msg .. pLink
				end
			end
			
			if mStruct['type'] == "WHISPER" or mStruct['type'] == "MONSTER_WHISPER" or mStruct['type'] == "BN_WHISPER" then
				msg = format(L['whisperfrom'], msg)
			end
			
			msg = msg .. ": "
		end
	end
	
	if mStruct['arg1'] then
		if mStruct['type'] == "MONSTER_EMOTE" then
			msg = msg .. format(mStruct['arg1'], mStruct['arg2'])
		elseif mStruct['arg2'] and (mStruct['type'] == "ACHIEVEMENT" or mStruct['type'] == "GUILD_ACHIEVEMENT") then
			msg = msg .. format(mStruct['arg1'], mStruct['arg2'])
		else
			msg = msg .. mStruct['arg1']
		end
	end
	
	-- Closing main message color
	if mStruct['type'] then
		msg = msg .. "|r"
	end
	
	return msg
end

function Elephant:GetEnableActionMsg(isEnabled)
	if isEnabled then
		return format(L['logstartedon'], date("%m/%d/%Y"), date("%H:%M:%S"))
	else
		return L['logstopped']
	end
end

function Elephant:GetEnabledMsg(isEnabled)
	if isEnabled then
		return L['enabled']
	else
		return L['disabled']
	end
end

function Elephant:MakeTextHexColor(r, g, b, a)
	local r = string.format("%02x", r*255)
	local g = string.format("%02x", g*255)
	local b = string.format("%02x", b*255)
	local a
	if a then
		a = string.format("%02x", a*255)
	else
		a = "ff"
	end
	
	return (a .. r .. g .. b)
end