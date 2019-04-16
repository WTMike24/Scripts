# Bash Scripts

##### colors.list:

Included in various other scripts to allow for the use of colors on the command line (will eventually swap this out for tput)

##### youtube-dl-batch.sh

Used for downloading playlists (or individual songs) from youtube to .mp3 files.

TODO

- Have script download list of videos and asyncronously download them all at once
    (tried this downloading all at once, absolutely destroys CPU and networking, maybe look into limiting threads?)
- Include a separate file that has pre-defined playlists

##### pinger

Created for monitoring a slow and intermittent internet connection so that you can audibly hear when the connection goes down (10 pings fail) and when it comes back up afterwards

##### watchLog.sh

Created to monitor the apache logs while working on a school project (watches /var/log/apache2/\*.log and has colors chosen for error.log, access.log, and other_vhosts_access.log)

##### installAsciiquarium.sh

Installs [ASCIIquarium](https://robobunny.com/projects/asciiquarium/html/) onto a linux system running Ubuntu

##### stamp

That's stamp as in timestamp. Prepends the current date and time to whatever you pipe to it. Useful if you have to monitor the times in which network connectivity is lost and restored. I like `ping 8.8.8.8 -O | stamp | tee pings.txt`

##### song-download-thing

A quick script I threw together because the site that had the songs I wanted to download wouldn't allow you to download them all at once for 80+ songs without a fee even though you could download them individually for free. (Couldn't find any source that gave the creators of the music any money so this is what I did instead). I edited out the real site name and HTML contents as this was probably against their ToS
