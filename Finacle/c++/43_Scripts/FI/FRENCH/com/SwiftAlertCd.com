#------------------------------------------------------------------------------------------------
#  Name            : SwiftAlertCd.com 
#  Description     : SWift Notification  
#  Date            : 15-Apr-2023
#  Author          : Irungu James
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             15-Apr-2023      Irungu James          Original Version
#-----------------------------------------------------------------------------------------------
frmmail="customercare@equitybank.co.ke"
tomail=$1
poNum=$2
poAmt=$3
poCrAcctId=$4
poStatus=$5
moduleType=$6
poDrAcct=$7
poAwiBIC=$8
poCtry=$9
poAwiName=${10}
dtime=`date`
dte=`date +%m-%d-%Y`
if [ ${moduleType} = "SWIFT" ]
then
BdMsg="Please be advised that the following payment is pending manual verification."
tooo="Greetings DRC Team "
fi
if [ ${moduleType} = "SWIFT" ]
then
subject=" Eazzybiz Swift RTGS verification ${dtime}"
fi
(
	echo "From: ${frmmail}"
	echo "To: ${tomail}"
	echo "Subject: ${subject}"
	echo "MIME-Version: 1.0"
	echo "${tooo}"
	echo  " "
	echo "${BdMsg}"
	#echo " Please be advised that the following payment is pending manual verification."
	echo  " "
	echo " Payment from: "
	echo " Account number: ${poDrAcct} "
	echo  " "
	echo " Payment to: "
	echo " Recipient name: ${poAwiName} "
	echo " Account number: ${poCrAcctId} "
	echo " Bank name: ${poAwiBIC} "
	echo " Country: ${poCtry} "
	echo  " "
	echo " Payment details: "
	echo " Amount: ${poAmt}  ${poStatus} "
	echo " Pay Order Number ${poNum} "
	echo " Completed on: ${dtime} "
	echo " "
	echo  " "	
	echo " This is an electronically generated advice and requires no signature."
	echo  " "
	echo  " "
	echo "Kind regards,"
	echo "Customer Care Manager,"
	echo "Equity BCDC."
	echo "http://www.youtube.com/EquityBank"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail}
echo ${tomail}  ${moduleType} ${BdMsg} ${poNum} ${tooo}>> exemug.log
exit 0
