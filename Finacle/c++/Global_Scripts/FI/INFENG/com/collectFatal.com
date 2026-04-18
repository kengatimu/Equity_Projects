#-----------------------------------------------------------------------------------------------------
# Script name           : collectFatal.com
# Author                : Kaushik M N & Anshul Singh 
# Date                  : 26-JUN-2016 
# Desc                  : This script is used to collect the fatal log files from EOD users directory
#                         and send the Fatal Log Report to Configured Mail Ids
# Associated Objects    : NA
# Bank                  : UBA Bank
# Flow of Script        : Called from the collectFatal.scr
#-----------------------------------------------------------------------------------------------------


BOLD=`tput smso`
UNBOLD=`tput rmso`

clear
#-----------------------------------------------------------------------------------------------------
# Below BASE_ROOT is path to search fatal.log and fatal_info.log files recursively
#-----------------------------------------------------------------------------------------------------
BASE_ROOT="/finacle/EQPRODFI/BackEnd/Finacle/FC/app/CDCI_LOGS"; export BASE_ROOT
usrpth="$1"
echo usrpth
bankId="$2"
bodDate="$3"

fatal=fatal_`date +%d_%m_%Y_%H_%M_%S`

echo "\n\n\t\t $BOLD Gathering falal.log and fatal_info.log $UNBOLD \n\t\t"

#-----------------------------------------------------------------------------------------------------
# The funcation will create the new directory with following date and time format
# Format : fatal_<DD>_<MM>_<YYYY>_<HH>_<MM>_<SS>
#-----------------------------------------------------------------------------------------------------
func_Dir_Create()
{
        if [ ! -d ${BASE_ROOT}/$1 ]
        then
           mkdir ${BASE_ROOT}/$1
        fi
        if [ -f ${BASE_ROOT}/$1/fatal_file.lst ]
        then
           rm -rf ${BASE_ROOT}/$1/fatal_file.lst
        fi
}

#-----------------------------------------------------------------------------------------------------
# Call for function "func_Dir_Create"
#-----------------------------------------------------------------------------------------------------

func_Dir_Create $fatal

#Get all fatal.log and fatal_info.log from all directory

echo "\n\n\t\t Collecting path information.. Please wait........... \n\t\t"

#-----------------------------------------------------------------------------------------------------
# The function will create the new directory with following date and time format
#-----------------------------------------------------------------------------------------------------
cd ${BASE_ROOT}
find . -name 'fatal*.log'>>${BASE_ROOT}/$fatal/fatal_file.lst
cd ${BASE_ROOT}

file="${BASE_ROOT}/$fatal/fatal_file.lst"
while read file
do
        path=${file#./}
        echo "\n\n\t\t Processing file : ${BASE_ROOT}/$path \n\t\t"
        log_file=`echo $path | sed 's/\//_/g'`
        cp $BASE_ROOT/$path ${BASE_ROOT}/$fatal/$log_file
	#mv $usrpth/$path $usrpth/$path"_"$3
	
done <"$file"


        if [ -f ${BASE_ROOT}/$fatal/Fatals_Report.txt ]
        then
           rm -rf ${BASE_ROOT}/$fatal/Fatals_Report.txt
        fi

touch ${BASE_ROOT}/$fatal/Fatals_Report.txt
for i in ${BASE_ROOT}/$fatal/*.log
do
	echo "**************************************************************************************************" >> ${BASE_ROOT}/$fatal/Fatals_Report.txt
        cat $i >> Fatals_Report.txt
        echo "**************************************************************************************************" >> ${BASE_ROOT}/$fatal/Fatals_Report.txt	

done <"$file"

if [ -s Fatals_Report.txt ]
then 
	echo "Fatals exists";
	#zip -r Fatal-Logs.zip $fatal;
	#echo "\n\n\t\t File Zipped Successfully in path : $BOLD${BASE_ROOT}/$fatal$UNBOLD \n\n\n\n";
	#(echo "Dear Team,\n\nPFA the list of fatals occurred during EOD.\n\nThanks and Regards,\nInfosys Team"; uuencode  Fatals_Report.txt Fatals_Report.txt; uuencode Fatal-Logs.zip Fatal-Logs.zip ) | mail -s "UBA | EOD Fatal Log Report of $2 for BOD Date : $3" mail_id@domainName.com
fi

#echo "\n\n\t\t Fatal Log Report Mail has been sent to ubagroup.com \n\n\n\n"
#-----------------------------------------------------------------------------------------------------
