
reportFileName=$2".lst"

bauu9151 uddsdirectdebitmn002.sql $1 $3
if [ $? -ne 0 ]
then
        echo "SQL execution failed !"
        exit 1
fi

noOfPages=`grep -c "^L" "$reportFileName"`
noOfPages=`expr "${noOfPages}" + 1`
babx4040 "${B2K_SESSION_ID}" "$reportFileName" "DDS Upload Report" "MANAGER" "${noOfPages}" N

