clear()
local keyboardIdentifier = '' --you'll need to set this :)

if string.len(keyboardIdentifier) > 1 then
	if keyboardIdentifier == '0000AAA' then
		lmc_assign_keyboard('MacroBoard')
	else lmc_device_set_name('MacroBoard', keyboardIdentifier)
	end
	lmc.minimizeToTray = true
	local config = {
-- see https://docstore.mik.ua/orelly/webprog/DHTML_javascript/0596004672_jvdhtmlckbk-app-b.html for a list of keycodes
			[96]  = 124, --"num0",  -- 124 is F13
			[97]  = 125, --"num1",  -- 125 is F14
			[98]  = 126, --"num2",  -- 126 is F15
			[99]  = 127, --"num3",  -- 127 is F16
			[100] = 128, --"num4",  -- 128 is F17
			[101] = 129, --"num5",  -- 129 is F18
			[102] = 130, --"num6",  -- 130 is F19
			[103] = 131, --"num7",  -- 131 is F20
			[104] = 132, --"num8",  -- 132 is F21
			[105] = 133, --"num9",  -- 133 is F22
			[110] = 134, --"numDelete", -- 134 is F23
			[13]  = 135, --"enter",	-- 135 is F24

			[8]   = "backspace",
			[45]  = "insert",
			[36]  = "home",
			[33]  = "pageup",
			[46]  = "delete",
			[35]  = "end",
			[34]  = "pagedown",

			[38]  = "up",
			[37]  = "left",
			[40]  = "down",
			[39]  = "right",
			[106] = "numMult",
			[107] = "numPlus",
			[108] = "numEnter",
			[109] = "numMinus",

			[111] = "numDiv",
			[144] = 144 --"numLock"
	}
	-- the below was added in to stop numlock toggling from the additional numBoard
	-- shift,ctrl,alt + f in my ahk toggles the numpad numlock
	-- you might want to change this, I've left it in so you can see some of the code in use 
	lmc_set_handler('MacroBoard', function(button, direction)
		if (direction == 0 and button == 144) then
			lmc_send_input(16,0,0) --shift down
			lmc_send_input(17,0,0) --control down
			lmc_send_input(18,0,0) --alt down
			lmc_send_input(70,0,0) -- F down
			lmc_send_input(70,0,2) -- F up
			lmc_send_input(16,0,2) --shift up
			lmc_send_input(17,0,2) --control up
			lmc_send_input(18,0,2) --alt up

			return
		end
		if (direction == 0) then return
		else lmc_send_input(config[button],0,0) end -- Send the mapped input.
	end)
	lmc_minimize() -- once the keyboard is set, hide in your 
else
	devices = lmc_get_devices()
	print('##   You must set the keyboardIdentifier variable with one of the below SystemID;')
	print('##   The string between the two "&" ampersands in your SystemID is the keyboardIdentifier - find the desired device in the below list, copy the value and enter it in the keyboardIdentifier string at the top of the file.')
	print('##   Once done, save and re-run the LUA script. This will minimize to the tray and run silent. You will have to reset this every time you disconnect your keyboard.')
	for key,value in pairs(devices) do 
		print(key..':')
		for key2,value2 in pairs(value) do 
			print('  '..key2..' = '..value2) 
		end
	end
end
lmc.autoReload = true
