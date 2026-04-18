#=================================================================================================================*
# Name                          :   stmtchrgdp001.com
# Date                          :   25-02-2013
# Description                   :   This com is used to generate the txt file .
# Author                        :   Saurabh Sinha
# Reference                     :
# Modification History  :
#  <Serial No.>  <Date>         <AuthorName>            <Description>
#--------------------------------------------------------------------------
#   1           25-02-2013      Saurabh Sinha               Original version
#=================================================================================================================*
custpath=$2
tempFile="stmtchrgTemp${$}.txt"
fileName=$(echo $custpath | cut -d "|" -f 1)
bankId=$(echo $custpath | cut -d "|" -f 2)
fileName1=$(echo $custpath | cut -d "|" -f 3)

x="\""
if [ -f $fileName ]
then
#{
#        cp $fileName .
#       sed 's/$/,'$bankId'/g' $fileName > $tempFile
#	cp $tempFile $fileName1 
	echo "CUST.STMTCHRG.fileExist="$x"Y"$x >>$1
#}
else
#{
	echo "CUST.STMTCHRG.fileExist="$x$x >> $1
#}
fi

