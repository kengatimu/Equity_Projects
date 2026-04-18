#==============================================================================#
# Source name       : eabup.com
# Author            : Patchirajan. 
# Date              : 20-FEB-2017
# Description       : Com file to execute EAB-GST update batch job using
#                       genlimo
#
# Calling Sources   : eabbatch001.scr
# Modification History:
#==============================================================================#
exec babx4061 $B2K_SESSION_ID eabbatch001.scr

if [ $? -ne 0 ]
then
#{
         echo "Script execution failed"
		 #}
		  fi


		  exit 0
