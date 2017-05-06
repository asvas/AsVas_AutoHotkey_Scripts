
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

;F_DB(DBTarget)
;{
;ProgramsDB:={}
;ProgramsDB["DirectoryOpus"]:=["dopus.exe","ahk_class dopus.lister","opusgroup"]
;ProgramsDB["Chromium"]:=["chrome.exe","ahk_class Chrome_WidgetWin_1","chromegroup"]
;T:= % ProgramsDB[DBTarget][1]
;return % T
;C:= % ProgramsDB[DBTarget][2]
;return % C
;G:= StrReplace(T, ".exe") "group"
;return % G
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
	if WinActive "%TClass%" ;Status check for active window if belong to the same instance of the "Target"
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
F_Activate(Target,TClass,TPath = 0)
{
IfWinExist, ahk_exe %Target%
	{
	If WinActive "%TClass%"
		WinMinimize
	else
		WinActivate ahk_exe %Target%
	}
else
	{
	Run, %A_AppData%%TPath%
	}
Return
}

#if (getKeyState("F12", "P"))
F12::return

	;F-key row
F1::Reload
F2::F_Activate("spotify.exe","ahk_class SpotifyMainWindow","\Spotify\Spotify.exe")
F3::
F4::
F5::
F6::
F7::
F9::
F8::
F10::
F11::
;F12:: ;Temporary disabled

	;Number row
`::
1::F_Switch("dopus.exe","ahk_class dopus.lister","opusgroup")
+1::F_Run("dopus.exe")
2::F_Switch("chrome.exe","ahk_class Chrome_WidgetWin_1","chromegroup")
+2::F_Run("chrome.exe")
3::F_Switch("WINWORD.EXE","ahk_class OpusApp","wordgroup","C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
+3::F_Run("WINWORD.EXE","C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Word 2016.lnk")
4::F_Switch("EXCEL.EXE","ahk_class XLMAIN","excelgroup")
+4::F_Run("EXCEL.EXE")


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
w::
e::
r::
t::
y::
u::
i::
o::
p::
[::
]::
\::

	;ASD row
capslock::
a::
s::
d::
f::
g::
h::
j::
k::
l::
`;::
'::
enter::

	;ZXC row
;Lshift::
z::
x::
c::
v::
b::
n::
m::
,::
.::
/::
Rshift::


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

delete::
end::
pgdn::

up::
{
IfWinExist, ahk_exe spotify.exe
	{
	If WinActive("ahk_class SpotifyMainWindow")
		WinMinimize
	else
		WinActivate ahk_exe spotify.exe
	}
else
	{
	Run, %A_AppData%\Spotify\Spotify.exe
	}
Return
}
down::Media_Play_Pause
left::Media_Prev
right::Media_Next

	;Numpad section
numpad0::
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

numpadDot::


#if
return
