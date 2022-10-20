#!/usr/bin/bash
sudo addgroup ftpgroup
my_input="/home/panabieres/Shell_Userlist.csv"
declare -a Prenom
declare -a Mdp
declare -a Role

while IFS=, read -r Prenom Mdp Role;
do
        Prenom+=("$Prenom")
        Mdp+=("$Mdp")
        Role+=("$Role")

done<$my_input

for index in "${!Prenom[@]}";
do
    sudo adduser "$Prenom" ftpgroup
    sudo chmod +x $Prenom /etc/vsftpd.conf
    sudo groupadd "${Role[$index]}";
    sudo useradd -g "${Role[$index]}" \
                 -d "/home/${Prenom[$index]}" \
             -s "/bin/bash" \
             -p "$(echo "${Mdp[$index]}" | openssl passwd -1 -stdin)" "${Prenom[$index]}"
         done
