key = "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize\"
value = "AppsUseLightTheme"

Set objShell = WScript.CreateObject("WScript.Shell")
theme = objShell.RegRead(key & value)

Dim questions(1)
questions(0) = "[LIGHT] " & ChrW(9668) & " Dark?"
questions(1) = "Light " & ChrW(9658) & " [DARK]?"

choice = Msgbox(questions(theme), vbYesNo + vbQuestion, "Light " & ChrW(8596) & " Dark")
If choice = vbYes Then
	theme = 1 - theme
	objShell.RegWrite key & value, theme
End If
