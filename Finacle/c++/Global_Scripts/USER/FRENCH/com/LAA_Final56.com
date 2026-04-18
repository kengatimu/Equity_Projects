input="$1"

exebatch bauu9151 LAA_Final43.sql "$1"

if [ $? -ne 0 ]
then
        echo "SQL Procedure Execution Failed."
        exit 1
fi