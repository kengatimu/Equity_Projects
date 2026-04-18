#++++++++++++++++++++++++++++++++++++++++
#vino palani for mail smtp
#++++++++++++++++++++++++++++++++++++++++
frmmail="Customer.care@equitybank.co.ke"
tomail=$1
PartyName=$2
PartyLname=$3
PartyAcct=$4
LoanAmt=$5
frmPartyName=$6
frmPartyLname=$7
refNum=$8
ccmail=$9
dtime=`date +%H:%M:%S`
dte=`date +%m-%d-%Y`
LnMsg="Please be advised that your Account ${PartyAcct} has been credited with Kes.${LoanAmt} from, ${frmPartyName} ${frmPartyLname} Reference Number ${refNum} at ${dtime} on ${dte} for EazzyStock Financing."
subject="EazzyStock Financing Credit Advice"
#export CONTENT="${filname}"
(
         echo "From: ${frmmail}"
         echo "To: ${tomail}"
         echo "Subject: ${subject}"
         echo "MIME-Version: 1.0"
         echo "Dear ${PartyName},"
         echo  " "
         echo "${LnMsg}"
         echo " "
         echo "This is electronically generated advice and requires no signature."
         echo " "
         echo "Thank you for your continued support"
         echo "Equity Bank(Kenya)Limited. email:info@equitybank.co.ke Tel:+254763063000"
	 echo "www.facebook.com/KeEquityBank www.twitter.com/KeEquityBank www.ke.equitybankgroup.com"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail} -t "Cc:${ccmail}"
exit 0
