#!/bin/bash

time=$1
if [ -z "$time" ]; then
  time=5
fi

region=$(slurp)
if [ -z "$region" ]; then
  echo "❌ No region selected. Aborting."
  exit 1
fi

outdir="$HOME/Gifs"
mkdir -p "$outdir"
outfile="$outdir/$(date '+%F-%T').mp4"

timeout "$time" wf-recorder \
  -g "$region" \
  -f "$outfile"

tmpfile="$outfile"
outfile="${outfile%.mp4}-encoded.mp4"

ffmpeg -i "$tmpfile" -vcodec libx264 -vf fps=10 -preset veryfast -crf 30 -pix_fmt yuv420p "$outfile"
rm "$tmpfile"

if command -v hyprctl >/dev/null; then
  hyprctl notify 5 3000 "rgb(fe8019)" "Vídeo salvo com sucesso"
fi
