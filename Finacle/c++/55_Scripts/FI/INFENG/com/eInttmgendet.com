#------------------------------------------------------------------------------------------------
#  Name            : eInttmgendet.com
#  Description     : Send Email for Interest Modifications
#  Date            : 01-04-2021
#  Author          : Edwin Zico
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             01-04-2021      Edwin Zico         Original Version
#-----------------------------------------------------------------------------------------------
frmmail="No-Reply@equitybank.co.ke"
tomail=$1
Acct=$2
CrncyCode=$3
IntStartDate=$4
IntLastDate=$5
UserId=$6
maxIntCr=$7
minimumAmt=$8
IntCode=${9}
IntDesc=${10}
IntDesc2=${11} 
dtime=`date +%H:%M:%S`
dte=`date +%m-%d-%Y`
BdMsg="Please be advised that ${CrncyCode} A/C No. ${Acct} interest has been modified at ${dtime} on ${dte} by ${UserId}."
BdMsg2="Details:"
BdMsg3="Interest Code: ${IntCode} - ${IntDesc} ${IntDesc2}, Interest start date ${IntStartDate} and last interest modification date ${IntLastDate}."
BdMsg4="Interest Rate %: ${maxIntCr}"
BdMsg5="Minimum Amount : ${minimumAmt}"
#echo ${tomail} ${BdMsg} ${BdMsg2} ${BdMsg3} >> exem.log
subject="INTEREST MODIFICATION ADVICE."
#fi
(
	echo "From: ${frmmail}"
	echo "To: ${tomail}"
	echo "Subject: ${subject}"
	echo "MIME-Version: 1.0"
	echo "Greetings,"
	echo  " "
	echo "${BdMsg}"
	echo "${BdMsg2}"
	echo "${BdMsg3}"
	echo "${BdMsg4}"
	echo "${BdMsg5}"
	echo  " "	
	echo "This is electronically generated advice and requires no signature."
	echo " "
	echo "Equity Bank(Kenya)Limited."
	echo "email:info@equitybank.co.ke"
	echo "Tel:+254763063000"
	echo "www.facebook.com/KeEquityBank  www.twitter.com/KeEquityBank www.equitygroupholdings.com"
	#uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail}
#echo ${tomail} ${BdMsg} ${BdMsg2} ${BdMsg3} ${IntDesc} ${IntDesc2} >> exem.log
exit 0
