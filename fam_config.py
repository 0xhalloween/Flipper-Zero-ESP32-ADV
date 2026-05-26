import os

MANIFEST_ROOTS = [
    "components",
    "applications",
    "applications_user",
]

APP_SOURCE_OVERRIDES = {
    "desktop": "applications",
    "storage": "applications",
}

APPS = [
    "input",
    "notification",
    "gui",
    "dialogs",
    "locale",
    "cli",
    "cli_vcp",
    "storage",
    "storage_start",
    "power",
    "power_start",
    "power_settings",
    "loader",
    "loader_start",
    "notification_settings",
    "desktop",
    "archive",
    "about",
    "bt_settings",
    "example_apps_data",
    "example_apps_assets",
    "clock",
    "bad_usb",
    "subghz",
    "cli_subghz",
    "passport",
    "infrared",
    "wlan",
    "nrf24",
    "ble_spam",
    "nfc",
    "lfrfid",
]

# Boards without NFC / IR hardware – exclude the corresponding apps
_board = os.environ.get("FLIPPER_BOARD", "")
_boards_without_nfc = {"waveshare_c6_1.47", "waveshare_c6_1.9"}
_boards_without_lfrfid = {"m5stack_cardputer", "m5stack_cardputer_adv", "waveshare_c6_1.47", "waveshare_c6_1.9"}
_boards_without_ir = set()

# Wolf3D shares Doom's requirements (PSRAM, ST7789 320xN, I2S speaker).
_boards_without_wolf3d = set()

if _board in _boards_without_nfc:
    APPS = [a for a in APPS if a != "nfc"]

if _board in _boards_without_lfrfid:
    APPS = [a for a in APPS if a != "lfrfid"]

_boards_without_subghz = set()

# NRF24 plugs into the LORA slot (T-Embed CC1101). Boards without the slot
# don't have the required pin defines.
_boards_without_nrf24 = set()

if _board in _boards_without_ir:
    APPS = [a for a in APPS if a not in ("infrared", "js_infrared")]

if _board in _boards_without_subghz:
    APPS = [a for a in APPS if a not in ("subghz", "cli_subghz", "subghz_load_dangerous_settings", "js_subghz")]

if _board in _boards_without_nrf24:
    APPS = [a for a in APPS if a != "nrf24"]

if _board in _boards_without_wolf3d:
    APPS = [a for a in APPS if a != "wolf3d"]
# (wolf3d und doom stehen nicht in APPS — externer FAP-Pfad. Block bleibt für Klarheit.)

EXTRA_EXT_APPS = []
TARGET_HW = 32
AUTORUN_APP = ""
