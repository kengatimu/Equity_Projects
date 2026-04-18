#------------------------------------------------------------------------------------------------
#  Name            : ebCommonTranAlert43AML.com 
#  Description     : Tran Alerts 
#  Date            : 24-02-2020
#  Author          : Vino Palani
#  Menu Option     : NA
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             24-02-2020      Vino Palani          Original Version
#  1.1             24-12-2020      Edwin Zico		French Version 	
#-----------------------------------------------------------------------------------------------
frmmail="serviceclient@bcdc.cd"
tomail=$1
Foracid=$2
Acctname=$3
Acct_Crncy_Code=$4
Clr_Bal_Amt=$5
Emp_Id=$6
Emp_Name=${7}
Emp_Email_Id=${8}
Teller_Sol_Id=${9}
Teller_Sol_Id_Desc=${10}
moduleLien=${11}
Sol_Id=${12}
Gl_Sol_Desc=${13}
date=${14}
dtime=`date`
dte=`date +%m-%d-%Y`
if [ ${moduleLien} = "Y" ]
then
BdMsg="Please be informed that, BranchCode:${Sol_Id}, BranchName:${Gl_Sol_Desc}, Teller ${Emp_Name}, GL Account No: ${Foracid}, GL Name: ${Acctname} Current Balance ${Acct_Crncy_Code} : ${Clr_Bal_Amt} on ${dtime} Limit has been reached, Please Action."
msgO=" "
tooo="HI, "
fi

if [ ${moduleLien} = "N" ]
then
BdMsg="Nous vous informons que . "
msgO=" ${Emp_Email_Id} "
tooo="${Teller_Sol_Id} ${Gl_Sol_Desc},"
fi
if [ ${moduleLien} = "N" ]
then
subject="Alerte par e-mail de transaction pour votre compte EQUITYBCDC Bank."
fi
if [ ${moduleLien} = "Y" ]
then
subject=" Teller Limits Alert"
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
	 echo "Nous vous prions de ne pas répondre à ce message automatique."
	 echo " "
	 echo "Bien cordialement,"
	 echo "Service Clientèle,"
	 echo "Equity BCDC"
	 echo "courriel: serviceclient@bcdc.cd"
	 echo "Tél: 41909 ou +243996018000"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail}
exit 0
