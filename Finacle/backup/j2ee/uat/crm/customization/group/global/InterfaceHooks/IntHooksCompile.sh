

# $Author: Jamuna G$
# To compile the java files

set file_Path=$1

if [$file_Path -eq ""] ;then javac  *.java 
else
javac $file_Path
fi





