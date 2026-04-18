#=================================================================================================================*
# Name                          :   eqlaauplddp001.com
# Date                          :   25-02-2013
# Description                   :   This com is used to generate the txt file .
# Author                        :   Samrat Saha
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           23-02-2013      Samrat Saha              Original version
#	2			03-06-2013		Samrat Saha				 Added Code to dynamically append bank Id to Data file
#=================================================================================================================*
custpath=$2
tempFile=eqtemp.txt

fileName=$(echo $custpath | cut -d "|" -f 1) 
bankId=$(echo $custpath | cut -d "|" -f 2) 
fileName1=$(echo $custpath | cut -d "|" -f 3)


x="\""
if [ -f $fileName ]
then
#{
	cp $fileName . 
	sed 's/$/|'$bankId'/g' $fileName > $tempFile
	cp $tempFile $fileName1
	echo "CUST.EQUPLD.fileExist="$x"Y"$x >>$1
    
#}
else
#{
    echo "CUST.EQUPLD.fileExist="$x$x >> $1
#}
fi
