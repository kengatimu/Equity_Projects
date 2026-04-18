#------------------------------------------------------------------------------------------------
#  Name            : ebMnOf.com
#  Description     : 940 Alerts
#  Date            : 25-02-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             25-02-2020      Vino Palani          Original Version
#-----------------------------------------------------------------------------------------------
/etc/b2k/EQPROD/FINCORE/54/com/commonenv.com
echo $FIN_BANK_ID
nacct="1220299727755"
wd="/finacle/EQPROD/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/PAYSYS54/LOG/MSG_BKP/"
cd ${wd}
logfil=`date +%m%d%Y%H%M%S`".log"
datr="940${nacct}"`date +%m%d%H%M%S`".txt"
for fil in `find /finacle/EQPROD/Fin10218/APP/Finacle/FC/app/CDCI_LOGS/PAYSYS54/LOG/MSG_BKP -mtime 0 -type f | xargs ls -lrt |  awk  '{ print $9 }'`
do
isInFile=$(cat ${fil} | grep -c "${nacct}")
if [ $isInFile -ge 1 ]; then
echo "in loop" >> ${wd}${logfil}
datr="940${nacct}"`date +%m%d%H%M%S`".txt"
cp -p ${fil} ${wd}${datr}
frmmail="estatement@equitybank.co.ke"
bdAdr="twanja@ktdateas.com"
########tomail="vino.palani@simbatech.biz,zicoedwin@gmail.com,Sanayianrose@gmail.com"
########tomail="vino.palani@simbatech.biz,twanja@ktdateas.com,zicoedwin@gmail.com,Sanayianrose@gmail.com"
###########tomail="twanja@ktdateas.com,fa@kapkoros.ktdateas.com,fum@kapkoros.ktdateas.com,ndungur@gmail.com"
###########tomail="ndungur@gmail.com,vino.palani@simbatech.biz,vino2795@gmail.com"
tomail="twanja@ktdateas.com,fa@kapkoros.ktdateas.com,fum@kapkoros.ktdateas.com,ndungur@gmail.com,sielebeatrice@gmail.com,fwairimu95@gmail.com,twsudi@gmail.com,Sanayianrose@gmail.com,sos.gygy@gmail.com"
BdMsg="Attached is your MT940 Statement."
subject="940 Estatements Equity Bank"
(
 echo "From: ${frmmail}"
 echo "To: ${bdAdr}"
 echo "Subject: ${subject}"
 echo "MIME-Version: 1.0"
 echo "Dear Customer,"
 echo " "
 echo "${BdMsg}"
 echo " "
 echo "This is an auto generated email and is not monitored for incoming emails."
 echo "Please do not reply,Contact Your Equity Bank branch in case of any query"
 echo "Sincerely,"
 echo "Equity Bank(Kenya)Limited. email:info@equitybank.co.ke Tel:+254763063000"
 echo "www.facebook.com/KeEquityBank www.twitter.com/KeEquityBank www.ke.equitybankgroup.com"
uuencode ${wd}${datr} $(basename ${wd}${datr})
) | /usr/sbin/sendmail  ${tomail}
rm -f ${wd}${datr}
fi
done
exit
