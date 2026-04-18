#------------------------------------------------------------------------------------------------
#  Name            : CITEmailAlert.com
#  Date            : 17-08-2023 
#  Author          : Mark Nderitu
#  Input           : NA
#  Output          : NA
#  Called Script   : NA
#  Calling Script  : CITEmailAlert.scr 
#  Menu Option     : N/A 
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             17-08-2023      Mark Nderitu           Original Version
#-----------------------------------------------------------------------------------------------
frmmail="no-reply@equitybcdc.cd"
tomail=$1
massage=$2
ModuleType=$3
dtime=`date`


echo ${tomail}  ${massage}  >> proxy.log
subject="Equity BCDC: OUTSTANDING PROXY"
(
		echo "From: ${frmmail}"
		echo "To: ${tomail}"
		echo "Subject: ${subject}"
		echo "MIME-Version: 1.0"
		 
		echo  " "
		echo  "${massage}"
		echo  " "
		echo " TEL. /WhatsApp: +243 828 380 000 "
		echo " Email :diaspora@equitybcdc.cd "
) | /usr/sbin/sendmail  ${tomail} 

echo ${tomail}  ${massage} >> proxy2.log
exit 0

