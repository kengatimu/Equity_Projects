#==============================================================================#
# Source name       : StaffMasking_54.com
# Author            : Ichangai James 
# Date              : 26-APR-2025
# Description       : Com file to execute Staff accounts Masking
#
# Calling Sources   : Batch_Job-MASKS
# Modification History:
#==============================================================================#
exec bauu9151 StaffMasking_54.sql

if [ $? -ne 0 ]
then
#{
         echo "Com execution failed"
		 #}
		  fi


		  exit 0
