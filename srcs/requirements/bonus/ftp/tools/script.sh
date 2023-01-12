#!/bin/bash



# Add the USER, change his password and declare him as the owner of wordpress folder and all subfolders
service vsftpd start

adduser $FTP_user --disabled-password

echo "$FTP_user:$FTP_pass" | /usr/sbin/chpasswd
echo "$FTP_user" | tee -a /etc/vsftpd.userlist 

mkdir -p /Users/$FTP_user/ftp

chown nobody:nogroup /Users/$FTP_user/ftp
chmod a-w /Users/$FTP_user/ftp

mkdir /Users/$FTP_user/ftp/files
chown $FTP_user:$FTP_user /Users/$FTP_user/ftp/files

service vsftpd stop

/usr/sbin/vsftpd