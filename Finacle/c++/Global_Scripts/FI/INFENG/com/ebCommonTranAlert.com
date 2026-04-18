#------------------------------------------------------------------------------------------------
#  Name            : ebCommonTranAlert.com 
#  Description     : Tran Alerts 
#  Date            : 24-02-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             24-02-2020      Vino Palani          Original Version
#-----------------------------------------------------------------------------------------------
frmmail="Customer.care@equitybank.co.ke"
tomail=$1
PartyName=$2
PartyLname=$3
PartyAcct=$4
LoanAmt=$5
trId=$6
tparti=${7}
drOrcr=${8}
crcy=${9}
salu=${10}
moduleLien=${11}
dtime=`date`
dte=`date +%m-%d-%Y`
if [ ${drOrcr} = "C" ]
then
        drmsg="CREDIT"
fi
if [ ${drOrcr} = "D" ]
then
        drmsg="DEBIT"
fi
if [ ${moduleLien} = "Y" ]
then
BdMsg="Please be informed that Account ${PartyAcct}, transaction ID ${trId}, a ${drmsg} amount ${crcy} ${LoanAmt} on ${dtime} has been Liened pending further details and analysis from yourself."
msgO=" "
tooo="Dear Team"
fi
if [ ${moduleLien} = "N" ]
then
BdMsg="Please be advised that your Account: ${PartyAcct} had the following transactions on ${dtime}"
msgO="1) ${drmsg} ${crcy} ${LoanAmt} ${tparti} "
tooo="GREETINGS ${salu} ${PartyName} ${PartyLname} "
fi
if [ ${moduleLien} = "N" ]
then
subject=" Transaction alert for your Equity Bank"
fi
if [ ${moduleLien} = "Y" ]
then
subject=" Suspicious Transaction Alert"
fi
(
         echo "From: ${frmmail}"
         echo "To: ${bdAdr}"
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
exit 0
