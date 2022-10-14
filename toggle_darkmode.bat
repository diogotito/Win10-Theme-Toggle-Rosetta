@echo off
setlocal EnableDelayedExpansion

set key="HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
set value="AppsUseLightTheme"

FOR /F "skip=2 tokens=2,3 delims= " %%a IN ('reg query %key% /v %value%') do (
	set /a T=1-%%b
	reg add %key% /v %value% /t %%a /d 0x!T! /f
)
