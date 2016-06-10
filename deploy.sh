#! /bin/bash

KEYLOCATION="$HOME/PATH-TO-KEY"
LOCALWEBSITEFILES="$HOME/JEKYLL-SITE-DIRECTORY/_site/"
REMOTEUSERNAME="REMOTE-USERNAME"
REMOTESERVER="REMOTE-SERVER"
REMOTEWEBPATH="REMOTE-WEBROOT-DIRECTORY"
PORT="PORT-NUMBER"

#Check if the _site directory exists and delete it
if [ -d "$LOCALWEBSITEFILES" ]; then
        rm -rf $LOCALWEBSITEFILES
fi

#Build the Jekyll Site
jekyll build

#Generate new .htaccess file
echo "RewriteEngine On" >> $LOCALWEBSITEFILES/.htaccess
echo "RewriteCond %{SERVER_PORT} 80" >> $LOCALWEBSITEFILES/.htaccess
echo "RewriteRule ^(.*)$ https://www.$REMOTEUSERNAME.com/$1 [R=301,L]" >> $LOCALWEBSITEFILES/.htaccess
echo "ErrorDocument 404 https://www.$REMOTEUSERNAME.com/404/index.html" >> $LOCALWEBSITEFILES/.htaccess

#Copy the Jekyll Site To the Server
rsync -avz --checksum -e "ssh -p $PORT -i $KEYLOCATION" $LOCALWEBSITEFILES $REMOTEUSERNAME@$REMOTESERVER:$REMOTEWEBPATH
