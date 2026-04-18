#++++++++++++++++++++++++++++++++++++++++
#vino palani for mail smtp
#++++++++++++++++++++++++++++++++++++++++
frmmail="Customer.care@equitybank.co.ke"
tomail=$1
cusname=$2
cusAmt=$3
cusAcct=$4
tranId=$5
trandrcr=$6
tranc=$7
if [ ${trandrcr} = "C" ]
then
	drmsg="Credited to"
fi
if [ ${trandrcr} = "D" ]
then
	drmsg="Debited from"
fi
tranDate=`date +%d-%m-%Y%H:%M:%S`
finMsg="Dear ${cusname} ${tranc} ${cusAmt} has been ${drmsg} your account ${cusAcct}  ${tranId} on ${tranDate} . For any queries, contact 0763063000"
subject="Transaction Advice"
###export CONTENT="${filname}"
(
	 echo "From: ${frmmail}"
	 echo "To: ${tomail}"
	 echo "Subject: ${subject}"
	 echo "MIME-Version: 1.0"
	 echo "Hi ${cusname},"
	 echo "            Find an transaction advice as below....." 
	 echo  " "
	 echo "            ${finMsg}"
	 echo " "
	 echo "-- "
	 echo "Thanks"
	 echo "Equity Bank Customer Care"
	 echo "Note: Please do not reply on this system generated mail.." 
	## uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail} 
exit 0
