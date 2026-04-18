#------------------------------------------------------------------------------------------------------------------    
#	Name			: SAL_LOAD_ERR.com
#	Description		: It will generate a bad and log file report
#	Date			: 13-03-2013
#	Author			: GOKULKRISHNA
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				13-03-2013		GOKULKRISHNA			Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
#trap '' 2 3
reportFileName="$1"


noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName" "Salary Upload Report[C_SUP]" "MANAGER" "${noOfPages}" N

exit 0
