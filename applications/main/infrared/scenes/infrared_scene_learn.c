#include "../infrared_app_i.h"
#include <dolphin/dolphin.h>
#include <furi_hal_infrared.h>
#include <dialogs/dialogs.h>
#include <assets_icons.h>

void infrared_scene_learn_on_enter(void* context) {
    InfraredApp* infrared = context;

    /*
     * We dynamically verify the presence of the Grove IR receiver.
     * FuriHalInfraredTxPinExtPA7 means the Grove IR receiver is present.
     * Anything else means it is not.
     *
     * IMPORTANT: Never call scene_manager_previous_scene() directly from on_enter
     * — the scene has not been fully pushed yet and this causes a furi_check crash.
     * We send a custom event instead and go back in on_event, which is safe.
     */
    if(furi_hal_infrared_detect_tx_output() != FuriHalInfraredTxPinExtPA7) {
        DialogsApp* dialogs = furi_record_open(RECORD_DIALOGS);
        DialogMessage* message = dialog_message_alloc();
        dialog_message_set_header(
            message, "IR Receiver not found", 64, 38, AlignCenter, AlignCenter);
        dialog_message_set_icon(message, &I_Quest_7x8, 60, 22);
        dialog_message_show(dialogs, message);
        dialog_message_free(message);
        furi_record_close(RECORD_DIALOGS);

        /* Defer back-navigation to on_event so the scene stack is consistent */
        view_dispatcher_send_custom_event(
            infrared->view_dispatcher,
            infrared_custom_event_pack(InfraredCustomEventTypePopupClosed, 0));
        return;
    }

    Popup* popup = infrared->popup;
    InfraredWorker* worker = infrared->worker;

    infrared_worker_rx_set_received_signal_callback(
        worker, infrared_signal_received_callback, context);
    infrared_worker_rx_start(worker);
    infrared->is_rx_started = true;
    infrared_play_notification_message(infrared, InfraredNotificationMessageBlinkStartRead);

    popup_set_icon(popup, 0, 32, &I_InfraredLearnShort_128x31);
    popup_set_header(popup, NULL, 0, 0, AlignCenter, AlignCenter);
    popup_set_text(
        popup, "Point the remote at IR port\nand push the button", 5, 10, AlignLeft, AlignCenter);
    popup_set_callback(popup, NULL);

    view_dispatcher_switch_to_view(infrared->view_dispatcher, InfraredViewPopup);
}

bool infrared_scene_learn_on_event(void* context, SceneManagerEvent event) {
    InfraredApp* infrared = context;
    bool consumed = false;

    if(event.type == SceneManagerEventTypeCustom) {
        if(event.event == InfraredCustomEventTypeSignalReceived) {
            infrared_play_notification_message(infrared, InfraredNotificationMessageSuccess);
            scene_manager_next_scene(infrared->scene_manager, InfraredSceneLearnSuccess);
            dolphin_deed(DolphinDeedIrLearnSuccess);
            consumed = true;
        } else if(
            infrared_custom_event_get_type(event.event) == InfraredCustomEventTypePopupClosed) {
            /* IR receiver not present — go back to the previous scene safely */
            scene_manager_previous_scene(infrared->scene_manager);
            consumed = true;
        }
    }

    return consumed;
}

void infrared_scene_learn_on_exit(void* context) {
    InfraredApp* infrared = context;
    Popup* popup = infrared->popup;
    infrared_worker_rx_set_received_signal_callback(infrared->worker, NULL, NULL);
    if(infrared->is_rx_started) {
        infrared_worker_rx_stop(infrared->worker);
        infrared->is_rx_started = false;
    }
    infrared_play_notification_message(infrared, InfraredNotificationMessageBlinkStop);
    popup_set_icon(popup, 0, 0, NULL);
    popup_set_text(popup, NULL, 0, 0, AlignCenter, AlignCenter);
}
