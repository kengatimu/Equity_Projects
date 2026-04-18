#---------------------------------------------------------------------------------
#--    File Name                  : Bchq_BkDwn.com
#--    Date                       : 01.03.2013
#--    Author                     : Gokulkrishna
#--    Assumptions                : NIL
#--    Modification History    :
#--    <Serial No.>    <Date>        <Author Name>                <Description>
#--       1.          01.03.2013     Gokulkrishna                  Original Version
#-----------------------------------------------------------------------------------
set -vx
. `execom commfunc.com`

#trap '' 2 3
#input="$1"
Report="Bankers Chq Code Maintenance"
RptFile="CHEQBKDNLD_$$"
lstFile="CHEQBKDNLD_$$.lst"
lstFile1="CHEQBKDNLDTEMP_$$.lst"
seq=`echo $1|cut -d"," -f1|cut -d"_" -f3|cut -d"." -f1`
if [ $3 -eq 43 ]
then
echo "inside 43" > test.txt
	lstFile2=EQT$seq.DAT
elif [ $3 -eq 11 ]
then
	lstFile2=EQS$seq.DAT
elif [ $3 -eq 55 ]
then
	lstFile2=ETZ$seq.DAT
elif [ $3 -eq 56 ]
then
echo "inside 56" > test.txt
	lstFile2=EQU$seq.DAT
fi

userid=`pwd|awk -F "/" '{print $NF}'`
upldpath="${UPLOAD_INPUT_FILE_PATH}/${userid}"

test -d $FIN_REPORTS_DIR/${userid}
if [ $? -ne 0 ]
then
        mkdir $FIN_REPORTS_DIR/${userid}
fi

echo $1 $2 $3 $4 > val.txt
echo "calling sql" >> test.txt
bauu9151 $TBA_PROD_ROOT/cust/INFENG/sql/Bchq_BookDwnload.sql  $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} > ${lstFile}
echo "after calling sql" >> test.txt
#bauu9151 pamodule1/BE/Finacle/FC/app/cust/INFENG/sql/Bchq_BookDwnload.sql  $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} > $lstFile
echo $1 $2 $3 $4 $5 $6 $7 $8 $9 ${10} ${11} ${12} ${13} ${14} ${15} ${16} > val1.txt
sed '/^$/d' $lstFile > ${lstFile1}
sed 's/\~/ /g' $lstFile1 > $lstFile
echo "changing the filename" >> test.txt
mv $lstFile $lstFile2
#cp ${lstFile} $FIN_REPORTS_DIR/${userid}/${lstFile}
cp ${lstFile2} $FIN_REPORTS_DIR/${userid}/${lstFile2}

#babx4040 ${B2K_SESSION_ID} "$FIN_REPORTS_DIR/${userid}/${lstFile}" "$Report" "MANAGER" "1" "N"
babx4040 ${B2K_SESSION_ID} "$FIN_REPORTS_DIR/${userid}/${lstFile2}" "$Report" "MANAGER" "1" "N"

if [ $? -ne 0 ]
then
    echo "Report Generated. To View/Print, Use HPR Menu."
fi
exit 0

