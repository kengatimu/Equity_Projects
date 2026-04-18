#------------------------------------------------------------------------------------------------
#    Name                        : directdebitdp005.com 
#    Description     :
#    Date            : 15-08-2013
#    Author          : SUHASINI 
#    Input           : NA
#    Output                      : NA
#    Called Script       : NA
#    Calling Script      : NA
#    Menu Option         : CDDUM
#    Srl. No                    Date                    Author                  Description.
#    ------                     ----------                      -------                 ---------------
#-----------------------------------------------------------------------------------------------
#. `execom commfunc.com`
tempfile="KBA_Directdebit_${$}.TXT"
#----------------------------------------------------------------------------------------
#       SQL Execution
#----------------------------------------------------------------------------------------
#sed 's/$/'${1}'/g' ${4}${5}  > $tempfile
sed 's/^\(.\{158\}\)/\1'$1\/ ${4}${5}  > $tempfile
$ORACLE_HOME/bin/sqlldr ${2} control= "$3" data=$tempfile

exit 0
