#!/bin/sh
# Reload the ASUS SupremeFX USB audio in PulseAudio with correct parameters:
# mmap=0 and rate=48000. module-detect loads it with defaults that produce
# silence on this UAC2 device.
#
# Finds the device by USB vendor:product (0x0b05:0x19ac) so it works
# regardless of which pcm/dsp number the kernel assigns this boot.

ASUS_VID="vendor=0x0b05"
ASUS_PID="product=0x19ac"

for i in $(seq 1 30); do
    pactl info > /dev/null 2>&1 && break
    sleep 1
done

# Walk uaudio instances to find the ASUS SupremeFX by USB ID
UAUDIO=""
for ua in $(sysctl -N dev.uaudio 2>/dev/null | sed -n 's/^dev\.uaudio\.\([0-9]*\)\..*/\1/p' | sort -un); do
    pnp=$(sysctl -n dev.uaudio."$ua".%pnpinfo 2>/dev/null)
    case "$pnp" in
        *"$ASUS_VID"*"$ASUS_PID"*) UAUDIO="uaudio${ua}"; break ;;
    esac
done

if [ -z "$UAUDIO" ]; then
    logger -t fix-onboard-audio "ASUS SupremeFX USB audio not found"
    exit 1
fi

# Find the first pcm device parented by this uaudio instance (playback)
DSP_NUM=""
for pc in $(sysctl -N dev.pcm 2>/dev/null | sed -n 's/^dev\.pcm\.\([0-9]*\)\..*/\1/p' | sort -un); do
    parent=$(sysctl -n dev.pcm."$pc".%parent 2>/dev/null)
    if [ "$parent" = "$UAUDIO" ]; then
        DSP_NUM="$pc"
        break
    fi
done

if [ -z "$DSP_NUM" ]; then
    logger -t fix-onboard-audio "No pcm device found for $UAUDIO"
    exit 1
fi

logger -t fix-onboard-audio "Found SupremeFX at $UAUDIO -> pcm${DSP_NUM}/dsp${DSP_NUM}"

# Unload the auto-detected module-oss and reload with working params
MOD=$(pactl list modules short 2>/dev/null | grep "device=/dev/dsp${DSP_NUM}" | awk '{print $1}')
if [ -n "$MOD" ]; then
    pactl unload-module "$MOD"
fi
pactl load-module module-oss "device=/dev/dsp${DSP_NUM}" mmap=0 rate=48000 format=s16le channels=2

mixer -d "pcm${DSP_NUM}" vol.volume=1.0:1.0 pcm.volume=1.0:1.0 line.volume=1.0:1.0
pactl set-default-sink "oss_output.dsp${DSP_NUM}"
