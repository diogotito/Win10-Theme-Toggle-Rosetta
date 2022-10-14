import ctypes
import enum
from winreg import (HKEY_CURRENT_USER, KEY_ALL_ACCESS, ConnectRegistry,
                    OpenKey, QueryValueEx, SetValueEx)


class Theme(enum.IntEnum):
    DARK = 0
    LIGHT = 1
    question = property({
        LIGHT: "such light",
        DARK: "escuro"
    }.__getitem__)

    def toggle(self):
        return Theme(1 - self)


def prompt(text, title=""):
    return ctypes.windll.user32.MessageBoxW(0, str(text), str(title), 1) == 1


HKCU = ConnectRegistry(None, HKEY_CURRENT_USER)
PERSONALIZE_KEY = (
    r"SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize"
)
APPS_USE_LIGHT_THEME = "AppsUseLightTheme"

Personalize = OpenKey(HKCU, PERSONALIZE_KEY, 0, KEY_ALL_ACCESS)

(v, t) = QueryValueEx(Personalize, APPS_USE_LIGHT_THEME)
cur_theme = Theme(v)


if prompt(text=cur_theme.question,
          title="toggle_darkmode.py"):
    SetValueEx(Personalize, APPS_USE_LIGHT_THEME, 0, t, cur_theme.toggle())
