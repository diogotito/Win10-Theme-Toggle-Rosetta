import ctypes
from winreg import (HKEY_CURRENT_USER, KEY_ALL_ACCESS, ConnectRegistry,
                    OpenKey, QueryValueEx, SetValueEx)


def prompt(text, title="", boxtype=0x1 | 0x40):
    """Shows a dialog box with Ok and Cancel buttons.
    Returns True if the user activated the Ok button."""
    choice = ctypes.windll.user32.MessageBoxW(0, str(text), str(title), boxtype)
    return choice == 1


if __name__ == "__main__":
    THEME_NAMES = ["Dark", "Light"]
    HKCU = ConnectRegistry(None, HKEY_CURRENT_USER)
    PERSONALIZE_KEY = r"SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
    APPS_USE_LIGHT_THEME = "AppsUseLightTheme"

    # Get the preference
    Personalize = OpenKey(HKCU, PERSONALIZE_KEY, 0, KEY_ALL_ACCESS)
    (v, t) = QueryValueEx(Personalize, APPS_USE_LIGHT_THEME)

    # Prompt the user
    text = f"Toggle from {THEME_NAMES[v]} to {THEME_NAMES[1 - v]} theme?"
    if prompt(text=text, title="toggle_darkmode.py"):
        # Toggle the preference
        SetValueEx(Personalize, APPS_USE_LIGHT_THEME, 0, t, 1 - v)
