#!/bin/bash

# Run using sudo
if [[ $(whoami) != "root" ]]; then
  printf 'Try to run it with sudo\n'
  exit 1
fi
mkdir -p /usr/lib/x86_64-linux-gnu/opera/lib_extra
readonly TEMP_FOLDER='/tmp/'
readonly OPERA_FOLDER='/usr/lib/x86_64-linux-gnu/opera/'
readonly OPERA_LIB_EXTRA_FOLDER='/usr/lib/x86_64-linux-gnu/opera/lib_extra/'
readonly FILE_NAME='libffmpeg.so'
readonly ZIP_FILE='.zip'
readonly TEMP_FILE="$TEMP_FOLDER$FILE_NAME"
readonly OPERA_FILE="$OPERA_FOLDER$FILE_NAME"
readonly OPERA_LIB_EXTRA_FILE="$OPERA_LIB_EXTRA_FOLDER$FILE_NAME"
readonly RELEASE_TAG='tags/0.52.2' # FOR LATEST RELEASE USE 'latest'
## for Spesific Release as sometime latest build dont have linux-x64 version asset to download

readonly GIT_API=https://api.github.com/repos/iteufel/nwjs-ffmpeg-prebuilt/releases/$RELEASE_TAG

printf '\nGetting Url ...\n'

readonly OPERA_FFMPEG_URL=$(curl -s $GIT_API | grep browser_download_url | cut -d '"' -f 4 | grep linux-x64)

printf '\nDownloading ffmpeg ...\n'

wget $OPERA_FFMPEG_URL -O "$TEMP_FILE$ZIP_FILE"

printf "\nUnzipping ...\n\n"

unzip "$TEMP_FILE$ZIP_FILE" -d $TEMP_FILE

# For opera directory
#printf "\nMoving file on $OPERA_FILE ...\n"
#mv -f "$TEMP_FILE/$FILE_NAME" $OPERA_FILE

# For opera/lib_extra directory
printf "\nMoving file on $OPERA_LIB_EXTRA_FILE ...\n"
mv -f "$TEMP_FILE/$FILE_NAME" $OPERA_LIB_EXTRA_FILE

printf '\nDeleting Temporary files ...\n'

find $TEMP_FOLDER -name "*$FILE_NAME*" -delete
