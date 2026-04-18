#------------------------------------------------------------------------------------------------------------------    
#	Name			: SALARY_BPP.com
#	Description		: It will generate a bad and log file report
#	Date			: 13-03-2013
#	Author			: GOKULKRISHNA
#	Input			: NA
#	Output			: NA
#	Srl. No			Date			Author			Description.   
#	-------			---------		-------			---------------			
#	1.0				13-03-2013		GOKULKRISHNA	Original Version
#	2.0				05-07-2013		Bharath			Removed commened lines
#--------------------------------------------------------------------------------------------------------------------
input="$1"

TimeComp=`date| tr -s " " | cut -f4 -d" " |sed 's/://g' `
DateComp=`date| tr -s " " | cut -f2,3 -d" " |sed 's/ //g' `

log_file=$input"_salary_process"$TimeComp".log"
bad_file=$input"_salary_process"$TimeComp".bad"

$ORACLE_HOME/bin/sqlldr $2 control= "$3salary.ctl" data= "$4" LOG=$log_file BAD=$bad_file

exit 0

