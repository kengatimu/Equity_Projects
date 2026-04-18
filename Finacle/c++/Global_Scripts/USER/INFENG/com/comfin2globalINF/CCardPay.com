#------------------------------------------------------------------------------------------------------------------    
#	Name			: CCardPay.com
#	Description		: It will generate a report in HPR 
#	Date			: 12-02-2013
#	Author			: GOKULKRISHNA
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				12-02-2013		GOKULKRISHNA			Original Version
#--------------------------------------------------------------------------------------------------------------------

#. `execom commfunc.com`
trap '' 2 3 
input="$1"
Report="CARD PAYMENT REPORT"
RptFile="Ccardpay_$$"
lstFile="Ccardpay_$$.lst"
lstFile1="Ccardpaytemp_$$.lst"


bauu9151 $TBA_PROD_ROOT/cust/01/INFENG/sql/CCardPayment.sql $1 $2 $3 $4 > $lstFile
sed '/^$/d' $lstFile > $lstFile1 
sed 's/\~/ /g' $lstFile1 > $lstFile
babx4040 ${B2K_SESSION_ID} "$lstFile" "$Report" "MANAGER" "1" "N"

if [ $? -ne 0 ]
then
    echo "Report Generated. To View/Print, Use HPR Menu."
fi
exit 0
