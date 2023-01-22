#!/bin/bash



# Add the USER, change his password and declare him as the owner of wordpress folder and all subfolders
service vsftpd start

adduser $FTP_user --disabled-password

echo "$FTP_user:$FTP_pass" | /usr/sbin/chpasswd
echo "$FTP_user" | tee -a /etc/vsftpd.userlist 

mkdir -p /home/$FTP_user/ftp

chown nobody:nogroup /home/$FTP_user/ftp
chmod a-w /home/$FTP_user/ftp

mkdir /home/$FTP_user/ftp/files
chown $FTP_user:$FTP_user /home/$FTP_user/ftp/files

service vsftpd stop

/usr/sbin/vsftpd