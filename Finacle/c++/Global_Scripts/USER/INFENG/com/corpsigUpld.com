. /etc/b2k/$FINACLE_INSTALL_ID/FINCORE/$FIN_BANK_ID/com/commonenv.com
ip_address=$1
file_name=$2
uploadclient LIMO://$ip_address//\ $file_name

