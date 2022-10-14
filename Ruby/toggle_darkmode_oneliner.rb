Win32::Registry::HKEY_CURRENT_USER.open(
    %q(SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize),
    Win32::Registry::KEY_ALL_ACCESS
)["AppsUseLightTheme"] ^= 1
