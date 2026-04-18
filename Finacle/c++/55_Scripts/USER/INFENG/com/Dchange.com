#------------------------------------------------------------------------------------------------------------------    
#	Name			: Dchange.com
#	Description		: Date change batch 
#	Date			: 07-01-2019
#	Author			: Irungu James
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0			07-01-2019		Irungu James			Original Version
#--------------------------------------------------------------------------------------------------------------------
. `execom commfunc.com`
set -vx
input="$1"
input="$2"
input="$3"
input="$4"
input="$5"
input="$6"
input="$7"
input="$8"
input="$9"

 bauu9151 Dchange.sql "$1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9"
 
exit 0

