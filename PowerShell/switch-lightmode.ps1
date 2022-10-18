using assembly System.Windows.Forms
using namespace System.Windows.Forms

$Pref = @{
    Path = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize";
    Name = "AppsUseLightTheme";
}

$ThemeNames = @{
    $true = "Light";
    $false = "Dark";
}

function Set-LightMode([bool] $light) {
    Set-ItemProperty @Pref -Value ($light -as [int]) -Type Dword -Force
}

function Get-LightMode() {
    (Get-ItemPropertyValue @Pref) -as [bool]
}

function Switch-LightMode() {
    Set-LightMode (-not (Get-LightMode))
}

function Confirm([string] $question) {
    $choice = [MessageBox]::Show(
        $question,
        "switch-lightmode.ps1",
        [MessageBoxButtons]::OKCancel,
        [MessageBoxIcon]::Information,
        [MessageBoxDefaultButton]::Button1
    )
    $choice -eq [DialogResult]::OK
}

$cur = $ThemeNames[(Get-LightMode)]
$alt = $ThemeNames[-not (Get-LightMode)]
if (Confirm "Toggle theme from $cur to ${alt}?")
{
    Switch-LightMode
}