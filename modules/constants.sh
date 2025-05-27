#!/usr/bin/bash
SRC="$HOME/Revancify"
source "$SRC/.info"

STORAGE="$HOME/storage/shared/Revancify"

ARCH=$(getprop ro.product.cpu.abi)
DPI=$(getprop ro.sf.lcd_density)

USER_AGENT="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36"

title='Revancify 𝕏isr'
ver="${VERSION:-unknown}"
cols=$(tput cols)
pad=$(( cols - ${#title} - ${#ver - 3 } )); [ $pad -lt 0 ] && pad=0
backtitle="$title$(printf '%*s' "$pad")$ver"

DIALOG=(dialog --backtitle "$backtitle" --no-shadow --begin 2 0)

CURL=(curl -sL --fail-early --connect-timeout 2 --max-time 5 -H 'Cache-Control: no-cache')

WGET=(wget -qc --show-progress --user-agent="$USER_AGENT")

NAVIGATION_HINT="Navigate with [↑] [↓] [←] [→]"
SELECTION_HINT="Select with [SPACE]"
