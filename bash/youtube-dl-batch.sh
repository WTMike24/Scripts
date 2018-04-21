#!/bin/bash
source ~/scripts/colors.list

echo -n -e "${BOLD}${PURPLE}Paste the playlist URL: ${RESET}"
read playlist
echo -n -e "${BOLD}${PURPLE}Enter the folder name to place files in to (empty for don't move): ${RESET}"
read folder

if [[ $1 == '-n' ]]
then
  echo -e "${BOLD}${RED}Not deleting the old files for whatever reason...${RESET}"
else
  echo -e "${BOLD}${GREEN}Deleting old song files...${RESET}"
  cd /mnt/b/Music/Audioshield/download
  rm *.mp3 2>/dev/null
  rm *.part 2>/dev/null
  rm *.webm 2>/dev/null
fi

time ./youtube-dl --extract-audio --audio-format mp3 -o "%(title)s.%(ext)s" $playlist -i | tee yt.log

mv *.mp3 ../$folder/
