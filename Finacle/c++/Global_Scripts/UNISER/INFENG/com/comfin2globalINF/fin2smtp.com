#======================================================================
#File Name      : fin2smtp.com 
#Description    : Com file to ftp Account statements to Mailing server 
#Modification History :
#
#Sl#    Date         Author           Version
#---   --------   ------------        --------- 
# 1     26-Nov-2013  Pritish_George   Oiginal Version
#======================================================================


#============ FTP PARAMETERS ========================================== 

FTP_HOST="10.1.1.87"
FTP_USER="Statements"
FTP_PASSWORD="Statements"
LOCAL_PATH='/finreports/ESTATEMENTS'
ARCHIVAL_PATH='/finreports/ESTATEMENTS_ARCHIVAL'

#=======================================================================

dt_tm=`date +%a_%d%m%Y_%H%M%S_$$`

echo "FTP Started from `hostname` to 10.1.1.87"

CheckLoginDetails()
{

#======================================================================
# Function to check login credentials
#======================================================================

echo "checking login details"

TempERRFILE=$(echo "TempERR_FILE_${dt_tm}_"$$".log")


if [ "$FTP_HOST" == "" ]
then
echo "FTP_HOST is not Defined" >> $TempERRFILE
cat $TempERRFILE
return 1
fi

if [ "$FTP_USER" == "" ]
then
echo "FTP_USER is not Defined" >> $TempERRFILE 
cat $TempERRFILE 
return 1
fi

if [ "$FTP_PASSWORD" == "" ]
then
echo "FTP_PASSWORD is not Defined" >> $TempERRFILE  
cat $TempERRFILE
return 1
fi

}

doFTP()
{

#=====================================================================
# Function to do FTP
#=====================================================================

cd $LOCAL_PATH

#========Get the list of files to be FTP'ed =========================

ls -lrt|grep TMP|awk '{print $9}' >> ${LOCAL_PATH}/FILE_LIST_${dt_tm}_"$$".log


for file in `cat ${LOCAL_PATH}/FILE_LIST_${dt_tm}_"$$".log`
do

ftp -n $FTP_HOST  <<EOF

quote USER $FTP_USER
quote PASS $FTP_PASSWORD
cd /Statements

put $file 
quit
EOF

echo "FTP of $file done"

mv $file $ARCHIVAL_PATH 

done

}

CheckLoginDetails
doFTP
