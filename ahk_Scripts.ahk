
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
;--------------------------------------------------------------------------------
;--------------------------------------------------------------------------------

#if (getKeyState("F23", "P"))
F23::return

	;F-key row
esc::Reload
F1::SoundSet, 15
F2::SoundSet, 33
F3::SoundSet, 66
F4::SoundSet, 100
F5::
F6::
F7::msgbox, ha
F9::
F8::
F10::
F11::
;F12:: ;Temporary disabled

	;Number row
`::PostMessage 0x50, 0, 0x0000,, A
1::PostMessage 0x50, 0, 0x0409,, A
2::PostMessage 0x50, 0, 0x0402,, A
3::
+3::
4::
+4::
5::
6::
+6::
7::
8::
9::
0::
-::
=::

	;QWE row
tab::
q::
+q::
w::F_Switch("WINWORD.EXE","ahk_class OpusApp","wordgroup") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
+w::F_Run("WINWORD.EXE") ;,"C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
e::F_Switch("EXCEL.EXE","ahk_class XLMAIN","excelgroup")
+e::F_Run("EXCEL.EXE")
r::
t::
y::Run, "https://www.youtube.com/feed/subscriptions"
u::Run, "https://trakt.tv/dashboard"
i::Run, "http://www.imdb.com/"
o::
p::
[::
]::

	;ASD row
capslock::
a::F_Switch("acad.exe","ahk_class AfxMDIFrame110u","acadgroup","C:\Program Files\Autodesk\AutoCAD 2016\acad.exe")
+a::F_Run("acad.exe","C:\Program Files\Autodesk\AutoCAD 2016\acad.exe")
s::F_Switch("powercivil.exe","ahk_class MstnTop","microstationgroup","C:\Program Files (x86)\Bentley\PowerCivil V8i (SELECTSeries 3)\PowerCivil\powercivil.exe")
+s::F_Run("powercivil.exe","C:\Program Files (x86)\Bentley\PowerCivil V8i (SELECTSeries 3)\PowerCivil\powercivil.exe")
d::F_Switch("PaintDotNet.exe","ahk_class WindowsForms10.Window.8.app.0.34f5582_r12_ad1","paintnetgroup","C:\Program Files\paint.net\PaintDotNet.exe")
+d::F_Run("PaintDotNet.exe","C:\Program Files\paint.net\PaintDotNet.exe")
f::
g::
h::Run, "https://r.ekj.dk/Citrix/ekjWeb/"
j::Run, "https://outlook.live.com/owa/"
k::Run, "https://mail.google.com/mail/u/0/#inbox"
l::Run, "https://www.abv.bg/"
`;::
'::
enter::

	;ZXC row
;Lshift::
z::F_Switch("dopus.exe","ahk_class dopus.lister","opusgroup")
+z::F_Run("dopus.exe")
x::F_Switch("firefox.exe","ahk_class MozillaWindowClass","firefoxgroup","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
+x::F_Run("firefox.exe","C:\Program Files (x86)\Mozilla Firefox\firefox.exe")
c::F_Switch("chrome.exe","ahk_class Chrome_WidgetWin_1","chromegroup")
+c::F_Run("chrome.exe")
v::
b::
n::
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
/::
;Rshift::


	;Space row
Lctrl::
Lwin::
Lalt::
space::
Ralt::
Rwin::
appskey::
Rctrl::

	;Arrow section
PrintScreen::
ScrollLock::
SC061::

CtrlBreak::
pause::
Break::
SC045::

insert::
home::
pgup::

delete::SoundSet, 33
end::SoundSet, 66
pgdn::SoundSet, 100

up::F_Activate("spotify.exe","\Spotify\Spotify.exe")
down::Media_Play_Pause
left::Media_Prev
right::Media_Next

	;Numpad section
numpadDot::F_Translate()

numpad0::F_TranSelected()
numpad1::
numpad2::
numpad3::
numpad4::
numpad5::
numpad6::
numpad7::
numpad8::
numpad9::

numlock::
numpadDiv::
numpadMult::

numpadSub::
numpadAdd::
numpadEnter::




#if
return
