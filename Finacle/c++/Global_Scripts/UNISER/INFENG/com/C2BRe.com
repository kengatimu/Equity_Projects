echo $1 
echo $2
response=$(java -jar $2) 
echo $response 
echo "CUST.DATA.ResXml=\"${response}\"" > $1
