#------------------------------------------------------------------------------------------------
#  Name            : ebspcs.com 
#  Description     : 
#  Date            : 17-02-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             17-02-2020      Vino Palani          Original Version
#-----------------------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx
frmmail="finacle10@equitybank.co.ke"
userid=$1
Partyid=$2
Partypwd=$3
ppdd=$4
uuidd=$5
icp=`echo $USER_PASS`
lpt=`echo ${ONS_LOG_DIR} |awk '{print substr($1, 1, length($1)-9)}'`
spcp=${lpt}"cust/INFENG"
$JAVA_HOME/bin/java -cp ${spcp} com.cubpEquityDirect.spcs.spcs $userid $Partypwd >${ppdd}/${uuidd}/up_${Partypwd}_${userid}.sql

sqlplus -s ${icp} <<EOF
        set feedback off;
        start ${ppdd}/${uuidd}/up_${Partypwd}_${userid}.sql 
	update ssoadm.user_creds_tbl set disabled_from_date =sysdate-10,disabled_upto_date=sysdate-10,num_pwd_attempts='0', new_user_flg='N',pw_expy_date=sysdate where user_id like '${userid}';
	commit;
EOF
dtime=`date +%H:%M:%S`
dte=`date +%m-%d-%Y`
BdMsg="The password for ${userid} is ${Partypwd}"
subject="Prod::Password Generation Mail"
(
         echo "From: ${frmmail}"
         echo "To: ${Partyid}"
         echo "Subject: ${subject}"
         echo "MIME-Version: 1.0"
         echo "Dear ${userid},"
         echo  "Note: This is for Preprod envirnoment!!!!!!!!! "
         echo "${BdMsg}"
         echo " "
         echo " "
         echo " "
         ##echo "Equity Bank(Kenya)Limited. email:info@equitybank.co.ke Tel:+254763063000"
	 ##echo "www.facebook.com/KeEquityBank www.twitter.com/KeEquityBank www.ke.equitybankgroup.com"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${Partyid} -t "Cc:${Partyid}"
rm -f ${ppdd}/${uuidd}/up_${Partypwd}_${userid}*.sql
exit 0
