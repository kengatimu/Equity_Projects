#------------------------------------------------------------------------------------------------
#  Name            : ebIrm.com
#  Description     : RemitLimit
#  Date            : 29-11-2019
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             29-11-2019      Vino Palani          Original Version
#-----------------------------------------------------------------------------------------------
frmmail="No-Reply@equitybank.co.ke"
tomail=$1
PartyName=$2
PartyLname=$3
PartyAcct=$4
LoanAmt=$5
frmPartyName=$6
frmPartyLname=$7
refNum=$8
##ccmail=$9
ccmail=${10}
bdAdr=${10}
tparti=${11}
dtime=`date +%H:%M:%S`
dte=`date +%m-%d-%Y`
BdMsg="Please be advised that A/C No. ${PartyAcct} A/c Name: ${PartyName} ${PartyLname} has received a remittance of amount  Kes.${LoanAmt}. The  Remittance ${tparti} has been marked lien with Reference Number ${refNum} at ${dtime} on ${dte}. As par regulatory requirement, you are required to undertake a KYC and where appropriate advise the client to submit support documents for the proceeds."
subject="Incoming Remittance Advice"
(
         echo "From: ${frmmail}"
         echo "To: ${bdAdr}"
         echo "Subject: ${subject}"
         echo "MIME-Version: 1.0"
         echo "Dear BGDM/Operations Manager," 
         echo  " "
         echo "${BdMsg}"
         echo " "
         echo "This is electronically generated advice and requires no signature."
         echo " "
         echo "Equity Bank(Kenya)Limited. email:info@equitybank.co.ke Tel:+254763063000"
	 echo "www.facebook.com/KeEquityBank www.twitter.com/KeEquityBank www.ke.equitybankgroup.com"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail} -t "Cc:${ccmail}"
exit 0
CuMsg="Please be advised that your A/C No. ${PartyAcct} A/c Name: ${PartyName} ${PartyLname} has received a remittance of amount  Kes.${LoanAmt}. with Equity Bank Reference Number ${refNum} at ${dtime} on ${dte}.  As par regulatory requirement, you are required to submit support documents for the proceeds."
subject="CBK Remittance Lien Advice"
(
         echo "From: ${frmmail}"
         echo "To: ${tomail}"
         echo "Subject: ${subject}"
         echo "MIME-Version: 1.0"
         echo "Dear ${PartyName},"
         echo  " "
         echo "${CuMsg}"
         echo " "
         echo "Thank you for banking with us."
         echo " "
         echo "This is electronically generated advice and requires no signature."
         echo "Equity Bank(Kenya)Limited. email:info@equitybank.co.ke Tel:+254763063000"
	 echo "www.facebook.com/KeEquityBank www.twitter.com/KeEquityBank www.ke.equitybankgroup.com"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail} -t "Cc:${ccmail}"
exit 0
