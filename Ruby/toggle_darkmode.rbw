include Win32

module User32
    extend Fiddle::Importer
    dlload 'user32'
    extern 'int MessageBoxW(void*, char*, char*, unsigned int)'

    def self.messagebox(title, text, type=0x1|0x20)
        title.encode! 'utf-16le'
        text.encode! 'utf-16le'
        MessageBoxW(nil, text, title, type) == 1
    end
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

    if User32::messagebox "Toggling theme...", <<-Q
                     Current theme is #{THEME_NAMES[theme].upcase} ↴
        Do you want to switch to the #{THEME_NAMES[alt_theme].upcase} theme?
    Q
        personalize["AppsUseLightTheme"] = alt_theme
    end
end
