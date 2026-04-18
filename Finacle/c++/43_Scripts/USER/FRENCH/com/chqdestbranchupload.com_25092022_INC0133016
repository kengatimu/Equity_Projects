#Set POI_API_PATH to CLASSPATH
#echo $CLASSPATH
echo "$1   $2   $3   $4   $5    $6">test.txt
set -vx
#export CLASSPATH=./:$POI_API_PATH:$CLASSPATH
callType=$1
        # $2-xlsfile, $3-xmlfile, $4-datfile $5-resultxls
        $JAVA_HOME/bin/java upload.service.ExcelConvertor $2 $3 $4 $5 $6
echo $4>>test.txt
cat $4>test1.txt
i=`wc -l $4`
echo "number of lines in csv $i">>test.txt
j=1
while [ $j -le $i ]
do
echo $j>>test.txt
req=`head -$j $4|tail -1|cut -c1-11`
start=`head -$j $4|tail -1|cut -c128-137`
end=`head -$j $4|tail -1|cut -c138-147`
sentdestbrnch=`head -$j $4|tail -1|cut -c323-`
echo $start>>test3.txt
echo $end>>test3.txt
#b=`expr $start + 1 2>/dev/null`
#if [ $? -ne 0 ]
#then
#echo "inside the start numeric check">test2.txt
#start=""
#fi
#b=`expr $end + 1 2>/dev/null`
#if [ $? -ne 0 ]
#then
#echo "inside the end numeric check">>test2.txt
#end=""
#fi
#if [ ${sentdestbrnch} == "YES" -o ${sentdestbrnch} == "Yes" -o ${sentdestbrnch} == "y" -o ${sentdestbrnch} == "Y" ]
#then
echo "UPDATE CUSTOM.CUSTOM_CBR SET REQ_STATUS='B' WHERE BANK_ID='$7' AND REQ_ID=rtrim('$req');">>upload_destbrnch.sql
echo "commit;">>upload_destbrnch.sql
#fi
let j=$j+1
done

if [ -s upload_destbrnch.sql ]
then
echo "sql exec">>test.txt
        echo "inside execute script"
                exebatch bauu9151 upload_destbrnch.sql
fi

