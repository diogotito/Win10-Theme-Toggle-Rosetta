import ctypes
from winreg import (HKEY_CURRENT_USER, KEY_QUERY_VALUE, KEY_SET_VALUE,
                    ConnectRegistry, OpenKey, QueryValueEx, SetValueEx)


def prompt(text="", title="", boxtype=0x1 | 0x20):
    choice = ctypes.windll.user32.MessageBoxW(0, str(text), str(title), boxtype)
    return choice == 1


def toggle_theme():
    THEME_NAMES = ["Dark", "Light"]
    PERSONALIZE_KEY = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    APPS_USE_LIGHT_THEME = "AppsUseLightTheme"
    ACCESS = KEY_QUERY_VALUE | KEY_SET_VALUE

    with (
        ConnectRegistry(None, HKEY_CURRENT_USER) as HKCU,
        OpenKey(HKCU, PERSONALIZE_KEY, 0, ACCESS) as Personalize,
    ):
        v, t = QueryValueEx(Personalize, APPS_USE_LIGHT_THEME)

        if prompt(
            text=f"Toggle from {THEME_NAMES[v]} to {THEME_NAMES[1 - v]} theme?",
            title="toggle_darkmode.py",
        ):
            SetValueEx(Personalize, APPS_USE_LIGHT_THEME, 0, t, 1 - v)


if __name__ == "__main__":
    toggle_theme()
