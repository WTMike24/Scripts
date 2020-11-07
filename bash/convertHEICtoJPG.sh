#!/bin/bash

# Build instructions:
#  https://medium.com/@eplt/5-minutes-to-install-imagemagick-with-heic-support-on-ubuntu-18-04-digitalocean-fe2d09dcef1
# Command:
#  https://zwbetz.com/convert-heic-images-to-jpg/

# The folder with the files you want to convert
directory=/mnt/c/Users/root/Camera\ Uploads
# Set to 0 to delete the original .heic files after they are converted
keeporiginals=1

# Change into the folder with our images
cd "$directory"

# Loop over all the .heic files in the folder
for heic in *.heic; do
 # Drop the .heic extension and append .jpg instead
 jpg=`echo "$heic" | rev | cut -d. -f2- | rev`.jpg
 # If the file we are going to make does not exist, run the command to convert it
 [ -f "$jpg" ] || /usr/local/bin/mogrify -format jpg "$heic"
 # If we don't want the originals, give them the axe
 [ $keeporiginals -eq 0 ] && rm "$heic"
done
