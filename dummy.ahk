#Persistent
#InstallKeybdHook
#UseHook On
SetTitleMatchMode 2

;Ctrl = ^, Alt = !, Shift = +, Win = #

; sets the tray icon to a custom image 
	; I'd reccomend using a 64x64 8bit .ico
	; for dark theme, transparent backgrounds and white simple icons work the best imo
I_Icon = C:\Users\someUser\Documents\keyboard.ico  ; just a path this is an example
IfExist, %I_Icon%
	Menu, Tray, Icon, %I_Icon% 
	
;Open VS (no splash) == Numpad 0
	F13:: Run devenv /nosplash

;If image open with gimp/np++ else open file  == Numpad 1
	F14::
		tmp:=Clipboardall
		Clipboard:=""
		Send,^c
		ClipWait,1
		path:=Clipboard
		Clipboard:=tmp
		if ErrorLevel 
		{
			Return
		}
		
		StringRight, ext, path, 4 ;get extension from filename
		StringLower, ext, ext

		if ext in .jpg,jpeg,.bmp,.gif,.png,.tif,.ico
		{
			Run "P:\Gimp\GIMP 2\bin\gimp-2.10.exe" %path%
		} 
		else if ext in .txt,.sql,.ps1,.sln,.log,.ahk
		{
			Run "P:\Notepad++\notepad++.exe" %path%
		} 
		else
		{
			Run %path%
		}
	Return

;Run gimp  == Numpad 2
	F15::Run "P:\Gimp\GIMP 2\bin\gimp-2.10.exe"

;SQL server profiler  == Numpad 3
	F16:: 
		Run "C:\Program Files (x86)\Microsoft SQL Server Management Studio 18\Common7\PROFILER.EXE"
		Sleep 1500
		SendInput ^n
	Return
		
;Wireshark  == Numpad 4
	F17:: Run "C:\Program Files\Wireshark\Wireshark.exe"

;SSRS == Numpad 7
	F20:: Run "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" "https://docs.microsoft.com/en-us/sql/reporting-services/create-deploy-and-manage-mobile-and-paginated-reports?view=sql-server-ver15" ;not not my report server obvs

;Reload the AHK script == Numpad 9
	F22:: 
		Reload
		Sleep 20
		TrayTip , AutoHotKeys, New version loading
	Return
		
; Turn Numpad on when Numpad is pressed == Numpad NumLock
	^!+f::	
		Sleep 50
		SendInput {NumLock}
	Return


