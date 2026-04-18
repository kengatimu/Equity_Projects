#------------------------------------------------------------------------------------------------
#  Name            : eAccOpenNotify.com 
#  Date            : 01-07-2021 
#  Author          : Edwin Zico
#  Input           : NA
#  Output          : NA
#  Called Script   : NA
#  Calling Script  : eAccOpenNotify.scr 
#  Menu Option     : HOAACCA 
#  Srl. No         Date            Author               Description.
#  -------         ------          ------               ------------
#  1.0             01-07-2021      Edwin Zico           Original Version
#-----------------------------------------------------------------------------------------------
frmmail="No-Reply@equitybank.co.ke"
tomail=$1
foracid=$2
schmCode=$3
cifId=$4
BODDate=$5
solId=$6
ModuleType=$7
crncyCode=$8
Iban=$9
dtime=`date`
##echo ${tomail} ${foracid} ${schmCode} ${cifId} ${BODDate} ${solId} ${crncyCode} ${moduleType}
BdMsg="Please be advised that ${crncyCode} account ${foracid} for customer cif ${cifId} has been opened on ${dtime} at your branch ${solId}."
tooo="Cher Client"
echo ${tomail} ${foracid} ${ccmail} ${cifId} ${BODDate} ${solId} ${crncyCode} ${moduleType} ${BdMsg} ${tooo}>> exem.log
subject="Equity BCDC: NOTIFICATION D'OUVERTURE DE COMPTE"
(
		echo "From: ${frmmail}"
		echo "To: ${tomail}"
		echo "Cc: ${tomail}"		
		echo "Subject: ${subject}"
		echo "MIME-Version: 1.0"
		echo "${tooo}"
		echo  " "
		echo " Nous avons le plaisir de vous communiquer le numéro de votre compte diaspora ouvert en nos livres : "
		echo " "
		echo "  ·Numéro de compte : ${foracid} "
		echo "  ·Numéro IBAN : ${Iban} "
		echo "  ·Devise : ${crncyCode}  "
		echo "  ·Agence : ${solId} "
		echo "  ·Date : ${BODDate} "
		echo " "
		echo " Nous vous prions à présent, au cas où vous ne l’auriez pas encore fait, de procéder à l’approvisionnement de votre compte pour nous permettre de vous commander les différents produits et services. "
		echo " "
		echo " A toutes fins utiles, vous trouverez ci-dessous les informations nécessaires pour la réception d’un transfert international sur votre compte Equity BCDC. "
		echo " "
		echo "  ·Nom de la Banque : Equity Banque Commerciale du Congo SA "
		echo "  ·Adresse de la Banque : 15, Boulevard du 30 Juin, Kinshasa/GOMBE, RDC "
		echo "  ·Code Swift de la Banque : BCDCCDKIXXX "
		echo "  ·Votre IBAN : ${Iban} "
		echo "  ·Code ISO : CD "
		echo " "
		echo "  Pour plus de détails sur les autres solutions rapides de transfert des fonds à partir de l’étranger, nous vous prions de consulter la section « Payer/ envoyer de l’argent » sur le site internet de la Banque (https://equitygroupholdings.com/cd). "
		echo " "
		echo " "
		echo " Bien Cordialement "
		echo " "
		echo " Equipe Diaspora Banking "
		echo " TEL. /WhatsApp: +243 828 380 000 "
		echo " Email :diaspora@equitybcdc.cd "
         #uuencode ${filname} $(basename ${filname})
) | /usr/sbin/sendmail  ${tomail} 
##echo ${tomail} ${moduleType} ${BdMsg} ${msgO} ${tooo}>> exem.log
echo ${tomail} ${foracid} ${ccmail} ${cifId} ${BODDate} ${solId} ${crncyCode} ${moduleType} ${BdMsg} ${tooo}>> exem2.log
exit 0

