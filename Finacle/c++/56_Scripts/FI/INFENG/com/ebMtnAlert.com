#------------------------------------------------------------------------------------------------
#  Name            : ebMtnAlert.com 
#  Description     : MTN  
#  Date            : 15-09-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             15-09-2020      Vino Palani          Original Version
#-----------------------------------------------------------------------------------------------
frmmail="customercare@equitybank.co.ke"
tomail=$1
poNum=$2
poAmt=$3
poCrAcctId=$4
poStatus=$5
moduleType=$6
dtime=`date`
dte=`date +%m-%d-%Y`
if [ ${moduleType} = "MTN" ]
then
BdMsg="Please be advised that the following payorder(s) is/are pending manual verification: ${poCrAcctId} had the following transactions on ${dtime}"
msgO="1) PayOrder Number ${poNum} PayOrder Amount ${poAmt} "
tooo="GREETINGS Uganda Treasury Team "
fi
if [ ${moduleType} = "MTN" ]
then
subject=" MTN PayOrder Verification ${dtime}"
fi
(
         echo "From: ${frmmail}"
         echo "To: ${tomail}"
         echo "Subject: ${subject}"
         echo "MIME-Version: 1.0"
         echo "${tooo}"
         echo  " "
         echo "${BdMsg}"
         echo "${msgO}"
         echo " "
	 echo "This is an electronically generated advice and requires no signature."
	 echo "Kind regards,"
	 echo "Customer Care Manager,"
	 echo "Equity Bank(Kenya) Limited."
	 echo "email: info@equitybank.co.ke"
	 echo "Tel:+254763063000"
	 echo "KeEquityBank,@KeEquityBank"
	 echo "www.ke.equitybankgroup.com"
	 echo "KeEquityBank"
	 echo "@KeEquityBank"
	 echo "http://www.youtube.com/EquityBank"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail}
echo ${tomail}  ${moduleType} ${BdMsg} ${msgO} ${tooo}>> exem.log
exit 0
