d1=$(date +%d/%m/%Y)
echo Current Date : "$d1"
dt=`TZ=GMT+24 date +%d/%m/%Y`;
echo Audit Batch Run for the date : "$dt"
echo AuditXMLReader.sh "$dt;$dt;"
/finacle/AUDIT/EK06875/Audit/install/50/AuditXMLReader.sh "$dt;$dt;"