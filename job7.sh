su -
apt install sudo y
sudo apt-get install proftpd openssl
sudo apt-get install net-tools
sudo addgroup "$ftpgroup"
read "$ftpgroup"
sudo adduser "$user1" -home /ftpshare --force-badname-ft
read "$user1"
sudo adduser "$user1" "$ftpgroup"
sudo ufw allow 22/tcp
sudo ufw allow 21/tcp
sudo ufw enable
sudo systemctl restart vsftpd
sudo nano /etc/vsftpd.conf
     anonymous_enable=YES
     anon_upload_enable=ON
     anon_mkdir_write_enable=ON
     anon_other_write_enable=ON
     anon_world_readable_only=YES
     anon_root=/etc/vsftpd.anon
sudo openssl req -new -x509 -days 365 -node -out /etc/ssl/private/vsftpd.cert.pem -keyout /etc/ssl/private/vsftpd.key.pem
sudo chown root:root /etc/ssl/private/vsftpd.cert
sudo chmod 600 /etc/ssl/private/vsftpd.cert
sudo nano /etc/vsftpd.conf
     ssl_enable=YES
     allow_anon_ssl=NO
     force_local_data_ssl=NO
     force_local_logins_ssl=YES
     ssl_tlsv1=YES
     ssl_sslv2=YES
     ssl_sslv3=YES
rsa_cert_file=/etc/ssl/private/vsftpd.cert.pem
rsa_private_key_file=/etc/ssl/private/vsftpd.key.pem
sudo service vsftpd reload
