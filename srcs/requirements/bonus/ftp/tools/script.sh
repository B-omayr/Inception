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

sed -i -r "s/#write_enable=YES/write_enable=YES/1"   /etc/vsftpd.conf
sed -i -r "s/#chroot_local_user=YES/chroot_local_user=YES/1"   /etc/vsftpd.conf

echo "
local_enable=YES
allow_writeable_chroot=YES
pasv_enable=YES
local_root=/home/ibra/ftp
pasv_min_port=40000
pasv_max_port=40005
userlist_file=/etc/vsftpd.userlist" >> /etc/vsftpd.conf

service vsftpd stop

/usr/sbin/vsftpd