#===============================================================================
#Source Name    : nomacctcrdp003.com
#Description    : calls nomacctcrdp002.scr 
#Input Values   : - 
#Output Values  : Nil
#Called Scripts : Nil
#Calling Scripts        : nomacctcrdp002.scr 
#Modification history:
#   Sl. No              Date            Author                  Description
#    ---------  --------------  ----------------------------    ----------------
#===============================================================================


babx4061 $B2K_SESSION_ID nomacctcrdp002.scr ""
if [ $? -ne 0 ]
then
	echo "SQL  execution failed !"
	exit
fi	
