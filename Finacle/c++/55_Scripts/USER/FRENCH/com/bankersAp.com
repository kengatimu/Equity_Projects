#--------------------------------------------------------------------------------------------------------    
#    Name			 : bankersAp.com
#    Description     : This file is used to generating the spool file for the excution of th exe file. 
#    Date            : 04-03-2013
#    Author          : Prakash
#    Input           : NA
#    Output			 : NA
#    Called Script	 : NA
#    Calling Script	 : NA
#    Menu Option	 : CBCHAP
#    Srl. No			Date			Author			Description.   
#    ------			----------			-------			---------------			
#    1.0			04-03-2013			Prakash			Original Version
#-----------------------------------------------------------------------------------------------------------

datFile="datfile.dat"

$TBA_E/bauu9151 ApBankersCheque.sql $1 
echo $1 $2 $3 $4 > p.lstxh
#echo 'MANAGER BI' BCHUPLOAD.TXT $2 $4 $3 'ddupload.scr ddupload.mrt dduploadfail.mrt {~~~NULL!~~~}' > $datFile
#$TBA_E/mcbx4024 $B2K_SESSION_ID < ./$datFile

#modified by anuya to make the file compatible to 10.2.18
echo "BCHUPLOAD.TXT $2 $3
MANAGER BI BCHUPLOAD.TXT $2 $4 $3 ddupload.scr ddupload.mrt dduploadfail.mrt {~~~NULL!~~~}
 report_to tran_sub_type inp_file_name fire_bfti_flg remarks rename_inp_file h_script_name h_mrt_success h_mrt_fail rmi
" > $datFile
cp $datFile bankersAp.dat
mcbx4024 $B2K_SESSION_ID < bankersAp.dat
echo `head -1 TRAN_INFO.dat` >> bankersAp.txt
a=`head -1 TRAN_INFO.dat`

exit 0
