#############################################################################
#       Name                    :  HGRST_eod_batch.com
#       Date                    :  11-11-2019
#       Description             :  Com script for HGRST_eod_batc
#       Input                   :  Sol Id
#       Output                  :  NA
#       Author                  :
#       Called Script           :
#       Calling Script          :  HGRST_eod_batch.scr
#       Reference               :  NA
#       Modification History    :
#                                                               <Serial No.>  <Date>     <Author Name>  <Description>
#                                                                       01
#
#############################################################################
JobId=$B2K_SESSION_ID
solid=$1
echo $solid >> inp.DAT
exebatch fxbx4005 $B2K_SESSION_ID < ./inp.DAT
if [ $? -ne 0 ]
then
        echo "Execution Failed.Unable to generate  Report"
exit 2
fi
rm -f ./inp.DAT
exit

