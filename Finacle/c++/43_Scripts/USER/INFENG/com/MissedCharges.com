#------------------------------------------------------------------------------------------------------------------    
#	Name			: MissedCharges.com
#	Description		: It will Insert data for missed NP charges 
#	Date			: 21-03-2021
#	Author			: Irungu James
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				12-02-2013		GOKULKRISHNA			Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
 input="$1"
 input1="$2"

bauu9151 MissedCharges.sql "$1" "$2"
if [ $? -ne 0 ]
then
#{
echo "Script execution failed"
#}
fi
exit 0
