custpath=$2
x="\""
fileName=$(echo $custpath | cut -d "|" -f 1)
bankId=$(echo $custpath | cut -d "|" -f 2)
fileName1=$(echo $custpath | cut -d "|" -f 3)
tempFile="TempDDUM.txt"
if [ -f $fileName ]
then
#{
        echo "CUST.CDDUM.fileExist="$x"Y"$x >>$1
	cp $fileName .
#        sed 's/$/'$bankId'/g' $fileName > $tempFile
#        cp $tempFile $fileName1
#}
else
#{
        echo "CUST.CDDUM.fileExist="$x$x >> $1
#}
fi

