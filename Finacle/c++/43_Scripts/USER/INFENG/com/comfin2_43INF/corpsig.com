#===============================================================================
#Source Name	: corpsig.com
#Description	: Perform validations before SVS upload
#Input Values	: XLS file name
#Output Values	: Nil
#Called Scripts	: Nil
#Calling Scripts	: corpsig.scr
#Modification history:
#   Sl. No		Date		Author			Description
#    ---------	--------------	----------------------------	----------------
#      1		12-11-2012	Jithu Teresa Joseph		Migration to 10.x
#===============================================================================

userId=$2
corpimgLoc=$DAILY_UPLOAD/upload/corpimg
cd $corpimgLoc

# Change in File Naming convention - 30.09.2004 - Lalitha
oldFileNum=`cat /svs/corpimgNum.dat`
if [ ${oldFileNum} -eq 9999 ]
then
        oldFileNum=0
fi
FileNum=`expr ${oldFileNum} + 1 | awk '{printf("%04s\n", $1)}'`
echo "${FileNum}" > /svs/corpimgNum.dat
FileName=${CDCI_DC_ALIAS}_`date '+%y%m%d'_$FileNum`
####

cnt=0
cntMax=10
cntLim=200

ls *.tif *.TIF>Tmp 2>/dev/null
sed "s/^/.\\//" Tmp>Tmp1
cntTot=`cat Tmp1|wc -l|tr -d '[:space:]'`

rm -f svsuplfile_corpsig_${userId}.txt*

while [ $cnt -lt $cntTot ]
do
    cat Tmp1|head -$cntLim >Tmp11 2>/dev/null
    cntTmp1=`cat Tmp1|wc -l`
    mv ./Tmp111 ./Tmp1
    $TBA_PROD_ROOT/cust/INFENG/exe/corpsig Tmp11 $B2K_SESSION_ID $userId $corpimgLoc
	echo `cat tempinput_corpsig_${userId}.txt|wc -l|tr -d '[:space:]'` > svsuplfile_corpsig_${userId}.txt

	i=1
	Tmpcnt=`cat $corpimgLoc/svsuplfile_corpsig_${userId}.txt`
	Tmpcnt=`expr $Tmpcnt + 1`

	while [ $i -lt ${Tmpcnt} ]
	do
		echo `head -$i tempinput_corpsig_${userId}.txt | tail -1` >> svsuplfile_corpsig_${userId}.txt
		i=`expr $i + 1`
	done
	rm -f tempinput_corpsig_${userId}.txt

    cat corpsig_${userId}.res|awk '{FS=">"}{print $2}'|sed '/^$/d'>Tmp2
    sed "s/^/\\\mv /" Tmp2 > Tmp4
    chmod 755 Tmp4
    ./Tmp4
    if [ -f corpsig_${userId}.res ]
    then
        perl -i -pe 's/\.\///' corpsig_${userId}.res
        if [ -f s$FileName_${userId}.suc ]
        then
            cat corpsig_${userId}.res >> s$FileName_${userId}.suc
            /bin/rm -f corpsig.res
        else
            mv corpsig_${userId}.res s$FileName_${userId}.suc
            if [ $? -ne 0 ]
            then
                echo "Problem in renaming the file corpsig_${userId}.res"
                exit 0
            fi
        fi
    fi
    if [ -f corpsig_${userId}.err ]
    then
        perl -i -pe 's/\.\///' corpsig_${userId}.err

        if [ -f s$FileName_${userId}.fat ]
        then
            cat corpsig_${userId}.err >> s$FileName_${userId}.fat
            /bin/rm -f corpsig_${userId}.err
        else
            mv corpsig_${userId}.err s$FileName_${userId}.fat
            if [ $? -ne 0 ]
            then
                echo "Problem in renaming the file corpsig_${userId}.err"
                exit 0
            fi
        fi
    fi
    cnt=`expr $cnt + $cntLim`
done
mv s$FileName_${userId}.suc s$FileName_${userId}.res
mv s$FileName_${userId}.fat s$FileName_${userId}.err
/bin/rm -f Tmp*
