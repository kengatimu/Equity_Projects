#=================================================================================================================*
# Name                          :   mbillsuplddp001.com
# Date                          :   17-02-2013
# Description                   :   This com is used to generate the txt file .
# Author                        :   Chethan.S
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           17-02-2013      Chethan.S               Original version
#=================================================================================================================*
custpath=$2
fileName=$(echo $custpath | cut -d "|" -f 1)
bankId=$(echo $custpath | cut -d "|" -f 2)
fileName1=$(echo $custpath | cut -d "|" -f 3)
tempFile="TempMBill.txt"
x="\""
if [ -f $fileName ]
then
#{
	echo "CUST.BILLS.fileExist="$x"Y"$x >>$1
	cp $fileName . 
        sed 's/$/|'$bankId'/g' $fileName > $tempFile
        cp $tempFile $fileName1
#}
else
#{
	echo "CUST.BILLS.fileExist="$x$x >> $1
#}
fi
