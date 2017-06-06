
;Menu, Tray, Icon, shell32.dll, 174

;Database functions for better structurization of the manipulated software (the functions that the database is usefull for are reputable. Therefore not optimal that the functions will go true the DB every time.
;F_DBa(Target, Request)
;{
;RequestsDB:={"T":1,"C":2,"G":3}
;msgbox % RequestsDB[Request]
;ProgramsDB:={}
;ProgramsDB["DirectoryOpus"]:=["dopus.exe","ahk_class dopus.lister","opusgroup"]
;ProgramsDB["Chromium"]:=["chrome.exe","ahk_class Chrome_WidgetWin_1","chromegroup"]
;msgbox % ProgramsDB[Target][RequestsDB[Request]]
;}


;---------------------------------------------------------------------------------
;Function for hiding/Showing the intercept.exe window
F_Intercept_visibility()
{
IfWinActive ahk_exe intercept.exe
	WinHide ahk_exe intercept.exe
else
	WinShow ahk_exe intercept.exe
return
}

;---------------------------------------------------------------------------------
;Function for running intercept.exe
F_Intercept_run()
{
Run, intercept.exe
Sleep 250
WinActivate ahk_exe intercept.exe
send y
WinHide ahk_exe intercept.exe
return
}

;---------------------------------------------------------------------------------
;Run Function - Running specific executable
F_Run(Target,TPath = 0)
{
if TPath = 0 
	Run, %Target%
else
	Run, %TPath% ;Command for running target if conditions are satisfied
}

;---------------------------------------------------------------------------------
;Switch Function - Switching between different instances of the same executable or running it if missing
F_Switch(Target,TClass,TGroup,TPath = 0)
{
IfWinExist, ahk_exe %Target% ;Checking state of existence
	{
	GroupAdd, %TGroup%, %TClass% ;Definition of the group (grouping all instance of this class) (Not the perfect spot as make fo unnecessary reapeats of the command with every cycle, however the only easy option to keep the group up to date with the introduction of new instances)
	ifWinActive %TClass% ;Status check for active window if belong to the same instance of the "Target"
		{
		GroupActivate, %TGroup%, r ;If the condition is met cycle between targets belonging to the group
		}
	else
		WinActivate %TClass% ;you have to use WinActivatebottom if you didn't create a window group.
	}
else
	{
	if TPath = 0 
		Run, %Target%
	else
		Run, %TPath% ;Command for running target if conditions are satisfied
	}
Return
}

;--------------------------------------------------------------------------------
F_Activate(Target,TPath = 0)
{
IfWinExist, ahk_exe %Target%
	{
	IfWinActive ahk_exe %Target%
		WinMinimize
	else
		WinActivate ahk_exe %Target%
	}
else
	{
	if TPath = 0 
		Run, %Target%
	else
		Run, %A_AppData%%TPath%
	}
Return
}

;--------------------------------------------------------------------------------
F_Translate()
{
Input Key1, L1
Input Key2, L1
DicDB:=[]
DicDB["b"]:="bg"
DicDB["e"]:="en"
DicDB["d"]:="da"
DicDB["g"]:="de"
Code = % DicDB[Key1] "/" DicDB[Key2]
Run, "https://translate.google.bg/?source=osdd#%Code%"
return
}

;--------------------------------------------------------------------------------
F_TranSelected()
{
Send, ^c
Run, "https://translate.google.bg/?source=osdd#auto/bg/%clipboard%"
Return
}

;--------------------------------------------------------------------------------
F_Wiki()
{
Input Key1, L1
DicDB:=[]
DicDB["b"]:="bg"
DicDB["e"]:="en"
DicDB["d"]:="da"
DicDB["g"]:="de"
Code = % DicDB[Key1]
Run, "https://%Code%.wikipedia.org/wiki/Main_Page"
return
}

;--------------------------------------------------------------------------------
F_Pass()
{
send user
sleep 5
send `t
sleep 5
sendraw pass
return
}


;--------------------------------------------------------------------------------
;--------------------------------------------------------------------------------
;--------------------------------------------------------------------------------



#if (getKeyState("F23", "P"))
F23::return

	;F-key row
esc::F_Activate("taskmgr.exe")
+esc::Reload
F1::SoundSet, 15
F2::SoundSet, 33
F3::SoundSet, 66
F4::SoundSet, 100
F5::Return
F6::Return
F7::Return
F9::Return
F8::Return
F10::Return
F11::Return
F12::Return

	;Number row
`::PostMessage 0x50, 0, 0x0000,, A
1::PostMessage 0x50, 0, 0x0409,, A
2::PostMessage 0x50, 0, 0x0402,, A
3::Return
+3::Return
4::Return
+4::Return
5::Return
6::Return
+6::Return
7::Return
8::Return
9::Return
0::Return
-::Return
=::Return

	;QWE row
tab::
q::Run, "https://r.ekj.dk/Citrix/ekjWeb/"
!q::F_Pass()
w::F_Switch("WINWORD.EXE","ahk_class OpusApp","wordgroup") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
+w::F_Run("WINWORD.EXE") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
e::F_Switch("EXCEL.EXE","ahk_class XLMAIN","excelgroup")
+e::F_Run("EXCEL.EXE")
r::F_Switch("mathcad.exe","ahk_exe mathcad.exe","mathcadgroup") ;ahk_exe used as class
+r::F_Run("mathcad.exe")
t::F_Switch("robot.EXE","ahk_class RoboBATRobot97","robotgroup","C:\Program Files\Autodesk\Autodesk Robot Structural Analysis Professional 2016\System\Exe\robot.EXE")
+t::F_Run("robot.EXE","C:\Program Files\Autodesk\Autodesk Robot Structural Analysis Professional 2016\System\Exe\robot.EXE")
y::F_Switch("Lusas_M.exe","ahk_exe Lusas_M.exe","lusasgroup","C:\LUSAS152\Programs\Lusas_M.exe") ;ahk_exe used as class
+y::F_Run("Lusas_M.exe","C:\LUSAS152\Programs\Lusas_M.exe")
u::Return
i::Return
o::F_Wiki()
p::Run, "https://duckduckgo.com/"
[::Run, "https://www.google.com"
]::Run, "https://www.google.com/maps/"

	;ASD row
capslock::
a::F_Switch("acad.exe","ahk_class AfxMDIFrame110u","acadgroup","C:\Program Files\Autodesk\AutoCAD 2016\acad.exe")
+a::F_Run("acad.exe","C:\Program Files\Autodesk\AutoCAD 2016\acad.exe")
s::F_Switch("powercivil.exe","ahk_class MstnTop","microstationgroup","C:\Program Files (x86)\Bentley\PowerCivil V8i (SELECTSeries 3)\PowerCivil\powercivil.exe")
+s::F_Run("powercivil.exe","C:\Program Files (x86)\Bentley\PowerCivil V8i (SELECTSeries 3)\PowerCivil\powercivil.exe")
d::F_Switch("Revit.exe","ahk_exe Revit.exe","revitgroup","C:\Program Files\Autodesk\Revit 2016\Revit.exe") ;ahk_exe used as class
+d::F_Run("Revit.exe","C:\Program Files\Autodesk\Revit 2016\Revit.exe")
f::F_Activate("PaintDotNet.exe","\Microsoft\Internet Explorer\Quick Launch\User Pinned\StartMenu\paint.net.lnk")
+f::F_Run("PaintDotNet.exe","C:\Program Files\paint.net\PaintDotNet.exe")
!f::F_Run("mspaint.exe")
g::
h::Run, "https://outlook.live.com/owa/"
j::Run, "https://mail.google.com/mail/u/0/#inbox"
k::Run, "https://www.abv.bg/"
l::Run, "https://www.youtube.com/feed/subscriptions"
`;::Run, "https://trakt.tv/dashboard"
'::Run, "http://www.imdb.com/"
enter::Return

	;ZXC row
;;Lshift::
z::F_Switch("dopus.exe","ahk_class dopus.lister","opusgroup")
+z::F_Run("dopus.exe")
x::F_Switch("firefox.exe","ahk_class MozillaWindowClass","firefoxgroup","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
+x::F_Run("firefox.exe","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
c::F_Switch("chrome.exe","ahk_class Chrome_WidgetWin_1","chromegroup")
+c::F_Run("chrome.exe")
v::Return
b::Return
n::Run, "https://m.ekj.dk/owa/"
m::F_Activate("OUTLOOK.EXE")
+m::
{
Run, "https://www.abv.bg/"
Run, "https://mail.google.com/mail/u/0/#inbox"
Run, "https://outlook.live.com/owa/"
return
}
,::F_Switch("lync.exe","ahk_class LyncConversationWindowClass","lyncgroup")
+,::F_Run("lync.exe")
.::F_Switch("skype.exe","ahk_class TConversationForm","skypegroup")
+.::F_Run("skype.exe")
/::F_Switch("Viber.exe","ahk_class Qt5QWindowOwnDCIcon","vibergroup","C:\Users\VTN\AppData\Local\Viber\Viber.exe")
+/::F_Run("Viber.exe","C:\Users\VTN\AppData\Local\Viber\Viber.exe")
;;Rshift::


	;Space row
;;Lctrl::
;;Lwin::
;;Lalt::
space::
{
Run, "C:\Users\VTN\Desktop\For Kalin.PNG"
Sleep 1000
msgbox, "КАЛИНЕ, МАХАЙ СЕ!" 
Sleep 1000
msgbox, "АРЕ, МАХАЙ СЕ БЕ!" 
Return
}
;;Ralt::
;;Rwin::
;;appskey::
;;Rctrl::

	;Arrow section
PrintScreen::Run, AU3_Spy.exe
+PrintScreen::F_Intercept_visibility()
^PrintScreen::Reload
ScrollLock::Return
SC061::Return

CtrlBreak::Return
pause::Return
Break::Return
SC045::Return

insert::Return
home::Return
pgup::Return

delete::Return
end::Return
pgdn::Return

up::F_Activate("spotify.exe","\Spotify\Spotify.exe")
down::Media_Play_Pause
left::Media_Prev
right::Media_Next

	;Numpad section
numpadDot::F_Translate()

numpad0::F_TranSelected()
numpad1::Return
numpad2::Return
numpad3::Return
numpad4::Return
numpad5::Return
numpad6::Return
numpad7::Return
numpad8::Return
numpad9::Return

numlock::Return
numpadDiv::Return
numpadMult::Return

numpadSub::Return
numpadAdd::Return
numpadEnter::Return




#if
return



;--------------------------------------------------------------------------------
;--------------------------------------------------------------------------------
;--------------------------------------------------------------------------------


+Lwin::F_Intercept_run()
