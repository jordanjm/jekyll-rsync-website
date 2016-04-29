#! /bin/bash

KEYLOCATION="$HOME/PATH-TO-KEY"
LOCALWEBSITEFILES="$HOME/JEKYLL-SITE-DIRECTORY/_site/"
REMOTEUSERNAME="REMOTE-USERNAME"
REMOTESERVER="REMOTE-SERVER"

#Check if the _site directory exists and delete it
if [ -d "$LOCALWEBSITEFILES" ]; then
        rm -rf $LOCALWEBSITEFILES
fi

#Build the Jekyll Site
jekyll build

#Copy the Jekyll Site To the Server
rsync --verbose --compress --hard-links --checksum --recursive --rsh="ssh -p 4242 -i $KEYLOCATION" $LOCALWEBSITEFILES $REMOTEUSERNAME@$REMOTESERVER:
