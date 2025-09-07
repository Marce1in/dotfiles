#!/usr/bin/env bash

gif_mode=false
copy_mode=false
time_arg=5  # Default duration

# Manual argument parsing
while [[ $# -gt 0 ]]; do
    case "$1" in
        -g)
            gif_mode=true
            shift
            ;;
        -c)
            copy_mode=true
            shift
            ;;
        -h)
            cat <<EOF
Usage: $0 [-g] [-c] [duration]
  -g    save output as GIF (instead of MP4)
  -c    copy final file to clipboard via wl-copy
  -h    show this help
If [duration] is omitted, defaults to 5 seconds.
EOF
            exit 0
            ;;
        *)
            # Assume any non-flag argument is duration
            if [[ "$1" =~ ^[0-9]+$ ]]; then
                time_arg="$1"
            else
                echo "❌ Invalid duration: '$1'. Must be a positive integer." >&2
                exit 1
            fi
            shift
            ;;
    esac
done

# Select region
region=$(slurp)
if [[ -z $region ]]; then
    echo "❌ No region selected. Aborting."
    exit 1
fi

# Prepare paths
outdir="$HOME/Gifs"
mkdir -p "$outdir"
ts=$(date '+%F-%T')
raw="$outdir/$ts.mp4"

# Record
timeout "$time_arg" wf-recorder -g "$region" -f "$raw"

# Encode
if $gif_mode; then
    final="${raw%.mp4}.gif"
    ffmpeg -y -i "$raw" \
        -vf "fps=10,scale=480:-1:flags=lanczos" -loop 0 \
        "$final"
else
    final="${raw%.mp4}-encoded.mp4"
    ffmpeg -y -i "$raw" \
        -vcodec libx264 -vf fps=10 -preset veryfast -crf 30 -pix_fmt yuv420p \
        "$final"
fi

# Cleanup
rm -f "$raw"

# Copy if requested
if $copy_mode; then
    mime=$( $gif_mode && echo image/gif || echo video/mp4 )
    wl-copy --type "$mime" < "$final"
    echo "📋 Copied to clipboard: $final"
fi

# Notify
if command -v notify-send &>/dev/null; then
    notify-send "Saved: ${final##*/}"
fi
