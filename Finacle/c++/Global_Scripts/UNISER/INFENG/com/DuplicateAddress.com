#------------------------------------------------------------------------------------------------------------------    
#	Name			: DuplicateAddress.com
#	Description		: It will Delete and backup duplicate address
#	Date			: 04-06-2021
#	Author			: Irungu James
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			04-06-2021		Irungu James		Original Version
#--------------------------------------------------------------------------------------------------------------------
#. `execom commfunc.com`
 input="$1"
 input1="$2"

bauu9151 DuplicateAddress.sql "$1" "$2"
if [ $? -ne 0 ]
then
#{
echo "Script execution failed"
#}
fi
exit 0
