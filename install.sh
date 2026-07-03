#!/usr/bin/env bash
# cpu-governor installer — ARXOS-ready: fully automatic, no manual steps,
# no root-gate (uses sudo internally where needed).
set -e
D="$(cd "$(dirname "$0")" && pwd)"
SUDO=""; [ "$(id -u)" -ne 0 ] && SUDO="sudo"
# ship a prebuilt binary; (re)compile only if it's missing
if [ ! -x "$D/cpu-governor" ]; then
  command -v gcc >/dev/null 2>&1 || $SUDO pacman -S --needed --noconfirm gcc >/dev/null 2>&1 || true
  gcc -O2 -o "$D/cpu-governor" "$D/cpu-governor.c"
fi
$SUDO install -Dm755 "$D/cpu-governor" /usr/local/bin/cpu-governor
echo "cpu-governor -> /usr/local/bin/cpu-governor"
