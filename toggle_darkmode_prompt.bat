@echo off
nircmd qboxtop "Toggle light/dark theme?" %~nx0 %~dp0\toggle_darkmode.bat

if errorlevel 9009 if not errorlevel 9010 (
	echo -----------------------------------------------
	echo Uses 'nircmd' to prompt from a CMD batch script
	echo ^> scoop install nircmd
	echo -----------------------------------------------
	pause
)