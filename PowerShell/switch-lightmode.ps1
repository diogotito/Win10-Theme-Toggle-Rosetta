function Set-LightMode([bool] $light) {
    Set-ItemProperty `
        -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize `
        -Name AppsUseLightTheme `
        -Value ($light -as [int]) `
        -Type Dword `
        -Force
}

function Get-LightMode() {
    return (Get-ItemPropertyValue `
        -Path HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize `
        -Name AppsUseLightTheme) -as [bool]
}

function Switch-LightMode() {
    Set-LightMode (-not (Get-LightMode))
}

Switch-LightMode