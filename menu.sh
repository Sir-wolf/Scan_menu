#!/bin/bash

echo "Checking packages ..."; echo ""
if [ -x "$(command -v yum)" ]; then
    if rpm -qa | grep -q john && rpm -qa | grep -q gobuster && rpm -qa | grep -q nmap ;then
        :
    else
        sudo yum -y install john gobuster nmap
    fi
elif [ -x "$(command -v apt-get)" ]; then
    if dpkg -l | grep -q john && dpkg -l | grep -q gobuster && dpkg -l | grep -q nmap; then
        :
    else
        sudo apt-get -y install john gobuster nmap
    fi
else
    :
fi
clear
cat logo_menu.txt
PS3='Please enter your choice: '
options=("John The Ripper" "goBuster" "smbmap" "Use Python for Bash" "nmap" "Quit")

select hack in "${options[@]}"
do
    case $hack in
        "John The Ripper")
            read -p "Enter hash location: " hash
            echo "Decyption methods: md5, DES, MySQL, sha1, sha-224, sha-256, sha-384 sha-512"; echo ""
            read -p "Enter decryption method: " dec
            if $dec == "md5"; then
                dec = "raw-md5"
            elif $dec == "DES"; then
                dec == "des"
            elif $dec == "MySQL"; then
                dec == "mysql"
            elif $dec == "sha1"; then
                dec = "raw-sha1"
            elif $dec == "sha-224"; then
                dec = "raw-sha224"
            elif $dec == "sha256"; then
                dec = "raw-sha256"
            elif $dec == "sha-384"; then
                dec = "raw-sha384"
            elif $dec == "sha-512"; then
                dec = "raw-sha512"
            else
                echo "Not Available"
            fi
            john --format=$dec $hash
            ;;
        "goBuster")
            read -p "Enter WebURL: " WebURL
            echo "Wordlist location: /usr/share/wordlists"
            read -p "Enter wordlists: " WL
            #read -p "type of files" $EXT
            gobuster dir -u $WebURL -w $WL 
            #-x $EXT
            echo $options[0-4]
            ;;
        "smbmap")
            read -p "Enter Hostname or IP Address: " Host
            Host1="-H ${Host}"
            read -p "Enter Username: " UN
            UN1="-u ${UN}"
            read -p "Enter Password: " PW
            PW1="-p ${PW}"
            /usr/sysadmin/github/smbmap/smbmap.py $UN1 $PW1 $Host1
            ;;
        "Use Python for Bash")
            echo "this is after you gain access to a user through metasploit or nmap"; echo""
            echo "You type python -c 'import pty;pty.spawn('/bin/bash')'"
            ;;
        "nmap")
            read -p "Enter Hostname or IP Address: " Host
            read -p "Enter location to save nmap scan: " loc
            nmap -sC -sV -A -vv $Host | tee $loc
            ;;
        "Quit")
            break
            ;;
        *) echo "invalid option $REPLY";;
    esac
done