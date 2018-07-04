#!/bin/bash

source "/path/to/colors.list"

id=`id -u`
if [[ id -ne 0 ]]; then
 echo "${NONE}${RED}This script must be run as root..."
 exit
fi

error="==> /var/log/apache2/error.log <=="
access="==> /var/log/apache2/access.log <=="
other="==> /var/log/apache2/other_vhosts_access.log <=="

type=0

clear

while read line
do
 if [[ $line = *$error* ]]; then
  type=3
 elif [[ $line = *$access* ]]; then
  type=1
 elif [[ $line = *$other* ]]; then
  type=5
 fi

 if [[ $type -eq 1 ]]; then
  echo -en "${BOLD}${GREEN}"
  line="==> access.log <=="
  let "type--"
 elif [[ $type -eq 3 ]]; then
  echo -en "${BOLD}${RED}"
  line="==> error.log <=="
  let "type--"
 elif [[ $type -eq 5 ]]; then
  echo -en "${BOLD}${CYAN}"
  line="==> other_vhosts_access.log <=="
  let "type--"
 elif [[ $type -eq 0 ]]; then
  echo -en "${NONE}${GREEN}"
 elif [[ $type -eq 2 ]]; then
  echo -en "${NONE}${RED}"
 elif [[ $type -eq 4 ]]; then
  echo -en "${NONE}${CYAN}"
 fi

 echo -e "${line}${RESET}"
done < <(tail -fn0 /var/log/apache2/*.log)
