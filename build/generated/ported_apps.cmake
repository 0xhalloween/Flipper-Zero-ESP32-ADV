set(ESP32_FAM_PORTED_OBJECT_TARGETS)

set(ESP32_FAM_ASSETS_SCRIPT "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/tools/fam/compile_icons.py")
set(ESP32_FAM_RUNTIME_ROOT "${ESP32_FAM_GENERATED_DIR}/fam_runtime_root")
set(ESP32_FAM_RUNTIME_EXT_ROOT "${ESP32_FAM_RUNTIME_ROOT}/ext")
set(ESP32_FAM_STAGE_ASSETS_STAMP "${ESP32_FAM_RUNTIME_ROOT}/.assets.stamp")

add_library(esp32_fam_app_cli OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/cli/cli_main_commands.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/cli/cli_main_shell.c"
)
target_include_directories(esp32_fam_app_cli PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/cli"
)
target_compile_definitions(esp32_fam_app_cli PRIVATE SRV_CLI)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_cli)

add_library(esp32_fam_app_cli_subghz OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_chat.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_cli.c"
)
target_include_directories(esp32_fam_app_cli_subghz PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_cli_subghz)

add_library(esp32_fam_app_example_apps_assets OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_assets/example_apps_assets.c"
)
target_include_directories(esp32_fam_app_example_apps_assets PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_assets"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_example_apps_assets)

add_library(esp32_fam_app_example_apps_data OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_data/example_apps_data.c"
)
target_include_directories(esp32_fam_app_example_apps_data PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_data"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_example_apps_data)

add_library(esp32_fam_app_example_number_input OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_number_input/example_number_input.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_number_input/scenes/example_number_input_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_number_input/scenes/example_number_input_scene_input_max.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_number_input/scenes/example_number_input_scene_input_min.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_number_input/scenes/example_number_input_scene_input_number.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_number_input/scenes/example_number_input_scene_show_number.c"
)
target_include_directories(esp32_fam_app_example_number_input PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_number_input"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_example_number_input)

add_library(esp32_fam_app_js_blebeacon OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_blebeacon.c"
)
target_include_directories(esp32_fam_app_js_blebeacon PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_blebeacon PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_blebeacon)

add_library(esp32_fam_app_js_event_loop OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_event_loop/js_event_loop.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_event_loop/js_event_loop_api_table.cpp"
)
target_include_directories(esp32_fam_app_js_event_loop PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_event_loop PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_event_loop)

add_library(esp32_fam_app_js_gui OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/js_gui.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/js_gui_api_table.cpp"
)
target_include_directories(esp32_fam_app_js_gui PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui)

add_library(esp32_fam_app_js_gui__button_menu OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/button_menu.c"
)
target_include_directories(esp32_fam_app_js_gui__button_menu PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__button_menu PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__button_menu)

add_library(esp32_fam_app_js_gui__button_panel OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/button_panel.c"
)
target_include_directories(esp32_fam_app_js_gui__button_panel PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__button_panel PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__button_panel)

add_library(esp32_fam_app_js_gui__byte_input OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/byte_input.c"
)
target_include_directories(esp32_fam_app_js_gui__byte_input PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__byte_input PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__byte_input)

add_library(esp32_fam_app_js_gui__dialog OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/dialog.c"
)
target_include_directories(esp32_fam_app_js_gui__dialog PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__dialog PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__dialog)

add_library(esp32_fam_app_js_gui__empty_screen OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/empty_screen.c"
)
target_include_directories(esp32_fam_app_js_gui__empty_screen PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__empty_screen PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__empty_screen)

add_library(esp32_fam_app_js_gui__file_picker OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/file_picker.c"
)
target_include_directories(esp32_fam_app_js_gui__file_picker PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__file_picker PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__file_picker)

add_library(esp32_fam_app_js_gui__icon OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/icon.c"
)
target_include_directories(esp32_fam_app_js_gui__icon PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__icon PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__icon)

add_library(esp32_fam_app_js_gui__loading OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/loading.c"
)
target_include_directories(esp32_fam_app_js_gui__loading PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__loading PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__loading)

add_library(esp32_fam_app_js_gui__menu OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/menu.c"
)
target_include_directories(esp32_fam_app_js_gui__menu PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__menu PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__menu)

add_library(esp32_fam_app_js_gui__number_input OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/number_input.c"
)
target_include_directories(esp32_fam_app_js_gui__number_input PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__number_input PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__number_input)

add_library(esp32_fam_app_js_gui__popup OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/popup.c"
)
target_include_directories(esp32_fam_app_js_gui__popup PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__popup PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__popup)

add_library(esp32_fam_app_js_gui__submenu OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/submenu.c"
)
target_include_directories(esp32_fam_app_js_gui__submenu PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__submenu PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__submenu)

add_library(esp32_fam_app_js_gui__text_box OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/text_box.c"
)
target_include_directories(esp32_fam_app_js_gui__text_box PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__text_box PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__text_box)

add_library(esp32_fam_app_js_gui__text_input OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/text_input.c"
)
target_include_directories(esp32_fam_app_js_gui__text_input PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__text_input PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__text_input)

add_library(esp32_fam_app_js_gui__vi_list OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/vi_list.c"
)
target_include_directories(esp32_fam_app_js_gui__vi_list PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__vi_list PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__vi_list)

add_library(esp32_fam_app_js_gui__widget OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_gui/widget.c"
)
target_include_directories(esp32_fam_app_js_gui__widget PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_gui__widget PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_gui__widget)

add_library(esp32_fam_app_js_infrared OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_infrared/js_infrared.c"
)
target_include_directories(esp32_fam_app_js_infrared PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_infrared PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_infrared)

add_library(esp32_fam_app_js_math OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_math.c"
)
target_include_directories(esp32_fam_app_js_math PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_math PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_math)

add_library(esp32_fam_app_js_notification OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_notification.c"
)
target_include_directories(esp32_fam_app_js_notification PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_notification PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_notification)

add_library(esp32_fam_app_js_storage OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_storage.c"
)
target_include_directories(esp32_fam_app_js_storage PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_storage PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_storage)

add_library(esp32_fam_app_js_subghz OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_subghz/js_subghz.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_subghz/radio_device_loader.c"
)
target_include_directories(esp32_fam_app_js_subghz PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_subghz PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_subghz)

add_library(esp32_fam_app_subghz OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/radio_device_loader.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_device.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_protocols.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_radio_device_loader.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_worker.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_chat.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_frequency_analyzer_worker.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_gen_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_threshold_rssi.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_txrx.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_txrx_create_protocol_key.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_usb_export.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_load_file.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_load_select.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_run_attack.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_save_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_save_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_setup_attack.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_setup_extra.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_decode_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_delete.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_delete_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_delete_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_frequency_analyzer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_jammer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_more_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_need_saving.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_playlist.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_radio_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_read_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_receiver.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_receiver_config.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_receiver_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_rpc.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_save_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_save_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_saved.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_saved_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_button.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_counter.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_key.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_seed.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_serial.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_type.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_show_error.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_show_error_sub.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_signal_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_transmitter.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_cli.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_dangerous_freq.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_history.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_i.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_last_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/receiver.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subbrute_attack_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subbrute_main_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_frequency_analyzer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_jammer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_playlist.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_read_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/transmitter.c"
)
target_include_directories(esp32_fam_app_subghz PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz"
)
target_compile_definitions(esp32_fam_app_subghz PRIVATE APP_SUBGHZ)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_subghz)

add_library(esp32_fam_app_cli_vcp OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/cli/cli_vcp.c"
)
target_include_directories(esp32_fam_app_cli_vcp PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/cli"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_cli_vcp)

add_library(esp32_fam_app_js_app OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/js_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/js_modules.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/js_thread.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/js_value.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_flipper.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/modules/js_tests.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/plugin_api/app_api_table.cpp"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/views/console_view.c"
)
target_include_directories(esp32_fam_app_js_app PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_app PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_app)

add_library(esp32_fam_app_power_settings OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/power_settings_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/scenes/power_settings_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/scenes/power_settings_scene_battery_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/scenes/power_settings_scene_power_off.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/scenes/power_settings_scene_reboot.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/scenes/power_settings_scene_reboot_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/scenes/power_settings_scene_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app/views/battery_info.c"
)
target_include_directories(esp32_fam_app_power_settings PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/power_settings_app"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_power_settings)

add_library(esp32_fam_app_lfrfid OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/lfrfid.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/lfrfid_cli.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_clear_t5577.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_clear_t5577_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_delete_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_delete_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_emulate.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_enter_password.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_exit_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_extra_actions.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_raw_emulate.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_raw_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_raw_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_raw_read.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_raw_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_read.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_read_key_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_read_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_retry_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_rpc.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_save_data.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_save_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_save_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_save_type.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_saved_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_saved_key_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_select_key.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_select_raw_key.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_write.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_write_and_set_pass.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/scenes/lfrfid_scene_write_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/views/lfrfid_view_read.c"
)
target_include_directories(esp32_fam_app_lfrfid PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_lfrfid)

add_library(esp32_fam_app_storage_settings OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_benchmark.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_benchmark_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_factory_reset.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_format_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_formatting.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_internal_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_sd_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_unmount_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/scenes/storage_settings_scene_unmounted.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings/storage_settings.c"
)
target_include_directories(esp32_fam_app_storage_settings PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/storage_settings"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_storage_settings)

add_library(esp32_fam_app_nfc OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/felica_auth.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/mf_classic_key_cache.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/mf_ultralight_auth.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/mf_user_dict.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/mfkey32_logger.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/nfc_detected_protocols.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/nfc_emv_parser.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/nfc_supported_cards.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/emv/emv.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/emv/emv_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/felica/felica.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/felica/felica_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_3a/iso14443_3a.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_3a/iso14443_3a_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_3b/iso14443_3b.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_3b/iso14443_3b_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_4a/iso14443_4a.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_4a/iso14443_4a_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_4b/iso14443_4b.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso14443_4b/iso14443_4b_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso15693_3/iso15693_3.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/iso15693_3/iso15693_3_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_classic/mf_classic.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_classic/mf_classic_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_desfire/mf_desfire.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_desfire/mf_desfire_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_plus/mf_plus.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_plus/mf_plus_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_ultralight/mf_ultralight.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/mf_ultralight/mf_ultralight_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/nfc_protocol_support.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/nfc_protocol_support_gui_common.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/nfc_protocol_support_unlock_helper.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/ntag4xx/ntag4xx.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/ntag4xx/ntag4xx_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/slix/slix.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/slix/slix_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/st25tb/st25tb.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/st25tb/st25tb_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/type_4_tag/type_4_tag.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/protocol_support/type_4_tag/type_4_tag_render.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/helpers/slix_unlock.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/nfc_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_debug.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_delete.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_delete_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_des_auth_key_input.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_des_auth_unlock_warn.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_detect.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_emulate.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_emv_transactions.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_exit_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_extra_actions.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_felica_more_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_felica_system.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_field.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_file_select.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_generate_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_detect_reader.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_dict_attack.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_keys.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_add.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_delete.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_list.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_keys_warn_duplicate.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_mfkey_complete.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_mfkey_nonces_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_show_keys.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_update_initial.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_update_initial_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_classic_update_initial_wrong_card.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_desfire_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_desfire_more_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_dict_attack.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_add.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_delete.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_list.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_c_keys_warn_duplicate.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_capture_pass.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_key_input.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_unlock_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_mf_ultralight_unlock_warn.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_more_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_read.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_read_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_read_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_restore_original.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_restore_original_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_retry_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_rpc.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_save_confirm.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_save_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_save_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_saved_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_select_protocol.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_set_atqa.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_set_sak.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_set_type.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_set_uid.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_slix_key_input.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_slix_unlock.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_slix_unlock_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_slix_unlock_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_supported_card.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/scenes/nfc_scene_write.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/views/detect_reader.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/views/dict_attack.c"
)
target_include_directories(esp32_fam_app_nfc PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_nfc)

add_library(esp32_fam_app_infrared OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/infrared_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/infrared_remote.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/common/infrared_scene_universal_common.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_ask_back.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_ask_retry.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_debug.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_edit.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_edit_button_select.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_edit_delete.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_edit_delete_done.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_edit_move.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_edit_rename.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_edit_rename_done.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_error_databases.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_gpio_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_learn.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_learn_done.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_learn_enter_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_learn_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_remote.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_remote_list.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_rpc.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_universal.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_universal_ac.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_universal_audio.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_universal_fan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_universal_leds.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_universal_projector.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/scenes/infrared_scene_universal_tv.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/views/infrared_debug_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/views/infrared_move_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/views/infrared_progress_view.c"
)
target_include_directories(esp32_fam_app_infrared PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_infrared)

add_library(esp32_fam_app_dolphin OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/dolphin/dolphin.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/dolphin/helpers/dolphin_deed.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/dolphin/helpers/dolphin_state.c"
)
target_include_directories(esp32_fam_app_dolphin PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/dolphin"
)
target_compile_definitions(esp32_fam_app_dolphin PRIVATE SRV_DOLPHIN)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_dolphin)

add_library(esp32_fam_app_power_start OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_cli.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/power.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/power_api.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/power_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/views/power_off.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/views/power_unplug_usb.c"
)
target_include_directories(esp32_fam_app_power_start PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_power_start)

add_library(esp32_fam_app_nrf24 OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/helpers/nrf24_mj_core.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/helpers/nrf24_mj_ducky.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/nrf24_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/nrf24_hw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/nrf24_wifi_scan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_ch_jammer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_jammer_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_mj_attack.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_mj_auto.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_mj_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_mj_scan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_mj_script_select.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_mj_target_list.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_smart_jam.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_spectrum.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_wifi_jam.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scene_wifi_scan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/scenes/scenes.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/views/nrf24_ch_jammer_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/views/nrf24_mj_attack_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/views/nrf24_mj_scan_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/views/nrf24_smart_jam_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/views/nrf24_spectrum_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24/views/nrf24_wifi_jam_view.c"
)
target_include_directories(esp32_fam_app_nrf24 PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nrf24"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_nrf24)

add_library(esp32_fam_app_ble_spam OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/ble_auto_walk_log.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/ble_spam_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/ble_spam_hal.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/ble_tracker_hal.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/ble_uuid_db.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/ble_walk_hal.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_auto_walk.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_main.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_pair_spam_custom.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_race_detector.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_running.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_spam_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_tracker_geiger.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_tracker_scan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_walk_char_detail.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_walk_chars.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_walk_scan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scene_walk_services.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/scenes/scenes.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/views/ble_auto_walk_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/views/ble_spam_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/views/ble_walk_detail_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/views/ble_walk_scan_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/views/race_detector_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/views/tracker_geiger_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam/views/tracker_list_view.c"
)
target_include_directories(esp32_fam_app_ble_spam PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/ble_spam"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_ble_spam)

add_library(esp32_fam_app_wlan OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_attack_targets.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_client_picker.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_connect.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_evil_portal.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_evil_portal_captured.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_evil_portal_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_evil_portal_ssid.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_handshake.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_handshake_save_path.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_handshake_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_lan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_main.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_network_actions.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_network_deauth.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_network_scanning.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_package_sniffer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_port_scanner.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_ssid_connect.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_ssid_screen.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_ssid_spam.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_ssid_spam_custom.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scene_ssid_spam_run.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/scenes/scenes.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_connect_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_deauther_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_evil_portal_captured_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_evil_portal_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_handshake_channel_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_handshake_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_lan_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_portscan_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_sniffer_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/views/wlan_view_common.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_client_scanner.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_evil_portal.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_evil_portal_html.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_hal.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_handshake_parser.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_handshake_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_netcut.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_netscan.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_oui.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_passwords.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app/wlan_pcap.c"
)
target_include_directories(esp32_fam_app_wlan PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/wlan_app"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_wlan)

add_library(esp32_fam_app_bad_usb OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/bad_usb_app.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/helpers/bad_usb_hid.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/helpers/ble_hid_ext_profile.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/helpers/ducky_script.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/helpers/ducky_script_commands.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/helpers/ducky_script_keycodes.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_config.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_config_ble_mac.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_config_ble_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_config_layout.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_config_usb_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_config_usb_vidpid.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_confirm_unpair.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_done.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_error.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_file_select.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/scenes/bad_usb_scene_work.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/views/bad_usb_view.c"
)
target_include_directories(esp32_fam_app_bad_usb PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_bad_usb)

add_library(esp32_fam_app_notification_settings OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/notification_settings/notification_settings_app.c"
)
target_include_directories(esp32_fam_app_notification_settings PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/notification_settings"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_notification_settings)

add_library(esp32_fam_app_passport OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/dolphin_passport/passport.c"
)
target_include_directories(esp32_fam_app_passport PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/settings/dolphin_passport"
)
target_compile_definitions(esp32_fam_app_passport PRIVATE APP_PASSPORT)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_passport)

add_library(esp32_fam_app_clock OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/clock_app.c"
)
target_include_directories(esp32_fam_app_clock PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_clock)

add_library(esp32_fam_app_js_app_start OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/js_app.c"
)
target_include_directories(esp32_fam_app_js_app_start PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app"
)
target_compile_options(esp32_fam_app_js_app_start PRIVATE -Wno-error=implicit-function-declaration -Wno-error=incompatible-pointer-types)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_js_app_start)

add_library(esp32_fam_app_power OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_cli.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/power.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/power_api.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/power_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/views/power_off.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power/power_service/views/power_unplug_usb.c"
)
target_include_directories(esp32_fam_app_power PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/power"
)
target_compile_definitions(esp32_fam_app_power PRIVATE SRV_POWER)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_power)

add_library(esp32_fam_app_storage OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/filesystem_api.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storage.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storage_cli.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storage_external_api.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storage_glue.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storage_internal_api.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storage_processing.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storage_sd_api.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storages/sd_notify.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage/storages/storage_ext.c"
)
target_include_directories(esp32_fam_app_storage PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/storage"
)
target_compile_definitions(esp32_fam_app_storage PRIVATE SRV_STORAGE)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_storage)

add_library(esp32_fam_app_desktop OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/animations/animation_manager.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/animations/animation_storage.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/animations/views/bubble_animation_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/animations/views/one_shot_animation_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/desktop.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/desktop_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/helpers/pin_code.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/helpers/slideshow.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_debug.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_fault.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_hw_mismatch.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_lock_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_locked.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_main.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_pin_input.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_pin_timeout.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_secure_enclave.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/scenes/desktop_scene_slideshow.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/views/desktop_view_debug.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/views/desktop_view_lock_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/views/desktop_view_locked.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/views/desktop_view_main.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/views/desktop_view_pin_input.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/views/desktop_view_pin_timeout.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop/views/desktop_view_slideshow.c"
)
target_include_directories(esp32_fam_app_desktop PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/services/desktop"
)
target_compile_definitions(esp32_fam_app_desktop PRIVATE SRV_DESKTOP)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_desktop)

add_library(esp32_fam_app_subghz_load_dangerous_settings OBJECT
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/radio_device_loader.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_device.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_protocols.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_radio_device_loader.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subbrute_worker.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_chat.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_frequency_analyzer_worker.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_gen_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_threshold_rssi.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_txrx.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_txrx_create_protocol_key.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/helpers/subghz_usb_export.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_load_file.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_load_select.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_run_attack.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_save_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_save_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_setup_attack.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_setup_extra.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_bf_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_decode_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_delete.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_delete_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_delete_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_frequency_analyzer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_jammer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_more_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_need_saving.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_playlist.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_radio_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_read_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_receiver.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_receiver_config.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_receiver_info.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_rpc.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_save_name.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_save_success.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_saved.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_saved_menu.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_button.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_counter.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_key.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_seed.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_serial.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_set_type.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_show_error.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_show_error_sub.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_signal_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_start.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/scenes/subghz_scene_transmitter.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_cli.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_dangerous_freq.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_history.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_i.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/subghz_last_settings.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/receiver.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subbrute_attack_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subbrute_main_view.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_frequency_analyzer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_jammer.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_playlist.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/subghz_read_raw.c"
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/views/transmitter.c"
)
target_include_directories(esp32_fam_app_subghz_load_dangerous_settings PRIVATE
    "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz"
)
list(APPEND ESP32_FAM_PORTED_OBJECT_TARGETS esp32_fam_app_subghz_load_dangerous_settings)

add_custom_command(
    OUTPUT "${ESP32_FAM_STAGE_ASSETS_STAMP}"
    COMMAND ${CMAKE_COMMAND} -E remove_directory "${ESP32_FAM_RUNTIME_ROOT}"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/example_apps_assets"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_assets/files" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/example_apps_assets"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/subghz"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/subghz"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/js_app"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/js_app"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/lfrfid"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/lfrfid"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/nfc"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/nfc"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/infrared"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/infrared"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/bad_usb"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/bad_usb"
    COMMAND ${CMAKE_COMMAND} -E make_directory "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/clock"
    COMMAND ${CMAKE_COMMAND} -E copy_directory "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources" "${ESP32_FAM_RUNTIME_EXT_ROOT}/apps_assets/clock"
    COMMAND ${CMAKE_COMMAND} -E touch "${ESP32_FAM_STAGE_ASSETS_STAMP}"
    DEPENDS
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_assets/files/poems/a jelly-fish.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_assets/files/poems/my shadow.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_assets/files/poems/theme in yellow.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/examples/example_apps_assets/files/test_asset.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/Install_qFlipper_gnome.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/Install_qFlipper_macOS.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/Install_qFlipper_windows.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/ba-BA.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/colemak.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/cz_CS.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/da-DA.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/de-CH.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/de-DE-mac.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/de-DE.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/dvorak.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/en-UK.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/en-US.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/es-ES.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/es-LA.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/fi-FI.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/fr-BE.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/fr-CA.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/fr-CH.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/fr-FR-mac.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/fr-FR.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/hr-HR.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/hu-HU.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/it-IT-mac.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/it-IT.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/nb-NO.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/nl-NL.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/pt-BR.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/pt-PT.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/si-SI.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/sk-SK.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/sv-SE.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/assets/layouts/tr-TR.kl"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/demo_chromeos.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/demo_gnome.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/demo_macos.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/demo_windows.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/bad_usb/resources/badusb/test_mouse.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/ibtnfuzzer/example_uids_cyfral.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/ibtnfuzzer/example_uids_ds1990.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/ibtnfuzzer/example_uids_metakom.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/music_player/Marble_Machine.fmf"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/rfidfuzzer/example_uids_em4100.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/rfidfuzzer/example_uids_h10301.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/rfidfuzzer/example_uids_hidprox.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/rfidfuzzer/example_uids_pac.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/subplaylist/example_playlist.txt"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/100us.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/call_test_1.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/call_test_2.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/dump_0x00000000_1k.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/dump_0x00000000_4b.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/dump_STM32.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/goto_test.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/halt.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/reset.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/clock_app/resources/swd_scripts/test_write.swd"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/resources/infrared/assets/ac.ir"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/resources/infrared/assets/audio.ir"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/resources/infrared/assets/fans.ir"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/resources/infrared/assets/leds.ir"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/resources/infrared/assets/projectors.ir"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/infrared/resources/infrared/assets/tv.ir"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/lfrfid/resources/lfrfid/assets/iso3166.lfrfid"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources/nfc/assets/aid.nfc"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources/nfc/assets/country_code.nfc"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources/nfc/assets/currency_code.nfc"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources/nfc/assets/mf_classic_dict.nfc"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources/nfc/assets/mf_ultralight_c_dict.nfc"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources/nfc/assets/skylanders.nfc"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/nfc/resources/nfc/assets/vendors.nfc"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources/subghz/assets/alutech_at_4n"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources/subghz/assets/dangerous_settings"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources/subghz/assets/keeloq_mfcodes"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources/subghz/assets/keeloq_mfcodes_user"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources/subghz/assets/keeloq_mfcodes_user.example"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources/subghz/assets/nice_flor_s"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/main/subghz/resources/subghz/assets/setting_user.example"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/array_buf_test.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/bad_uart.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/badusb_demo.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/blebeacon.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/console.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/delay.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/event_loop.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/gpio.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/gui.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/i2c.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/infrared-send.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/interactive.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/load.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/load_api.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/math.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/notify.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/path.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/spi.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/storage.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/stringutils.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/subghz.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/uart_echo.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/uart_echo_8e1.js"
        "/home/kupito/Downloads/cardputer_port/Flipper-Zero-ESP32-Port-main/applications/system/js_app/examples/apps/Scripts/js_examples/usbdisk.js"
    VERBATIM
)
add_custom_target(esp32_fam_stage_assets DEPENDS "${ESP32_FAM_STAGE_ASSETS_STAMP}")
