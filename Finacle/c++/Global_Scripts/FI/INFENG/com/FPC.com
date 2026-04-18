#------------------------------------------------------------------------------------------------------------------    
#	Name			: FPC.com
#	Description		: It will Create FPC record
#	Date			: 12-10-2022
#	Author			: Irungu James
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			12-10-2022		Irungu James		Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
 input="$1"
 input1="$2"

bauu9151 FPC.sql "$1" "$2"
if [ $? -ne 0 ]
then
#{
echo "Script execution failed"
#}
fi
exit 0
