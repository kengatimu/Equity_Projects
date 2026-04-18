#Set POI_API_PATH to CLASSPATH
#echo $CLASSPATH
CLASSPATH=$PLIB/xl_core_api.jar:$PLIB/poi-3.8-20120326.jar:$PLIB/commons-io-2.1.jar:$PLIB/dom4j-1.6.jar:$PLIB/encdec.jar:$PLIB/poi-ooxml-3.8-20120326.jar:$PLIB/poi-ooxml-3.8-20120326.jar:$PLIB/poi-scratchpad-3.8-20120326.jar:$PLIB/xmlbeans-2.3.0.jar:$PLIB/poi-3.8-20120326.jar:$PLIB/poi-ooxml-schemas-3.8-20120326.jar:$CLASSPATH
export CLASSPATH
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
i=$(echo $i | tr -cd '[[:digit:]]')
j=1
while [ $j -lt $i ]
do
#{
	echo $j>>test.txt
	req=`head -$j $4|tail -1|cut -c1-11`
	start=`head -$j $4|tail -1|cut -c128-137`
	end=`head -$j $4|tail -1|cut -c138-147`

	echo $start>>test3.txt
	echo $end>>test3.txt
	b=`expr $start + 1 2>/dev/null`

	if [ $? -ne 0 ]
	then
		echo "inside the start numeric check">test2.txt
		start=""
	fi

	b=`expr $end + 1 2>/dev/null`

	if [ $? -ne 0 ]
	then
		echo "inside the end numeric check">>test2.txt
	end=""
	fi

	if [ ${start} != "" -a ${end} != "" ]
	then
		echo "UPDATE CUSTOM.CUSTOM_CBR SET REQ_STATUS='R' WHERE BANK_ID='$7' AND REQ_ID=rtrim('$req') AND REQ_STATUS IN ('S','R');">>uploadxls.sql
		echo "commit;">>uploadxls.sql
	fi

    let j=$j+1

#}
done

if [ -s uploadxls.sql ]
then
echo "sql exec">>test.txt
        echo "inside execute script"
                exebatch bauu9151 uploadxls.sql
fi

