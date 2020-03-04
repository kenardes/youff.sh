#!/usr/bin/env bash
# inspired by https://www.reddit.com/r/commandline/comments/18b05p/i_wrote_a_quick_and_simple_script_to_download_and/

if [[ $1 == '' ]]; then
  echo "Usage:
          youff <url>
          youff --merge <video.mp4> <audio.m4a>
	  youff --a2aac <audio.m4a>"

elif [[ $1 == '--merge' ]]; then
  VID=$2
  AUD=$3
  ffmpeg -i "$VID" -i "$AUD" -c copy "${AUD%".m4a"}".mkv

elif [[ $1 == '--a2aac' ]]; then
  AUD=$2
  ffmpeg -i "$AUD" -acodec copy "${AUD%".m4a"}".aac

else
  URL="$1"

  # list availabel quality & format
  youtube-dl -F $URL

  # download audio
  echo ""
  echo "format code of audio to download (0 to skip)?"
  read FCA
  if [[ $FCA == 0 ]]; then
    echo "skipping downloading audio"
  else
    youtube-dl -f $FCA $URL
    AUD=$(youtube-dl -f $FCA --get-filename $URL)
  fi

  # download video
  echo ""
  echo "format code of video to download (0 to skip)?"
  read FCV
  if [[ $FCV == 0 ]]; then
    echo "skipping downloading video"
  else
    youtube-dl -f $FCV $URL
    VID=$(youtube-dl -f $FCV --get-filename $URL)
  fi
fi

