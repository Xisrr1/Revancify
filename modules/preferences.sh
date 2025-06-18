#!/usr/bin/bash

configure() {
    local CONFIG_OPTS UPDATED_CONFIG THEME
    local PREV_BETA="$REVANCIFY_XISR_BETA"
    CONFIG_OPTS=("LIGHT_THEME" "$LIGHT_THEME" "PREFER_SPLIT_APK" "$PREFER_SPLIT_APK" "USE_PRE_RELEASE" "$USE_PRE_RELEASE" "LAUNCH_APP_AFTER_MOUNT" "$LAUNCH_APP_AFTER_MOUNT" "ALLOW_APP_VERSION_DOWNGRADE" "$ALLOW_APP_VERSION_DOWNGRADE" REVANCIFY_XISR_BETA "$REVANCIFY_XISR_BETA")

    readarray -t UPDATED_CONFIG < <(
        "${DIALOG[@]}" \
            --title '| Configure |' \
            --no-items \
            --separate-output \
            --no-cancel \
            --ok-label 'Save' \
            --checklist "$NAVIGATION_HINT\n$SELECTION_HINT" -1 -1 -1 \
            "${CONFIG_OPTS[@]}" \
            2>&1 > /dev/tty
    )

    sed -i "s|='on'|='off'|" .config

    for CONFIG_OPT in "${UPDATED_CONFIG[@]}"; do
        setEnv "$CONFIG_OPT" on update .config
    done

    source .config

    if [ "$PREV_BETA" = "off" ] && [ "$REVANCIFY_XISR_BETA" = "on" ]; then
        if ! "${DIALOG[@]}" --title "Enable Beta Updates?" --yes-label "Confirm" --no-label "Cancel" --yesno "Are you sure you want to enable beta updates? This will restart Revancify." 0 0; then
            sed -i "s|^REVANCIFY_XISR_BETA=.*|REVANCIFY_XISR_BETA='off'|" .config
            source .config
            return
        fi
        exec "$0"
    fi

    [ "$LIGHT_THEME" == "on" ] && THEME="LIGHT" || THEME="DARK"
    export DIALOGRC="config/.DIALOGRC_$THEME"
}
