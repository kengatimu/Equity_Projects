#------------------------------------------------------------------------------------------------
#  Name            : AcctActivationError.com
#  Date            : 13-10-2020
#  Author          : Edwin Zico
#  Input           : NA
#  Output          : NA
#  Called Script   : NA
#  Calling Script  : CustInactiveAcctActivation.scr 
#  Menu Option     : TBJMS
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             13-10-2020      Edwin Zico           Original Version
#-----------------------------------------------------------------------------------------------
frmmail="No-Reply@equitybank.co.ke"
tomail=$1
foracid=$2
solid=$3
boddate=$4
errorsact=$5
moduleType=$6
#ccmail=$7
dtime=`date`
dte=`date +%m-%d-%Y`
if [ ${moduleType} = "AAE" ]
then
BdMsg="Please be advised that account ${foracid} was Auto-Activated on ${dtime} and failed to activate due to below reason(s)."
msgO="1) ${errorsact} date ${boddate}. "
BdMsg2="Kindly do manual activation from Inactive to active  from the branch."
tooo="GREETINGS BGDM "
fi
if [ ${moduleType} = "AAE" ]
then
subject="ACCOUNT ACTIVATION ERROR ${dtime}"
fi
(
         echo "From: ${frmmail}"
         echo "To: ${tomail}"
	 #echo "Cc: ${ccmail}"		
         echo "Subject: ${subject}"
         echo "MIME-Version: 1.0"
         echo "${tooo}"
         echo  " "
         echo "${BdMsg}"
         echo "${msgO}"
         echo "${BdMsg2}"	
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
#echo ${tomail} ${moduleType} ${BdMsg} ${msgO} ${tooo}>> exem.log
exit 0

