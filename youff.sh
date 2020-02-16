#!/usr/bin/env bash
# inspired by https://www.reddit.com/r/commandline/comments/18b05p/i_wrote_a_quick_and_simple_script_to_download_and/

if [[ $1 == ' ' ]]; then
  echo "Usage: youff <url>"
else
#  # get url
#  echo "URL to download from?"
#  read URL
URL="$1"

  # list availabel quality & format
  youtube-dl -F $URL

  # download audio
  echo "format code of audio to download?"
  read FCA
  youtube-dl -f $FCA $URL
  AUD=$(youtube-dl -f $FCA --get-filename $URL)

  # download video
  echo "format code of video to download?"
  read FCV
  youtube-dl -f $FCV $URL
  VID=$(youtube-dl -f $FCV --get-filename $URL)

  # merge video & audio
  OUTPUT=$(youtube-dl --get-filename $URL)
  ffmpeg -i "$VID" -i "$AUD" -c copy "$OUTPUT.mkv"
fi
