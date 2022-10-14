include Fiddle, Win32

def prompt(title, text, wintype=0x1|0x20)
    messageboxw = Function.new \
        dlopen('user32')['MessageBoxW'],
        [TYPE_VOIDP, TYPE_CONST_STRING, TYPE_CONST_STRING, TYPE_UINTPTR_T],
        TYPE_INT
    choice = messageboxw.call \
        nil, text.encode('utf-16le'), title.encode('utf-16le'), wintype
    choice == 1
end

THEME_NAMES = {
    0 => "dark",
    1 => "light"
}

ACCESS = Registry::KEY_READ | Registry::KEY_SET_VALUE
SUBKEY = %q(SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize)

Registry::HKEY_CURRENT_USER.open(SUBKEY, ACCESS) do |personalize|
    theme = personalize["AppsUseLightTheme"]
    alt_theme = 1 - theme

    if prompt "Toggling theme...", <<-Q
                     Current theme is #{THEME_NAMES[theme].upcase} ↴
        Do you want to switch to the #{THEME_NAMES[alt_theme].upcase} theme?
    Q
        personalize["AppsUseLightTheme"] = alt_theme
    end
end
