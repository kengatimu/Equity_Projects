#------------------------------------------------------------------------------------------------
#  Name            : ebCommonTranAlert43.com 
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
bank=${12}
time=${13}
date=${14}
##echo ${tomail} ${trId} ${moduleLien} >> exem.log
dtime=`date`
dte=`date +%m-%d-%Y`
if [ ${moduleLien} = "Y" ]
then
BdMsg="Please be informed that Account ${PartyAcct}, transaction ID ${trId}, a ${drmsg} amount ${crcy} ${LoanAmt} on ${dtime} has been Liened pending further details and analysis from yourself."
msgO=" "
##tooo="Dear Team"
fi
if [ ${salu} = "MR" ]
then
        salu="MONSIEUR"
	tooo="CHER"
else
        salu="MADAME"
	tooo="CHÈRE"
fi
if [ ${drOrcr} = "DEBITE" ]
then 
	drOrcr="DÉBIT"
else
	drOrcr="CRÉDIT"
fi
##echo ${tomail} ${trId} ${moduleLien} ${drOrcr} >> exem2.log
if [ ${moduleLien} = "N" ]
then
BdMsg="Nous vous informons que votre compte ${PartyAcct} a enregistré la transaction suivante le ${date} à ${time}. "
msgO="${drOrcr} de ${crcy} ${LoanAmt} ${tparti} "
tooo="${tooo} ${salu} ${PartyName} ${PartyLname},"
fi
if [ ${moduleLien} = "N" ]
then
subject="Alerte par e-mail de transaction pour votre compte Equity Bank"
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
	 echo "Nous vous prions de ne pas répondre à ce message automatique."
	 echo " "
	 echo "Bien cordialement,"
	 echo "Service Clientèle,"
	 echo "EBCDC / SIEGE - KINSHASA"
	 echo "courriel: serviceclient@bcdc.cd"
	 echo "Tél: 41909 ou +243996018000"
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail}
exit 0
